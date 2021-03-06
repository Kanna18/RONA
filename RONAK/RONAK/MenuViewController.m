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

@interface MenuViewController ()<FetchedAllProducts>

@end

@implementation MenuViewController{
    
    LoadingView *load;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self defaultComponentsStyle];

    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       DownloadCustomersData *dwn=[[DownloadCustomersData alloc]init];
        if(!defaultGet(firstTimeLaunching))
        {
            
            [dwn restServiceForCustomerList];
        }
        else
        {
            [dwn fetchAllsavedCustomers];
        }
    });
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DownloadProducts *dwn=[[DownloadProducts alloc]init];
        dwn.delegateProducts=self;
        if(!defaultGet(firstTimeLaunching))
        {
            load=[[LoadingView alloc]init];
            [load loadingWithlightAlpha:self.view with_message:@"Fetching......."];
            [load start];
            [dwn downloadStockWareHouseSavetoCoreData];
        }
        else
        {
            [dwn getFilterFor:@"brands__c"];
        }
    });

    
}

#pragma mark ProductsDelegate
-(void)productsListFetched
{
    defaultSet(@"Downloaded", firstTimeLaunching);
    [load stop];
}

-(void)viewWillAppear:(BOOL)animate
{
    [ronakGlobal.selectedCustomersArray removeAllObjects];
    [ronakGlobal.selectedFilter clearAllFilters];
    
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
    
}
@end
