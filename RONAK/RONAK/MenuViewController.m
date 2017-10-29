//
//  MenuViewController.m
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "MenuViewController.h"
#import "DownloadProducts.h"
#import "SignInViewController.h"
#import "CustomersViewController.h"
#import <Crashlytics/Crashlytics.h>


@interface MenuViewController ()<FetchedAllProducts,TOPasscodeViewControllerDelegate>

@end

@implementation MenuViewController{
    
    LoadingView *load;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultComponentsStyle];
    
//    DownloadProducts *dwn=[[DownloadProducts alloc]init];
//    [dwn downloadImagesandSavetolocalDataBase];
    
   if(!defaultGet(firstTimeLaunching))
   {
       load=[[LoadingView alloc]init];
       [load loadingWithlightAlpha:self.view with_message:@"Fetching......."];
       [load start];
       DownloadProducts *dwn=[[DownloadProducts alloc]init];
       dwn.delegateProducts=self;
       [dwn downloadCustomersListInBackground];
       [dwn downloadStockWareHouseSavetoCoreData];
   }
   else
   {
       static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self getFetchFiltersAfteDataFetched];
        });
    }
    for (CustomButton *btn in self.view.subviews)
    {
        if([btn isKindOfClass:[CustomButton class]])
        {
            btn.titleLabel.font=gothMedium(15);
        }
    }
}


-(void)getFetchFiltersAfteDataFetched
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSManagedObjectContext *contextChild1=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        contextChild1.parentContext=ronakGlobal.context;
        DownloadProducts *dw=[[DownloadProducts alloc]init];
        [dw getFilterFor:@"brands__c" withContext:contextChild1];
    });
}

#pragma mark Downloading Products Protocol
-(void)productsListFetched
{
    [load stop];
    defaultSet(@"Launched", firstTimeLaunching);
    [self getFetchFiltersAfteDataFetched];
    
}

-(void)viewWillAppear:(BOOL)animate
{
    [ronakGlobal.selectedCustomersArray removeAllObjects];
    [ronakGlobal.selectedFilter clearAllFilters];
    //[ronakGlobal.selectedFilter.wsPriceMinMax setValue:@"1" forKey:@"Min"];
    //[ronakGlobal.selectedFilter.priceMinMax setValue:@"1" forKey:@"Min"];
    [ronakGlobal.selectedFilter.stockMinMax setValue:@"1" forKey:@"Min"];
    
    [super viewWillAppear:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
//    for (CustomButton *cst in self.view.subviews)
//    {
//        if([cst isKindOfClass:[CustomButton class]])
//        {
//            cst.frame=CGRectMake(100, 100, 30, 30);
//        }
//    }
    [UIView commitAnimations];
}

-(void)defaultComponentsStyle
{
    [_activity setBackgroundImage:[UIImage imageNamed:@"BtnHilighted"] forState:UIControlStateHighlighted];
    [_bookOrder setBackgroundImage:[UIImage imageNamed:@"BtnHilighted"] forState:UIControlStateHighlighted];
    [_reports setBackgroundImage:[UIImage imageNamed:@"BtnHilighted"] forState:UIControlStateHighlighted];
    [_logout setBackgroundImage:[UIImage imageNamed:@"BtnHilighted"] forState:UIControlStateHighlighted];
        
    
//    [_logout setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://konlinejobs.com/wp-content/uploads/2017/02/tom-and-jerry-best-friends-free-hd-wallpaper.jpg"]]] forState:UIControlStateNormal];
    
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

- (IBAction)bookOrder_click:(id)sender {
    
    CustomersViewController *cmc=storyBoard(@"customerVC");
    [self.navigationController pushViewController:cmc animated:YES];
}

- (IBAction)reports_click:(id)sender {
}

- (IBAction)activity_click:(id)sender {
}

- (IBAction)logout_click:(id)sender {
    
    SignInViewController *signIN=[self.storyboard instantiateViewControllerWithIdentifier:@"signInVC"];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:signIN];
    [self presentViewController:nav animated:YES completion:nil];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:savedUserPassword];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:savedUserEmail];
    
}
@end
