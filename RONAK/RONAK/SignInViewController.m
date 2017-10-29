//
//  SignInViewController.m
//  RONAK
//
//  Created by Gaian on 7/14/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#define  default(value,key) [[NSUserDefaults standardUserDefaults]setValue:value forKey:key]

#import "SignInViewController.h"


@interface SignInViewController ()<TOPasscodeViewControllerDelegate>

@end

@implementation SignInViewController{
    
  
    ServerAPIManager *serverAPI;
    LoadingView *load;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    serverAPI=[ServerAPIManager sharedinstance];
    load =[[LoadingView alloc]init];
    [self defaultUserNameandPasswordSave:NO load:YES delete:NO];
     NSArray *arr= [UIFont fontNamesForFamilyName:@"Gotham"];
    NSLog(@"%@",arr);
    [self defaultStyles];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(unzippedSuccess) name:unzipedItemsSuccess object:nil];
    
    
    if(![fileManager fileExistsAtPath:[docPath stringByAppendingString:@"IMAGES"]])
    {
        [fileManager createDirectoryAtPath:[docPath stringByAppendingString:@"IMAGES"] withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if(![fileManager fileExistsAtPath:[docPath stringByAppendingString:@"IMAGES/ITEM IMAGES"]])
    {
        [fileManager createDirectoryAtPath:[docPath stringByAppendingString:@"IMAGES/ITEM IMAGES"] withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if(![fileManager fileExistsAtPath:[docPath stringByAppendingString:@"IMAGES/ITEM IMAGES/GU 6739 BLK-35item1.jpg"]])
    {
        [fileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"GU 6739 BLK-35item1" ofType:@"jpg"] toPath:[docPath stringByAppendingPathComponent:@"IMAGES/ITEM IMAGES/GU 6739 BLK-35item1.jpg"] error:nil];
    }
    if(![fileManager fileExistsAtPath:[docPath stringByAppendingString:@"IMAGES/ITEM IMAGES/GU 6739 BLK-35item2.jpg"]])
    {
        [fileManager copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"GU 6739 BLK-35item2" ofType:@"jpg"] toPath:[docPath stringByAppendingPathComponent:@"IMAGES/ITEM IMAGES/GU 6739 BLK-35item2.jpg"] error:nil];
    }
}
-(void)unzippedSuccess
{
    defaultSet(@"success", unzipedItemsSuccess);
}

-(void)defaultStyles
{
    _emailTf.font =gothMedium(17.0f);
    _passwordTF.font=gothMedium(17.0f);
    _loginBtn.titleLabel.font=gothMedium(17.0f);
    _forgtPwdBtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    _loginBtn.titleLabel.font=[UIFont systemFontOfSize:17.0f];
    
    [_passwordTF setLeftpasswordPadding];
    [_emailTf setLeftpasswordPadding];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)defaultUserNameandPasswordSave:(BOOL)save load:(BOOL)loadi delete:(BOOL)delete
{
    if(save)
    {
        default(_emailTf.text, savedUserEmail);
        default(_passwordTF.text, savedUserPassword);
    }
    if(loadi)
    {
        if(defaultGet(savedUserPassword)&&defaultGet(savedUserEmail))
        {
            _emailTf.text=defaultGet(savedUserEmail);
            _passwordTF.text=defaultGet(savedUserPassword);
        }
        
    }
}

- (IBAction)loginClick:(id)sender {
    
    if(_emailTf.text.length>0&&_passwordTF.text.length>0)
    {
        [self getAccessToken];
        [load loadingWithlightAlpha:self.view with_message:@""];
        [load start];
        [self defaultUserNameandPasswordSave:YES load:NO delete:NO];
    }
    else
    {
        [load waringLabelText:@"Fields should not be empty" onView:self.view];
    }
    
}
- (IBAction)forgtPasswordClick:(id)sender {
}

#pragma mark Get access Token
-(void)getAccessToken{
    
    NSString *bodyStr =[NSString stringWithFormat:@"client_id=%@&RedirectURL=%@&grant_type=password&username=%@&password=%@",rest_clientID_B,rest_redirectURI_B,_emailTf.text,_passwordTF.text];
    [serverAPI getAuthTokenPath:rest_generateToken_B bodyString:bodyStr SuccessBlock:^(id responseObj)
    {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        if(dict[@"access_token"])
        {
            defaultSet(dict[@"access_token"], kaccess_token);
            dispatch_async(dispatch_get_main_queue(), ^{
                [load stop];
                [self gotoMenu];
            });

        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [load stop];
                showMessage(@"Invalid user name & Password ", self.view);
            });
            
        }
            NSLog(@"authToken Dictionary-->%@",dict);
        
        } andErrorBlock:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [load stop];
                [load waringLabelText:@"Invalid user name & Password " onView:self.view];
            });
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
//    if(![defaultGet(unzipedItemsSuccess) isEqualToString:@"success"])
//    {
//        NSURL *url=[NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/smo4q5reh1yo0qq/ITEM%20IMAGES.zip?dl=0"];
//        [UnzipViewController presentResourcesViewController:self withTitle:@"Loading" URL:url completion:nil];
//    }
    
    if(defaultGet(savedUserEmail)&&defaultGet(savedUserPassword))
    {
        [self gotoMenu];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:unzipedItemsSuccess];

}
-(void)gotoMenu
{
    [load stop];
    MenuViewController *menuVC=[self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    SignInViewController *sign=self;
    [sign.navigationController pushViewController:menuVC animated:YES];
    
    NSLog(@"Self:%@--\nInstance:%@--\nnavCont:%@--\n:%@",self,sign,self.navigationController,self.navigationController);
//    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:menuVC];
//    [self.navigationController pushViewController:menuVC animated:YES];
}
@end
