//
//  ShippingAddressViewController.m
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ShippingAddressViewController.h"
#import "PDCViewController.h"
#import "CustomersViewController.h"
#import "DefaultFiltersViewController.h"
#import "BillAddressVC.h"


@interface ShippingAddressViewController ()

@end

@implementation ShippingAddressViewController{
    
    LoadingView *load;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self scrollViewDisplayListofCstmrs];
    _pdcLbl.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pdcLabelTapped:)];
    tap.numberOfTapsRequired=1;
    [_pdcLbl addGestureRecognizer:tap];
    
    load=[[LoadingView alloc]init];
    
    _leftSwipe.numberOfTouchesRequired=noOfTouches;
    _leftSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    _rightSwipe.numberOfTouchesRequired=noOfTouches;
    _leftSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    
    
    _billtoHeading.font=gothMedium(14);
    _shipToHeading.font=gothMedium(14);
    
    UITapGestureRecognizer *taped=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumptoMenuVC:)];
    taped.numberOfTouchesRequired=1;
    _headingBarLabel.font=gothBold(14);
    [_headingLabel addGestureRecognizer:taped];
    
//    UITapGestureRecognizer *custLblTapped=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBillsOfCustomer:)];
//    taped.numberOfTouchesRequired=1;
//    _customerNamelbl.userInteractionEnabled=YES;
//    [_customerNamelbl addGestureRecognizer:custLblTapped];
    

}
-(void)showBillsOfCustomer:(id)sender
{
    BillAddressVC *bilVc=storyBoard(@"billVC");
    [self .navigationController pushViewController:bilVc animated:YES];
}

-(void)pdcLabelTapped:(id*)sender
{
    if(_cst.PDC__r.records.count>0)
    {
        PDCViewController *pdcVC=[self.storyboard instantiateViewControllerWithIdentifier:@"pdcVC"];
        pdcVC.cst=_cst;
        [self.navigationController pushViewController:pdcVC animated:YES];
    }
    else
    {
        [load waringLabelText:@"No PDC Details" onView:self.view];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
-(void)scrollViewDisplayListofCstmrs
{
    __block int X=0,Y=0;
    [selectedCustomersList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CustomerDataModel *cst=selectedCustomersList[idx];
        CustomButton *btn=[CustomButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
        [btn setTitle:[@" " stringByAppendingString:cst.Name] forState:UIControlStateNormal];
        [btn.titleLabel setTextColor:RGB(64, 64, 65)];
//        btn.titleLabel.intrinsicContentSize.width+2
        btn.frame=CGRectMake(X, Y, 200, 30);
        btn.cstData=cst;
        [btn setBackgroundColor:RGB(228,230,232)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clikedOnCustomer:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=gothBook(14);
        [_scrollView_Cmlist addSubview:btn];
        X+=208;

        if(idx==0){
            [self fillLabelsWithText:btn];
        }
    }];
    _scrollView_Cmlist.contentSize=CGSizeMake(X+20, 0);
}

-(void)clikedOnCustomer:(CustomButton*)sender
{
    for (CustomButton *btn in _scrollView_Cmlist.subviews) {
        if([btn isKindOfClass:[CustomButton class]])
        {
            btn.titleLabel.font=gothMedium(14);
            [btn setBackgroundColor:GrayLight];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    [self fillLabelsWithText:sender];
}
-(void)fillLabelsWithText:(CustomButton*)btn{
    
    [UIView transitionWithView: self.view
                           duration: 0.35f
                            options: UIViewAnimationOptionTransitionCrossDissolve
                         animations: ^(void)
          {
          }
                    completion: nil];
    
    _cst=btn.cstData;
    btn.titleLabel.font=gothBook(14);
    [btn setBackgroundColor:BlueClr];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CustomerDataModel *cst=btn.cstData;    
    _customerNamelbl.text=cst.Name;
    _customerNamelbl.font=gothMedium(20);
    _customerNamelbl.textColor=BlueClr;
    
    
    _creditLimitLbl.text=[self numberFormatter:[cst.Credit_Limit__c floatValue]];
    _acntBalanceLbl.text=[self numberFormatter:[cst.Account_Balance__c floatValue]];
    NSString *status=[cst.Active__c isEqualToString:@"Y"]?@"Active":@"Inactive";
    _statusLbl.text=status;
    
    double ninty=[cst.X0_30__c floatValue]+[cst.X31_60__c floatValue]+[cst.X61_90__c floatValue];
    _Lbl90.text=[NSString stringWithFormat:@"%@",[self numberFormatter:ninty]];
    
    double oneFifity=[cst.X91_120__c floatValue]+[cst.X121_150__c floatValue];
    _lbl150.text=[NSString stringWithFormat:@"%@",[self numberFormatter:oneFifity]];
   
    double oneEighty=[cst.X151_180__c floatValue];
    _lbl180.text=[NSString stringWithFormat:@"%@",[self numberFormatter:oneEighty]];
    
    double treSixty=[cst.X181_240__c floatValue]+[cst.X241_300__c floatValue]+[cst.X301_360__c floatValue];
    _lbl360.text=[NSString stringWithFormat:@"%@",[self numberFormatter:treSixty]];
    
    double treSixAbov=[cst.X361__c floatValue];
    _lbl360Above.text=[NSString stringWithFormat:@"%@",[self numberFormatter:treSixAbov]];
    
    double all=ninty+oneFifity+oneEighty+treSixty+treSixAbov;
    _lblTotal.text=[NSString stringWithFormat:@"%@",[self numberFormatter:all]];
    
    float pdcAmount = 0.0;
    for (int i=0; i<cst.PDC__r.records.count; i++)
    {
        PDCRecodrs *rec=cst.PDC__r.records[i];
        pdcAmount+=[rec.Amount__c floatValue];
    }
    _pdcLbl.text=[self numberFormatter:pdcAmount];
    _pdcLbl.textColor=BlueClr;
    [self showaddresses:btn];
    
    
    [_creditLimitLbl labelleftPadding];
    [_acntBalanceLbl labelleftPadding];
    [_pdcLbl labelleftPadding];
    [_statusLbl labelleftPadding];
}

-(NSString*)numberFormatter:(float)fValue
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    NSString *result = [numberFormatter stringFromNumber:@(fValue)];
    return result;
    
}

-(void)showaddresses:(CustomButton*)btn{
    
    for (id sub in _billAddress_scrlView.subviews) {
        [sub removeFromSuperview];
    }
    for (id sub in _shipAddress_scrlView.subviews) {
        [sub removeFromSuperview];
    }
    
    CustomerDataModel *cst=btn.cstData;
    NSString *billAddress=[NSString stringWithFormat:@"%@,\n%@,\n%@,\n%@.",cst.Address_Street__c,cst.Address_State__c,cst.Address_City__c,cst.Address_Zip_Code__c];
    
    UITextView *textVi=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, _billAddress_scrlView.frame.size.width-10, _billAddress_scrlView.frame.size.height-10)];
    textVi.font=gothBook(12);
    textVi.textColor=RGB(45, 45, 45);
    [_billAddress_scrlView addSubview:textVi];
    textVi.text=billAddress;
    textVi.userInteractionEnabled=NO;
    
    //Shipping address.
    NSArray *arr=cst.Ship_to_Party__r.records;
    int vX=18 , vY=10 , bX=1, bY=13;
    for (int i=0; i<arr.count; i++)
    {
        Recodrs *rec=(Recodrs*)arr[i];
        NSString *shpAddress=[NSString stringWithFormat:@"%@,\n%@,\n%@,\nGSTIN : (nil) ",rec.Street__c,rec.City__c,rec.Zipcode__c];
        UITextView *textVi=[[UITextView alloc]initWithFrame:CGRectMake(vX, vY, _billAddress_scrlView.frame.size.width, _billAddress_scrlView.frame.size.height-20)];
        textVi.font=gothBook(12);
        textVi.textColor=RGB(45, 45, 45);
        [_shipAddress_scrlView addSubview:textVi];
        textVi.text=shpAddress;
        textVi.userInteractionEnabled=YES;
        textVi.tag=i+10;
        textVi.editable=NO;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedAddress:)];
        [textVi addGestureRecognizer:tap];
        tap.numberOfTapsRequired=1;
        
        CustomButton *btn=[CustomButton buttonWithType:UIButtonTypeSystem];
        btn.cstData=cst;
        btn.frame=CGRectMake(bX, bY, 15, 15);
        btn.tag=100+i;
        [_shipAddress_scrlView addSubview:btn];
        [btn addTarget:self action:@selector(selectedAddress:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"uncheckFilter"] forState:UIControlStateNormal];
        //btn.layer.borderColor=GrayLight.CGColor;
        //btn.layer.borderWidth=0.5;
        //btn.layer.cornerRadius=4.0;
//        [btn setBackgroundColor:GrayLight];
        //[btn setBackgroundImage:nil forState:UIControlStateNormal];
        vY+=_billAddress_scrlView.frame.size.height-20;
        bY+=_billAddress_scrlView.frame.size.height-20;
        
        if([cst.defaultsCustomer.defaultAddressIndex isEqual:[NSNumber numberWithInteger:i]])
        {
//            btn.backgroundColor=BlueClr;
            [btn setBackgroundImage:[UIImage imageNamed:@"checkBlue"] forState:UIControlStateNormal];
        }
    }
    _shipAddress_scrlView.showsVerticalScrollIndicator=YES;
    _shipAddress_scrlView.contentSize=CGSizeMake(0, vY+25);

    
}
-(void)selectedAddress:(CustomButton*)sender
{
    CustomButton *myBtn;
    if([sender isKindOfClass:[UITapGestureRecognizer class]])
    {
        UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
        UITextView *text = (UITextView *)recognizer.view;
        myBtn=(CustomButton*)[self.view viewWithTag:text.tag+90];
    }
    else
    {
        myBtn=sender;
    }
    for (CustomButton *btn in _shipAddress_scrlView.subviews)
    {
        if([btn isKindOfClass:[CustomButton class]])
        {
            if(btn.tag)
            {
                //btn.layer.borderColor=GrayLight.CGColor;
                //btn.layer.borderWidth=0.5;
                //                [btn setBackgroundColor:GrayLight];
                [btn setBackgroundImage:[UIImage imageNamed:@"uncheckFilter"] forState:UIControlStateNormal];
            }
        }
    }
    
    myBtn.cstData.defaultsCustomer.defaultAddressIndex=[NSNumber numberWithInteger:myBtn.tag-100];
    //sender.backgroundColor=BlueClr;
    [myBtn setBackgroundImage:[UIImage imageNamed:@"checkBlue"] forState:UIControlStateNormal];
   
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
    
    NSArray *arr=self.navigationController.viewControllers;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[CustomersViewController class]])
        {
            [self.navigationController popToViewController:(CustomersViewController*)obj animated:YES];
            return ;
        }
    }];

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
- (IBAction)pushSwipe:(id)sender {
    
    DefaultFiltersViewController *dvc=storyBoard(@"defaultVC");
    [self.navigationController pushViewController:dvc animated:YES];
}
@end
