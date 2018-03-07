//
//  OrderSummaryVC.m
//  RONAK
//
//  Created by Gaian on 8/25/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "OrderSummaryVC.h"
#import "RemarksView.h"
#import "CollectionPopUp.h"
#import "SaleOrderWrapper.h"

#define saleOrderBtnTag 19
#define saveDraftBtnTag 20


@interface OrderSummaryVC ()<WSCalendarViewDelegate,UITextFieldDelegate,RemarksViewProtocol>

@end

@implementation OrderSummaryVC
{
    Discount *dis;
    Calculator *cal;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
    UIView *containerView;
    
    PlaceOrder *placeOrderPop;
    RemarksView *remarksView;
    CollectionPopUp *draftDCpop,*saveOrderCollectionPop;
    
    LoadingView *load;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _summaryTableView.delegate=self;
    _summaryTableView.dataSource=self;
    _summaryTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    load=[[LoadingView alloc]init];
    [self calendarFunction];
    
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAllSubviewsandDeselectall)];
//    tap.numberOfTapsRequired=2;
//    [self.view addGestureRecognizer:tap];
//    

    
    UITapGestureRecognizer *taped=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumptoMenuVC:)];
    taped.numberOfTouchesRequired=1;
    [_headingLabel addGestureRecognizer:taped];
        
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self scrollViewDisplayListofCstmrs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Cells
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NSCountedSet setWithArray:_cstdDataModel.defaultsCustomer.itemsCount].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reus=@"orderSummaryCell";
    OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:reus];
    if(cell==nil)
    {
        cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reus];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    [cell bindData:_itemsArray[indexPath.row] withCount:(int)[_itemsCount countForObject:_itemsArray[indexPath.row]] customerData:_cstdDataModel forCustome:_presentCustomerBtn];
    
    return cell;
}


-(void)scrollViewDisplayListofCstmrs
{
    __block int X=0,Y=0;
    [selectedCustomersList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CustomerDataModel *cst=selectedCustomersList[idx];
        CustomButton *btn=[CustomButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        btn.titleLabel.font=gothMedium(14);
        [btn setTitleColor:RGB(40, 40, 41) forState:UIControlStateNormal];
        [btn setTitle:[@" " stringByAppendingString:cst.Name] forState:UIControlStateNormal];
        //        btn.titleLabel.intrinsicContentSize.width+2
        btn.frame=CGRectMake(X, Y, 200, 30);
        btn.cstData=cst;
        [btn setBackgroundColor:GrayLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clikedOnCustomer:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView_Cmlist addSubview:btn];
        X+=207;
        
        if(idx==0){
            [self fillLabelsWithText:btn];
        }
    }];
    _scrollView_Cmlist.contentSize=CGSizeMake(X+20, 0);
}
-(void)fillLabelsWithText:(CustomButton*)btn
{
    _cstdDataModel=btn.cstData;
    _presentCustomerBtn=btn;
    [btn setBackgroundColor:BlueClr];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _customerNameLabel.text=_cstdDataModel.Name;
    
    _itemsCount=[NSCountedSet setWithArray:_cstdDataModel.defaultsCustomer.itemsCount];
    _items=[NSSet setWithArray:_cstdDataModel.defaultsCustomer.itemsCount];
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"filters.codeId" ascending:YES];
    _itemsArray=[[(NSMutableArray*)[_items allObjects] mutableCopy] sortedArrayUsingDescriptors:@[sort]];
    
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *str=[monthFormatter stringFromDate:_cstdDataModel.defaultsCustomer.dateFuture];
    _futureDateLabl.text=str;
    
    if(!_cstdDataModel.defaultsCustomer.discount||[_cstdDataModel.defaultsCustomer.discount isEqualToString:@"0"]){
        _percentageLabel.hidden=YES;
        _discountHeadinglbl.hidden=YES;
    }else{
        _percentageLabel.text=_cstdDataModel.defaultsCustomer.discount;
        _percentageLabel.hidden=NO;
        _discountHeadinglbl.hidden=NO;
    }
    
    int total=0;
//    int sunGlassesGST=0,framesGST=0;
    
    for (ItemMaster *item in _cstdDataModel.defaultsCustomer.itemsCount)
    {
        total+=item.filters.wS_Price__c;
//        if([item.filters.product__c isEqualToString:@"Sunglasses"])
//        {
//            sunGlassesGST+=item.filters.wS_Price__c;
//        }
//        if([item.filters.product__c isEqualToString:@"Frames"])
//        {
//            framesGST+=item.filters.wS_Price__c;
//        }
    }
    
//    sunGlassesGST=sunGlassesGST*28/100;
//    framesGST=framesGST*14/100;
//    _sunGST.text=[NSString stringWithFormat:@"GST on SG 28%%"];
        _sunGST.text=@"";
//    _gstSGValueLbl.text=[NSString stringWithFormat:@"%0.2f",(float)sunGlassesGST];
//    _frameGST.text=[NSString stringWithFormat:@"GST on FR 14%%"];
    _frameGST.text=@"";
//    _gstFRValueLbl.text=[NSString stringWithFormat:@"%0.2f",(float)framesGST];
//    _totalAmount.text=[NSString stringWithFormat:@"%0.2f",(float)(total-(total*[_cstdDataModel.defaultsCustomer.discount intValue])/100)];
//    _netAmount.text=[NSString stringWithFormat:@"₹ %0.2f",(float)([_totalAmount.text floatValue]+sunGlassesGST+framesGST)];

    _totalAmount.text=[NSString stringWithFormat:@"%0.2f",(float)(total-(total*[_cstdDataModel.defaultsCustomer.discount intValue])/100)];
    _netAmount.text=[NSString stringWithFormat:@"₹ %0.2f",(float)([_totalAmount.text floatValue])];
    
    
    _ropilLabel.text=_cstdDataModel.defaultsCustomer.customerROIPL;
    _remarksLabel.text=_cstdDataModel.defaultsCustomer.customerRemarks;
        
    [self dynamicscrollViewContentHeight];
    [_summaryTableView reloadData];
    _cstdDataModel.defaultsCustomer.netAmount=_netAmount.text;
    _itemsTotlaQuantity.text=[NSString stringWithFormat:@"%lu",(unsigned long)[_cstdDataModel.defaultsCustomer.itemsCount count]];
}

-(void)clikedOnCustomer:(CustomButton*)sender
{
    for (CustomButton *btn in _scrollView_Cmlist.subviews) {
        if([btn isKindOfClass:[CustomButton class]])
        {
            [btn setBackgroundColor:GrayLight];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    [self fillLabelsWithText:sender];
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)calculatorClick:(id)sender {
    
    if(_calculator.isSelected==NO)
    {
        [self removeAllSubviewsandDeselectall];
        CGRect frame= _calculator.frame;
        //cal=[[Calculator alloc]initWithFrame:CGRectMake(frame.origin.x-40,self.view.frame.size.height-350-70,350,350)];
        
        
        cal=[[Calculator alloc]initWithFrame:CGRectMake(frame.origin.x-45,self.view.frame.size.height-330-60,212,330)];
        
        _calculator.selected=YES;
        [self.view addSubview:cal];
    }
    else
    {
        [cal removeFromSuperview];
        _calculator.selected=NO;
    }
}

-(IBAction)discountClick:(id)sender {

    if(_discountBtn.selected==YES)
    {
        [dis removeFromSuperview];
        _discountBtn.selected=NO;
    }
    else
    {
        [self removeAllSubviewsandDeselectall];
        _discountBtn.selected=YES;
        CGRect frame = _discountBtn.frame;
        dis= [[Discount alloc]initWithFrame:CGRectMake(frame.origin.x-40, self.view.frame.size.height-330-60, 153, 330)];
        //dis.backgroundColor=[UIColor redColor];
        dis.delegate=self;
        [self.view addSubview:dis];
    }
    
}
#pragma markDiscount Delegate.
-(void)reslut:(NSString *)str
{
    _cstdDataModel.defaultsCustomer.discount=[str stringByAppendingString:@"%"];
    [self removeAllSubviewsandDeselectall];
    [self fillLabelsWithText:_presentCustomerBtn];

}

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
#pragma mark - OrderCell Delegate
-(void)quantityChangedforCustomer:(CustomButton *)cst
{
    [self fillLabelsWithText:cst];
    [_summaryTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)futureDeliveryCLick:(id)sender {
    
    
    if(_futureDelivery.selected==YES)
    {
        containerView.hidden=YES;
        _futureDelivery.selected=NO;
    }
    else
    {
        [self removeAllSubviewsandDeselectall];
        containerView.hidden=NO;
        _futureDelivery.selected=YES;
    }
    
}
-(void)calendarFunction
{
    CGRect frame = _futureDelivery.frame;
    containerView=[[UIView alloc]initWithFrame:CGRectMake(frame.origin.x-40, self.view.frame.size.height-350-60, 350, 350)];
    containerView.backgroundColor=GrayLight;
    [self.view addSubview:containerView];
    
    calendarViewEvent = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    calendarViewEvent.dayColor=BlueClr;
    calendarViewEvent.barDateColor=BlueClr;
    //calendarView.todayBackgroundColor=[UIColor blackColor];
    calendarViewEvent.tappedDayBackgroundColor=[UIColor blackColor];
    calendarViewEvent.frame = CGRectMake(0, 0, 350, 350);
    calendarViewEvent.calendarStyle = WSCalendarStyleView;
    calendarViewEvent.isShowEvent=YES;
    [calendarViewEvent setupAppearance];
    [containerView addSubview:calendarViewEvent];
    calendarViewEvent.delegate=self;
    containerView.hidden=YES;
}

#pragma mark WSCalendarViewDelegate

-(NSArray *)setupEventForDate{
    return eventArray;
}

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    
    NSDate *date1 = selectedDate;
    NSDate *date2 = [NSDate date];
    switch ([date1 compare:date2]) {
        case NSOrderedAscending:
            showMessage(@"Select a future Date", self.view);
            break;
            
        case NSOrderedDescending:
        {
            NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
            [monthFormatter setDateFormat:@"dd MMMM yyyy"];
            NSString *str=[monthFormatter stringFromDate:selectedDate];
            _cstdDataModel.defaultsCustomer.dateFuture=selectedDate;
            if(_futureDelivery.selected==YES)
            {
                containerView.hidden=YES;
                _futureDelivery.selected=NO;
            }
            else
            {
                containerView.hidden=NO;
                _futureDelivery.selected=YES;
            }
            [self fillLabelsWithText:_presentCustomerBtn];
            
        }
            break;
            
        case NSOrderedSame:
            showMessage(@"Select a future Date", self.view);
            break;
    }
    
   
}

-(void)deactiveWSCalendarWithDate:(NSDate *)selectedDate{
    
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *str=[monthFormatter stringFromDate:selectedDate];
}

- (IBAction)hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
}
- (IBAction)placeOrderClick:(id)sender {
    
    [self removeAllSubviewsandDeselectall];
    if(_placeOrderBtn.selected==YES)
    {
       _placeOrderBtn.selected=NO;
        [placeOrderPop removeFromSuperview];
    }
    else
    {

        placeOrderPop=[[PlaceOrder alloc]initWithFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height, 0, 0) withSuperView:self];
        [self.view addSubview:placeOrderPop];
        _placeOrderBtn.selected=YES;
    }

    
}
-(IBAction)remarksClick:(id)sender
{
    [self removeAllSubviewsandDeselectall];
    if(_remarksBtn.selected==YES)
    {
        _remarksBtn.selected=NO;
        [remarksView removeFromSuperview];
    }
    else
    {
        _remarksBtn.selected=YES;
        remarksView=[[RemarksView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) withTitle:@"CUSTOMER REMARKS" withSuperView:self];
        [self.view addSubview:remarksView];
        [remarksView.textView becomeFirstResponder];
        remarksView.textView.text=_cstdDataModel.defaultsCustomer.customerRemarks;
        remarksView.delegate=self;
    }
}
- (IBAction)roiplClick:(id)sender {
    
    [self removeAllSubviewsandDeselectall];
    if(_roiplBtn.selected==YES)
    {
        _roiplBtn.selected=NO;
        [remarksView removeFromSuperview];
    }
    else
    {
        _roiplBtn.selected=YES;
        remarksView=[[RemarksView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) withTitle:@"ROIPL REMARKS" withSuperView:self];
        [self.view addSubview:remarksView];
        remarksView.textView.text=_cstdDataModel.defaultsCustomer.customerROIPL;
        [remarksView.textView becomeFirstResponder];
        remarksView.delegate=self;
    }
}
- (IBAction)draftClick:(id)sender {
    
    [self removeAllSubviewsandDeselectall];
    if(_draftBtn.selected==YES)
    {
        _draftBtn.selected=NO;
        [remarksView removeFromSuperview];
    }
    else
    {
        _draftBtn.selected=YES;
        if(![self.view.subviews containsObject:draftDCpop]){
        draftDCpop=[[CollectionPopUp alloc]initWithFrame:CGRectZero witTitle:@"Do you want to save as Draft" withSuperView:self];
        draftDCpop.yesBtn.tag=saveDraftBtnTag;
        draftDCpop.center=self.view.center;
            [draftDCpop.yesBtn addTarget:self action:@selector(saveOrderToProceed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:draftDCpop];
        }
    }

}
- (IBAction)cancelOrderClick:(id)sender {
    
    [self removeAllSubviewsandDeselectall];
    if(_deliveryBtn.selected==YES)
    {
        _deliveryBtn.selected=NO;
        [draftDCpop removeFromSuperview];
    }
    else
    {
        _deliveryBtn.selected=YES;
        if(![self.view.subviews containsObject:draftDCpop]){
            draftDCpop=[[CollectionPopUp alloc]initWithFrame:CGRectZero witTitle:@"Are you sure you want to cancel the order?" withSuperView:self];
            [self.view addSubview:draftDCpop];
            draftDCpop.center=self.view.center;
        }
    }
    
}



- (IBAction)deliveryClick:(id)sender {
    [self removeAllSubviewsandDeselectall];
    if(_deliveryBtn.selected==YES)
    {
        _deliveryBtn.selected=NO;
        [draftDCpop removeFromSuperview];
    }
    else
    {
        _deliveryBtn.selected=YES;
        if(![self.view.subviews containsObject:draftDCpop]){
        draftDCpop=[[CollectionPopUp alloc]initWithFrame:CGRectZero witTitle:@"Do you want to save as DC" withSuperView:self];
        [self.view addSubview:draftDCpop];
        draftDCpop.center=self.view.center;
        }
    }
}
-(IBAction)swipeToBookAnotheOrder:(id)sender
{
    [self removeAllSubviewsandDeselectall];
    if(_placeOrderBtn.selected==YES)
    {
        _placeOrderBtn.selected=NO;
        [placeOrderPop removeFromSuperview];
    }
    else
    {
        
        saveOrderCollectionPop=[[CollectionPopUp alloc]initWithFrame:CGRectMake(0, 0, 100, 200)];
        saveOrderCollectionPop.center=self.view.center;
        saveOrderCollectionPop.titleLabel.text=@"Do you want to Save Order";
        saveOrderCollectionPop.yesBtn.tag=saleOrderBtnTag;
        [saveOrderCollectionPop.yesBtn addTarget:self action:@selector(saveOrderToProceed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveOrderCollectionPop];
    }
}

-(void)saveOrderToProceed:(UIButton*)sender{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveOrderMessage:) name:@"SaveOrderStatus" object:nil];
    [saveOrderCollectionPop removeFromSuperview];
    SaleOrderWrapper *sale=[[SaleOrderWrapper alloc]init];
    if(sender.tag==saleOrderBtnTag){
    [sale sendResponseForString:kSaleOrder];
    }else if(sender.tag==saveDraftBtnTag){
        [sale sendResponseForString:ksaveDraft];
    }
    [load loadingWithlightAlpha:self.view with_message:@"Saving Order...."];
    [load start];
}

-(void)saveOrderMessage:(NSNotification*)notification{

    NSString *str=notification.object;

    if([str isEqualToString:@"Succes"])//Internet Availability Case
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [load waringLabelText:@"Order Saved Successfully" onView:self.view];
            [load stop];
            if(ronakGlobal.currentDraftRecord){
                [self deleteDraft];
            }
        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        [load waringLabelText:str onView:self.view];
        [load stop];
        });
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self jumptoMenuVC:nil];
    });
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SaveOrderStatus" object:nil];
}
-(void)deleteDraft{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        DownloadProducts *dow=[[DownloadProducts alloc]init];
        [dow deleteDraftWithRecID:ronakGlobal.currentDraftRecord];
        ronakGlobal.currentDraftRecord=nil;
    });
}
-(void)removeAllSubviewsandDeselectall
{
    for (UIButton *butt in _bottomBarView.subviews)
    {
        if([butt isKindOfClass:[UIButton class]]){
            butt.selected=NO;
        }
    }
    [cal removeFromSuperview];
    [dis removeFromSuperview];
    [draftDCpop removeFromSuperview];
    [remarksView removeFromSuperview];
    containerView.hidden=YES;
}
-(void)dynamicscrollViewContentHeight{
    
    CGRect tvFrame=_dynamicScrollViewContentView.frame;
    tvFrame.size.height=[NSCountedSet setWithArray:_cstdDataModel.defaultsCustomer.itemsCount].count*100;
    _cntnViewconstraint.constant=[NSCountedSet setWithArray:_cstdDataModel.defaultsCustomer.itemsCount].count*100+200;
    _scrollViewDynamic.contentSize=CGSizeMake(0, [NSCountedSet setWithArray:_cstdDataModel.defaultsCustomer.itemsCount].count*100+200);
    
}
#pragma mark remarksROIPLDelegate

-(void)remarksROIPLvalueSelected:(NSString *)str
{
    if([str isEqualToString:@"CUSTOMER REMARKS"]){
        _cstdDataModel.defaultsCustomer.customerRemarks=_remarksLabel.text;
    }
    else if ([str isEqualToString:@"ROIPL REMARKS"])
    {
        _cstdDataModel.defaultsCustomer.customerROIPL=_ropilLabel.text;
    }
    
}

#pragma mark SearchField to Search for LOCAL/GLOBAl

-(void)globalOrLocalSearchFunctiontxt:(NSString*)str LocalSearch:(BOOL)search
{
    
    NSPredicate *brandP=[NSPredicate predicateWithFormat:@"SELF.filters.brand__s CONTAINS[cd]  %@",str];
    
    NSPredicate *collectionP=[NSPredicate predicateWithFormat:@"SELF.filters.collection__c CONTAINS[cd]  %@",str];
    NSPredicate *lensDP=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Description__c CONTAINS[cd]  %@",str];
    NSPredicate *wsPre=[NSPredicate predicateWithFormat:@"SELF.filters.wS_Price__c CONTAINS[cd]  %@",str];
    NSPredicate *shapeP=[NSPredicate predicateWithFormat:@"SELF.filters.shape__c CONTAINS[cd]  %@",str];
    NSPredicate *genderP=[NSPredicate predicateWithFormat:@"SELF.filters.category__c CONTAINS[cd] %@",str];
    NSPredicate *frameMaP=[NSPredicate predicateWithFormat:@"SELF.filters.frame_Material__c CONTAINS[cd]  %@",str];
    NSPredicate *tempMP=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Material__c CONTAINS[cd]  %@",str];
    NSPredicate *temCP=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Color__c CONTAINS[cd]  %@",str];
    NSPredicate *tipP=[NSPredicate predicateWithFormat:@"SELF.filters.tips_Color__c CONTAINS[cd]  %@",str];
    
    NSPredicate *disP=[NSPredicate predicateWithFormat:@"SELF.filters.discount__c CONTAINS[cd]  %@",str];
    NSPredicate *mrpP=[NSPredicate predicateWithFormat:@"SELF.filters.mRP__c CONTAINS[cd]  %@",str];
    NSPredicate *rimP=[NSPredicate predicateWithFormat:@"SELF.filters.rim__c CONTAINS[cd]  %@",str];
    NSPredicate *size=[NSPredicate predicateWithFormat:@"SELF.filters.size__c CONTAINS[cd]  %@",str];
    NSPredicate *lensMP=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Material__c CONTAINS[cd]  %@",str];
    NSPredicate *frontP=[NSPredicate predicateWithFormat:@"SELF.filters.front_Color__c CONTAINS[cd]  %@",str];
    NSPredicate *lensCoP=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Color__c CONTAINS[cd]  %@",str];

    NSArray *arrP=@[lensDP,wsPre,shapeP,genderP,frameMaP,tempMP,temCP,tipP,disP,mrpP,rimP,size,lensMP,frontP,lensCoP,collectionP];

    NSCompoundPredicate *fP=[NSCompoundPredicate orPredicateWithSubpredicates:arrP];
//    NSCompoundPredicate *finalPre=[NSCompoundPredicate ]

}

-(void)tvImage:(UITableView*)tv aview:(UIView*)aView
{
    if([tv numberOfRowsInSection:0]>0){
        UIGraphicsBeginImageContextWithOptions(tv.bounds.size, tv.opaque, 0.0);
        [tv.layer renderInContext:UIGraphicsGetCurrentContext()];
        [tv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [tv.layer renderInContext:UIGraphicsGetCurrentContext()];
        int rows = [tv numberOfRowsInSection:0];
        int numberofRowsInView = 4;
        for (int i =0; i < rows/numberofRowsInView; i++)
        {
            [tv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(i+1)*numberofRowsInView inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            [tv.layer renderInContext:UIGraphicsGetCurrentContext()];
        }
        UIImage *tVimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        CGRect rect1 = _bottomCalculationsView.bounds;
        UIGraphicsBeginImageContextWithOptions(rect1.size, self.view.opaque, 0.0);
        CGContextRef context2 = UIGraphicsGetCurrentContext();
        [_bottomCalculationsView.layer renderInContext:context2];
        UIImage *calcImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        CGRect headingImageRect =  CGRectMake(0, 200, self.view.frame.size.width, 238);
        UIGraphicsBeginImageContextWithOptions(headingImageRect.size, self.view.opaque, 0.0);
        CGContextRef headingcontext2 = UIGraphicsGetCurrentContext();
        [self.view.layer renderInContext:headingcontext2];
        UIImage *heading = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        CGSize newSize = CGSizeMake(heading.size.width,heading.size.height+calcImg.size.height+tVimage.size.height);
        UIGraphicsBeginImageContext( newSize );
        // Use existing opacity as is
        [heading drawInRect:CGRectMake(0,0,heading.size.width,heading.size.height)];
        // Apply supplied opacity if applicable
        [tVimage drawInRect:CGRectMake(0,heading.size.height,heading.size.width,tVimage.size.height) blendMode:kCGBlendModeNormal alpha:1];
        [calcImg drawInRect:CGRectMake(0,tVimage.size.height+heading.size.height,heading.size.width,calcImg.size.height) blendMode:kCGBlendModeNormal alpha:1];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        UIImageView *imgV=[[UIImageView alloc]initWithImage:newImage];
        NSString * timestamp = [NSString stringWithFormat:@"%d", (int) ([[NSDate date] timeIntervalSince1970] * 1000)];
        [self createPDFfromUIViews:imgV saveToDocumentsWithFileName:[NSString stringWithFormat:@"%@.pdf",_cstdDataModel.Name]];
    }
    else{
        showMessage(@"No Products to save as pdf", self.view);
    }
}

- (void)createPDFfromUIViews:(UIView *)myImage saveToDocumentsWithFileName:(NSString *)string
{
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, myImage.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
    [myImage.layer renderInContext:pdfContext];
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:[orderSummaryFolder stringByAppendingPathComponent:string]];
    NSLog(@"%@",documentDirectoryFilename);
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    [load waringLabelText:[NSString stringWithFormat:@"Summary saved as PDF for Customer %@",_cstdDataModel.Name] onView:self.view];
    
    
}

- (IBAction)dowloadPDF:(id)sender {
    
    if(_cstdDataModel)
    [self tvImage:self.summaryTableView aview:self.view];
    
}

- (IBAction)sendEmailClick:(id)sender {
    [load start];
    [load loadingWithlightAlpha:self.view with_message:@"Please Wait"];
    [self dowloadPDF:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([MFMailComposeViewController canSendMail])
        {
            [load stop];
            NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
            NSString* documentDirectory = [documentDirectories objectAtIndex:0];
            NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:[orderSummaryFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",_cstdDataModel.Name]]];
            NSLog(@"%@",documentDirectoryFilename);
            
            NSString *emailTitle = [NSString stringWithFormat:@"Order Summary of the Cutomer %@",_cstdDataModel.Name];
            NSString *messageBody = @"";
            NSArray *toRecipents = [NSArray arrayWithObject:@""];
            NSString *path = [[NSBundle mainBundle] pathForResource:documentDirectoryFilename ofType:@"pdf"];
            NSData *myData= [NSData dataWithContentsOfFile: documentDirectoryFilename];
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:messageBody isHTML:NO];
            [mc addAttachmentData:myData mimeType:@"application/pdf" fileName:[_cstdDataModel.Name stringByAppendingPathExtension:@"pdf"]];
            [mc setToRecipients:toRecipents];
            [self presentViewController:mc animated:YES completion:NULL];
        }
        else
        {
            [load stop];
            showMessage(@"Please Configure Mail Settings in your Device", self.view);
        }
    });
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
