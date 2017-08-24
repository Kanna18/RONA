//
//  AllFiltersViewController.m
//  RONAK
//
//  Created by Gaian on 8/12/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "AllFiltersViewController.h"
@interface AllFiltersViewController ()

@end

@implementation AllFiltersViewController{
    
    ServerAPIManager *serverAPI;
    RESTCalls *rest;
    LoadingView *load;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    serverAPI=[ServerAPIManager sharedinstance];
    rest=[[RESTCalls alloc]init];
    load=[[LoadingView alloc]init];
    
    for (int i=0; i<[[RONAKSharedClass sharedInstance].selectedCustomersArray count]; i++)
    {
        CustomerDataModel *cst=[RONAKSharedClass sharedInstance].selectedCustomersArray[i];
        NSLog(@"%@",cst.defaultsCustomer.defaultAddressIndex);
    }
    
}


-(void)restServiceForProductList
{
    NSDictionary *headers=@{@"content-type":@"application/x-www-form-urlencoded (OR) application/json",
                            @"authorization":[NSString stringWithFormat:@"Bearer %@",defaultGet(kaccess_token)]};
    
    [serverAPI  processRequest:rest_ProductList_B params:nil requestType:@"GET" cusHeaders:headers successBlock:^(id responseObj) {
        
        NSString *dictstr=[NSJSONSerialization JSONObjectWithData:responseObj options: NSJSONReadingAllowFragments error:nil];
        NSData *jsonData=[dictstr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *cerr;
        [rest writeJsonDatatoFile:jsonData toPathExtension:productFilePath error:cerr];
        
    } andErrorBlock:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [load stop];
            [load waringLabelText:@"Error Loading" onView:self.view];
            
        });
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)homeClick:(id)sender {
}

- (IBAction)advancedClicks:(id)sender {
}
@end
