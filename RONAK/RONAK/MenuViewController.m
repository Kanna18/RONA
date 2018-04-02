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
#import "DraftsListViewController.h"
#import <Crashlytics/Crashlytics.h>


@interface MenuViewController ()<FetchedAllProducts>

@end

@implementation MenuViewController{
    
    LoadingView *load;
    AppDelegate *delegate;
    NSManagedObjectContext *context;
    BOOL productsFetched,stockFetched,imagesFetched,savedData;
    BOOL syncCustomerMasterFlag, syncBrandStockFlag, syncProductMasterFlag;
    Reachability *reachability;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _ProgressView.hidden=YES;
    
    load=[[LoadingView alloc]init];
    delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    context=delegate.managedObjectContext;
    
    syncCustomerMasterFlag=NO;
    syncBrandStockFlag=NO;
    syncProductMasterFlag=NO;

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
    [self InternetStatus];
}

-(void)updateProductLabel:(NSNotification*)notification{
    
    int percentage=[notification.object intValue];
    if(percentage>=99){
        productsFetched=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            _downloadStatus.text=@"Products Download Completed";
        });
        [self allDownloadsCompleted];
    }else{
    dispatch_async(dispatch_get_main_queue(), ^{
       _downloadStatus.text=[NSString stringWithFormat:@"Fetching Products...%@%%",notification.object];
    });
    }
}
-(void)updateImagesLabel:(NSNotification*)notification{
    int percentage=[notification.object intValue];
    if(percentage>=99){
        imagesFetched=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            _imagesDownload.text=@"Images Download Completed";
        });
        [self allDownloadsCompleted];
    }else{
    dispatch_async(dispatch_get_main_queue(), ^{
        _imagesDownload.text=[NSString stringWithFormat:@"Downloading Images...%@%%",notification.object];
    });
    }
}
-(void)updateStockLabel:(NSNotification*)notification{
    int percentage=[notification.object intValue];
    if(percentage>=99){
        stockFetched=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
           _downloadStockDetails.text=@"Stock Details Download Completed";
        });
        [self allDownloadsCompleted];
    }else{
    dispatch_async(dispatch_get_main_queue(), ^{
        _downloadStockDetails.text=[NSString stringWithFormat:@"Downloading Stock...%@%%",notification.object];
    });
    }
}
-(void)updateMatchingLabel:(NSNotification*)notification{
    int percentage=[notification.object intValue];
    if(percentage>=99){
        savedData=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            _matchingLabel.text=@"Data Saving Completed";
        });
        [self allDownloadsCompleted];
    }else{
    dispatch_async(dispatch_get_main_queue(), ^{
        _matchingLabel.text=[NSString stringWithFormat:@"Saving Data...%@%%",notification.object];
    });
    }
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
    ronakGlobal.currentDraftRecord=nil;
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
    
    if(ronakGlobal.booleanToWorkFunctionalities){
        OrderStatusViewController *ovc=[self.storyboard instantiateViewControllerWithIdentifier:@"orderStatusVC"];
        [self.navigationController pushViewController:ovc animated:YES];
    }
}

- (IBAction)activity_click:(id)sender {
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://test.salesforce.com"]];
}

- (IBAction)logout_click:(id)sender {
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Are you sure you want to logout" message:@"Logout will erase all your stored data" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SignInViewController *signIN=[self.storyboard instantiateViewControllerWithIdentifier:@"signInVC"];
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:signIN];
        [self presentViewController:nav animated:YES completion:nil];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:savedUserPassword];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:savedUserEmail];        
        NSUserDefaults *def= [NSUserDefaults standardUserDefaults];
        NSDictionary *dic=[def dictionaryRepresentation];
        for (NSString *key in dic) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        }
        [self deleteStoredData];
    }];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)deleteStoredData{
    
    NSError *err;
    NSArray *arr=[fileManager contentsOfDirectoryAtPath:docPath error:&err];
    for (NSString *str in arr){
        [fileManager removeItemAtPath:[docPath stringByAppendingPathComponent:str] error:&err];
    }
    NSLog(@"%@",arr);
    
}


- (IBAction)multimedia_click:(id)sender {
    if(ronakGlobal.booleanToWorkFunctionalities){
        DraftsListViewController *ovc=[self.storyboard instantiateViewControllerWithIdentifier:@"draftsListVC"];
        [self.navigationController pushViewController:ovc animated:YES];
    }
}

- (IBAction)settings_click:(id)sender {
    
     if(ronakGlobal.booleanToWorkFunctionalities){
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncingDone:) name:syncCustomerMasterNotification object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncingDone:) name:syncBrandsStockNotification object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncingDone:) name:syncProductMasternotification object:nil];
         
         [load WithView:self.view with_message:@"Syncing All data"];
         [load start];
         SyncDBClass *sync=[[SyncDBClass alloc]init];
         [sync syncProductMaster];
         //    [sync syncStockWarehouse];//After Product Master download stock Warehouse in sync DB class
         [sync syncOrderStatusResponse];
         DownloadProducts *dow=[[DownloadProducts alloc]init];
         [dow downloadCustomersListInBackground];
         [dow getBrandsAndWarehousesListandsavetoDefaults];
     }
}

-(void)syncingDone:(NSNotification*)notification{

    
    if([notification.name isEqualToString:syncCustomerMasterNotification]){
        syncCustomerMasterFlag=YES;
    }if([notification.name isEqualToString:syncBrandsStockNotification]){
        syncBrandStockFlag=YES;
    }if([notification.name isEqualToString:syncProductMasternotification]){
        syncProductMasterFlag=YES;
    }
    if(syncBrandStockFlag==YES&&syncCustomerMasterFlag==YES&&syncProductMasterFlag){
        NSError *err=notification.object;
        NSLog(@"%@",err);
        [load performSelectorOnMainThread:@selector(stop) withObject:nil waitUntilDone:YES];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:syncCustomerMasterNotification object:nil];
         [[NSNotificationCenter defaultCenter] removeObserver:self name:syncBrandsStockNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:syncProductMasternotification object:nil];
        syncCustomerMasterFlag=NO;
        syncBrandStockFlag=NO;
        syncProductMasterFlag=NO;
        
        [self getFetchFiltersAfteDataFetched];
    }
}
-(void)InternetStatus{
    
    /*__weak*/ typeof(self) weakSelf = self;
    reachability= [Reachability reachabilityForInternetConnection];
    reachability.reachableBlock = ^(Reachability *reachability) {
        NSLog(@"Reaching Network");
        weakSelf.internetStatusLbl.text=@"Internet is Active";
        weakSelf.internetStatusLbl.textColor=[UIColor whiteColor];
    };
    reachability.unreachableBlock = ^(Reachability *reachability) {
        NSLog(@"UnReaching Network");
        weakSelf.internetStatusLbl.text=@"No Internet Connection";
        weakSelf.internetStatusLbl.textColor=[UIColor redColor];
    };
    [reachability startNotifier];

}
@end
