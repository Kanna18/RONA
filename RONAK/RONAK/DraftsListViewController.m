//
//  DraftsListViewController.m
//  RONAK
//
//  Created by Gaian on 1/25/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import "DraftsListViewController.h"
#import "OrderSummaryVC.h"
#import "CustomersViewController.h"
#import "DefaultFiltersViewController.h"
@interface DraftsListViewController ()

@end

@implementation DraftsListViewController{
    
    NSMutableArray *dataResp;
    NSMutableArray *tVData;
    LoadingView *load;
    NSManagedObjectContext *draftsContext;
    AppDelegate *delegate;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _statusTableView.delegate=self;
    _statusTableView.dataSource=self;
    _statusTableView.layer.borderWidth=1.0f;
    _statusTableView.layer.borderColor=RGB(209, 210, 212).CGColor;
    _statusTableView.clipsToBounds=YES;
    
    load=[[LoadingView alloc]init];
    [load loadingWithlightAlpha:self.view with_message:@"Loading Drafts"];
    [load start];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [self getDraftsListFromSalesForce];
    });
    
    delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    draftsContext=delegate.managedObjectContext;
    
    UITapGestureRecognizer *taped=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumptoMenuVC:)];
    taped.numberOfTouchesRequired=1;
    [_headingLabel addGestureRecognizer:taped];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if(ronakGlobal.selectedCustomersArray.count>0){
        [ronakGlobal.selectedCustomersArray removeAllObjects];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TablviewDelegates -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataResp.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse=@"orderStatusCustomCell";
    DraftsCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse];
//    [cell bindData:resp superViewCon:self withIndex:indexPath.row+1000];
//    [cell.statusBtn addTarget:self action:@selector(showStatus:) forControlEvents:UIControlEventTouchUpInside];
    [cell bindData:dataResp[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Moving1");
    [load loadingWithlightAlpha:self.view with_message:@"Loading Draft"];
    [load start];
//    getCustomersListFromDB:dataResp[indexPath.row]
    [self performSelector:@selector(getCustomersListFromDB:) withObject:dataResp[indexPath.row] afterDelay:0.2];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [load stop];
}
-(void)getCustomersListFromDB:(DraftsDataModel*)drft{

    ronakGlobal.currentDraftRecord=drft.Id;    
    RESTCalls *rest=[[RESTCalls alloc]init];
    NSData *dat=[rest readJsonDataFromFileinNSD:customersFilePath];
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:dat options:1 error:nil];
    NSError *err;
    NSArray *customersList=[CustomerDataModel arrayOfModelsFromDictionaries:arr error:&err];
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"Id == %@",drft.Account__c];
    NSArray *nwArr=[customersList filteredArrayUsingPredicate:pre];
    CustomerDataModel *cst=nwArr.lastObject;
    if(cst){
        [ronakGlobal.selectedCustomersArray addObject:cst];
        for (ItemRecord *im in drft.Order_Line_Items__r.records){
            NSFetchRequest *fet=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ItemMaster class])];    
            NSPredicate *pre=[NSPredicate predicateWithFormat:@"filters.item_No__c == %@",im.Product__c];
            [fet setPredicate:pre];
            NSError *myEr;
            NSArray *items=[draftsContext executeFetchRequest:fet error:&myEr];
            ItemMaster *itemMasterObj=items.lastObject;
            if(itemMasterObj){
                for (int i=0;i<im.Quantity__c.intValue;i++) {
                    [cst.defaultsCustomer.itemsCount addObject:itemMasterObj];
                }
            }
        }
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    NSMutableArray *controllers = [self.navigationController.viewControllers mutableCopy];
    DefaultFiltersViewController *dvc=storyBoard(@"defaultVC");
    [controllers addObject:dvc];
    [self.navigationController setViewControllers:controllers animated:NO];
    return YES;
}
-(void)getDraftsListFromSalesForce{
    
    NSDictionary *headers = @{ @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)],
                               @"content-type": @"application/json",
                               };
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_DrafsList_b]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if(data){
                                              NSArray *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              NSError *err;
                                              defaultSet(dict, draftsListOfflineArray);//Saving to defaults
                                              dataResp=[DraftsDataModel arrayOfModelsFromDictionaries:dict error:&err];
//                                              [self customResponseFunction:dataResp];
                                          }else{
                                              NSArray *dict=defaultGet(draftsListOfflineArray);//retrevingFrom Defaults
                                              NSError *err;
                                              if(dict){
                                                  dataResp=[DraftsDataModel arrayOfModelsFromDictionaries:dict error:&err];
//                                                  [self customResponseFunction:dataResp];
                                              }
                                          }
                                          
                                          [self removeEditedDrafts];
                                      }];
    [dataTask resume];
    
}
-(void)removeEditedDrafts{
    for (NSString *editDraft in defaultGet(deleteDraftOfflineArray)){
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"Id == %@",editDraft];
        NSArray  *fil =[dataResp filteredArrayUsingPredicate:pre];
        if(fil.count>0){
            [dataResp removeObject:fil.lastObject];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_statusTableView reloadData];
        [load stop];
    });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)jumptoMenuVC:(id)sender
{
    
    NSArray *arr=self.navigationController.viewControllers;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[MenuViewController class]])
        {
            [self.navigationController popToViewController:(MenuViewController*)obj animated:YES];
            return ;
        }
    }];
}

@end
