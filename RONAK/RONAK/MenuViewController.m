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


@interface MenuViewController ()<FetchedAllProducts>

@end

@implementation MenuViewController{
    
    LoadingView *load;
    AppDelegate *delegate;
    NSManagedObjectContext *context;
    BOOL productsFetched,stockFetched,imagesFetched,savedData;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _ProgressView.hidden=YES;
    
    delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    context=delegate.managedObjectContext;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProductLabel:) name:PRODUC_FETCHING_STATUS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImagesLabel:) name:IMAGES_FETCHING_STATUS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStockLabel:) name:STOCK_FETCHING_STATUS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMatchingLabel:) name:STOCK_PRODUCT_ID_MATCHING_NOTIFICATION object:nil];
    
    [self defaultComponentsStyle];
    
    
   if(!defaultGet(firstTimeLaunching))
   {
       DownloadProducts *dwn=[[DownloadProducts alloc]init];
       dwn.delegateProducts=self;
       [dwn downLoadStockDetails];
       [dwn downloadCustomersListInBackground];
       [dwn downloadStockWareHouseSavetoCoreData];
       [dwn getBrandsAndWarehousesListandsavetoDefaults];
       _ProgressView.hidden=NO;
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

-(void)updateProductLabel:(NSNotification*)notification{
    
    int percentage=[notification.object intValue];
    if(percentage>=99){
        productsFetched=YES;
        _downloadStatus.text=@"Completed";
        [self allDownloadsCompleted];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
       _downloadStatus.text=[NSString stringWithFormat:@"Fetching Products...%@%%",notification.object];
    });
}
-(void)updateImagesLabel:(NSNotification*)notification{
    int percentage=[notification.object intValue];
    if(percentage>=30){
        imagesFetched=YES;
        _imagesDownload.text=@"Completed";
        [self allDownloadsCompleted];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        _imagesDownload.text=[NSString stringWithFormat:@"Downloading Images...%@%%",notification.object];
    });
}
-(void)updateStockLabel:(NSNotification*)notification{
    int percentage=[notification.object intValue];
    if(percentage>=99){
        stockFetched=YES;
        _downloadStockDetails.text=@"Completed";
        [self allDownloadsCompleted];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        _downloadStockDetails.text=[NSString stringWithFormat:@"Downloading Stock...%@%%",notification.object];
    });
}
-(void)updateMatchingLabel:(NSNotification*)notification{
    int percentage=[notification.object intValue];
    if(percentage>=99){
        savedData=YES;
        [self allDownloadsCompleted];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        _matchingLabel.text=[NSString stringWithFormat:@"Saving Data...%@%%",notification.object];
    });
}


-(void)allDownloadsCompleted{
    
    if(productsFetched&&stockFetched&&imagesFetched&&savedData){
        defaultSet(@"Launched", firstTimeLaunching);
        [self getFetchFiltersAfteDataFetched];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _ProgressView.hidden=YES;
        });
    }
}

-(void)getFetchFiltersAfteDataFetched
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSManagedObjectContext *contextChild1=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        contextChild1.parentContext=context;
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _ProgressView.hidden=YES;
    });
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
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:PRODUC_FETCHING_STATUS_NOTIFICATION];
    [[NSNotificationCenter defaultCenter] removeObserver:IMAGES_FETCHING_STATUS_NOTIFICATION];
    [[NSNotificationCenter defaultCenter] removeObserver:STOCK_FETCHING_STATUS_NOTIFICATION];
    [[NSNotificationCenter defaultCenter] removeObserver:STOCK_PRODUCT_ID_MATCHING_NOTIFICATION];
    
}

- (void)didReceiveMemoryWarning
{
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
    
    OrderStatusViewController *ovc=[self.storyboard instantiateViewControllerWithIdentifier:@"orderStatusVC"];
    [self.navigationController pushViewController:ovc animated:YES];
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
