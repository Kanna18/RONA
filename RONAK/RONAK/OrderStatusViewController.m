//
//  OrderStatusViewController.m
//  RONAK
//
//  Created by Gaian on 10/30/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "OrderStatsResponse.h"

@interface OrderStatusViewController ()<UITextFieldDelegate>

@end

@implementation OrderStatusViewController
{
    NSMutableArray *dataResp;
    UIView *overlayView;
    NSMutableArray *tVData;
    LoadingView *load;
    
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
    [load loadingWithlightAlpha:self.view with_message:@"Loading Order Status Reports"];
    [load start];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [self getOrderStatusResponse];
        });
    
    [self allocAwindowOntop];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissStatus:)];
    [self.view addGestureRecognizer:tap];
    tap.numberOfTapsRequired=1;
    tVData=[[NSMutableArray alloc]init];
    
    _fromDateTf.delegate=self;
    _toDateTF.delegate=self;
    _customerNameTF.delegate=self;
    _StatusTF.delegate=self;
    
    _filterView.hidden=YES;
    
    UITapGestureRecognizer *tapTwice=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showFilter:)];
    tapTwice.numberOfTapsRequired=2;
    [self.view addGestureRecognizer:tapTwice];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];

    [self.toDateTF setInputView:datePicker];
    [self.fromDateTf setInputView:datePicker];
    

}
-(void)dismissStatus:(id)sender{
    
    overlayView.hidden=YES;
    
}
-(void)showStatus:(UIButton*)sender{
    overlayView.hidden=NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)allocAwindowOntop{
    
    
    overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:overlayView];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    subView.backgroundColor = [UIColor blackColor];
    subView.alpha=0.8;
    [overlayView addSubview:subView];
    
    _reportStatus =[self.storyboard instantiateViewControllerWithIdentifier:@"reportsTV"];
    _reportStatus.view.frame=CGRectMake(0, 0, 500, 500);
    _reportStatus.view.center=subView.center;
    [self addChildViewController:_reportStatus];                 // 1
    [overlayView addSubview:_reportStatus.view];
    [_reportStatus didMoveToParentViewController:self];
    overlayView.hidden=YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)getOrderStatusResponse{
    
    NSDictionary *headers = @{ @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)],
                               @"content-type": @"application/json",
                               };
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_OrderStatus_b]
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
            defaultSet(dict, orderStatusArrayOffline);//Saving to defaults
            dataResp=[OrderStatsResponse arrayOfModelsFromDictionaries:dict error:&err];
            [self customResponseFunction:dataResp];
        }else{
            NSArray *dict=defaultGet(orderStatusArrayOffline);//retrevingFrom Defaults
            NSError *err;
            if(dict){
            dataResp=[OrderStatsResponse arrayOfModelsFromDictionaries:dict error:&err];
            [self customResponseFunction:dataResp];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
                [load stop];
        });
    }];
    [dataTask resume];
   
}
#pragma mark - TablviewDelegates -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tVData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse=@"orderStatusCustomCell";
    OrderStatusCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse];
    OrderStatusCustomResponse *resp=tVData[indexPath.row];
    [cell bindData:resp superViewCon:self withIndex:indexPath.row+1000];
    [cell.statusBtn addTarget:self action:@selector(showStatus:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (IBAction)homeClick:(id)sender {
    
    NSArray *arr=self.navigationController.viewControllers;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[MenuViewController class]])
        {
            [self.navigationController popToViewController:(MenuViewController*)obj animated:YES];
            return ;
        }
    }];
}

-(void)customResponseFunction:(NSMutableArray*)arra{
    
    [tVData removeAllObjects];
    [arra enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        OrderStatsResponse *resPonse=obj;
        OrderStatusCustomResponse *ordCustResp=[[OrderStatusCustomResponse alloc]initWithDict:resPonse];
        [tVData addObject:ordCustResp];// Step 1 add Parent to array
        
        //InvoiceRecordsParsing
        NSArray *invRec=resPonse.Invoices__r.records;
        [invRec enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            OrderStatusCustomResponse *ordCSt=[[OrderStatusCustomResponse alloc]initWithDict:resPonse andRecord:obj];
            // Step 2 add Parent with InvoiceRecord;
            [tVData addObject:ordCSt];
        }];
        //Deliveries Parsing
        NSArray *delRec=resPonse.Deliveries__r.records;
        [delRec enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            OrderStatusCustomResponse *ordCSt=[[OrderStatusCustomResponse alloc]initWithDict:resPonse andRecord:obj];
            // Step 2 add Parent with DEliveryRecord;
            [tVData addObject:ordCSt];
        }];
    }];
    [self performSelectorOnMainThread:@selector(tvDataReload) withObject:tVData waitUntilDone:YES];
}


-(void)tvDataReload{

    [_statusTableView reloadData];
}


-(void)showFilter:(id)sender
{
    if(_filterView.hidden==YES)
    {
        _filterView.hidden=NO;
    }
    else
    {
        _filterView.hidden=YES;
        if(_fromDateTf.text.length>0&&_toDateTF.text.length>0)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(Receipt_Date__c >= %@) AND (Receipt_Date__c <= %@)", _fromDateTf.text, _toDateTF.text];
//            tvArray=[_cst.PDC__r.records filteredArrayUsingPredicate:predicate];
//            NSSortDescriptor *sort=[[NSSortDescriptor alloc]initWithKey:@"Receipt_Date__c" ascending:YES];
//            tvArray=[tvArray sortedArrayUsingDescriptors:@[sort]];
//            [_listTableView reloadData];
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self addDoneButtontoKeyboard:textField];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == _fromDateTf)
    {
        [self updateTextField:textField];
    }
    if(textField == _toDateTF)
    {
        [self updateTextField:textField];
    }
}

-(void)updateTextField:(UITextField*)sender
{
    UIDatePicker *picker = (UIDatePicker*)sender.inputView;
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [DateFormatter stringFromDate:picker.date];
    sender.text = [NSString stringWithFormat:@"%@",dateString];
}
-(void)addDoneButtontoKeyboard:(UITextField*)textField
{
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton,doneBarButton];
    textField.inputAccessoryView = keyboardToolbar;
}
-(void)yourTextViewDoneButtonPressed
{
    [self.view endEditing:YES];
}

@end
