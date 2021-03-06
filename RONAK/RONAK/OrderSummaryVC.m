//
//  OrderSummaryVC.m
//  RONAK
//
//  Created by Gaian on 8/25/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "OrderSummaryVC.h"



@interface OrderSummaryVC ()<WSCalendarViewDelegate,UITextFieldDelegate>

@end

@implementation OrderSummaryVC
{
    Discount *dis;
    Calculator *cal;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
    UIView *containerView;
    
    PlaceOrder *placeOrderPop;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _summaryTableView.delegate=self;
    _summaryTableView.dataSource=self;
    _summaryTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self calendarFunction];
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
        btn.titleLabel.font=sfFont(20);
        [btn setTitle:cst.Name forState:UIControlStateNormal];
        //        btn.titleLabel.intrinsicContentSize.width+2
        btn.frame=CGRectMake(X, Y, 200, 30);
        btn.cstData=cst;
        [btn setBackgroundColor:GrayLight];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clikedOnCustomer:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView_Cmlist addSubview:btn];
        X+=210;
        
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
    _itemsArray=[[_items allObjects] mutableCopy];
    
    _futureDateLabl.text=_cstdDataModel.defaultsCustomer.dateFuture;
    _percentageLabel.text=_cstdDataModel.defaultsCustomer.discount;
    
    int total=0,sunGlassesGST=0,framesGST=0;
    
    for (ItemMaster *item in _cstdDataModel.defaultsCustomer.itemsCount)
    {
        total+=[item.filters.mRP__c intValue];
        if([item.filters.product__c isEqualToString:@"Sunglasses"])
        {
            sunGlassesGST+=[item.filters.mRP__c intValue];
        }
        if([item.filters.product__c isEqualToString:@"Frames"])
        {
            framesGST+=[item.filters.mRP__c intValue];
        }
    }
    
    sunGlassesGST=sunGlassesGST*28/100;
    framesGST=framesGST*14/100;
    _sunGST.text=[NSString stringWithFormat:@"%d",sunGlassesGST];
    _frameGST.text=[NSString stringWithFormat:@"%d",framesGST];
    _totalAmount.text=[NSString stringWithFormat:@"%d",total-(total*[_cstdDataModel.defaultsCustomer.discount intValue])/100];
    _netAmount.text=[NSString stringWithFormat:@"%d",total+sunGlassesGST+framesGST];
    [_summaryTableView reloadData];
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
    
    if(_calculator.selected==NO)
    {
        CGRect frame= _calculator.frame;
        cal=[[Calculator alloc]initWithFrame:CGRectMake(frame.origin.x-40,self.view.frame.size.height-382-70,251,382)];
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
        _discountBtn.selected=YES;
        CGRect frame = _discountBtn.frame;
        dis= [[Discount alloc]initWithFrame:CGRectMake(frame.origin.x-40, self.view.frame.size.height-286-70, 100, 200)];
        dis.backgroundColor=[UIColor redColor];
        dis.delegate=self;
        [self.view addSubview:dis];
    }
    
}
#pragma markDiscount Delegate.
-(void)reslut:(NSString *)str
{
    _cstdDataModel.defaultsCustomer.discount=[str stringByAppendingString:@"%"];
    [self fillLabelsWithText:_presentCustomerBtn];

}

- (IBAction)jumptoMenuVC:(id)sender
{
    MenuViewController *men=[self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    [self.navigationController popToViewController:men animated:YES];
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
        containerView.hidden=NO;
        _futureDelivery.selected=YES;
    }
    
}
-(void)calendarFunction
{
    CGRect frame = _futureDelivery.frame;
    containerView=[[UIView alloc]initWithFrame:CGRectMake(frame.origin.x-40, self.view.frame.size.height-350-70, 350, 350)];
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
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *str=[monthFormatter stringFromDate:selectedDate];
    _cstdDataModel.defaultsCustomer.dateFuture=str;
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
//
//-(void)deactiveWSCalendarWithDate:(NSDate *)selectedDate{
//    
//    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
//    [monthFormatter setDateFormat:@"dd MMMM yyyy"];
//    NSString *str=[monthFormatter stringFromDate:selectedDate];
//}

- (IBAction)hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
}
- (IBAction)placeOrderClick:(id)sender {
    
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
@end
