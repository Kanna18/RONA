//
//  ShippingAddressViewController.m
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ShippingAddressViewController.h"

@interface ShippingAddressViewController ()

@end

@implementation ShippingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self scrollViewDisplayListofCstmrs];
    _customerNamelbl.font=sfFont(28);
    
    _pdcLbl.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pdcLabelTapped:)];
    tap.numberOfTapsRequired=1;
    [_pdcLbl addGestureRecognizer:tap];
}

-(void)scrollViewDisplayListofCstmrs
{
    __block int X=0,Y=0;
    [selectedCustomersList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CustomerDataModel *cst=selectedCustomersList[idx];
        CustomButton *btn=[CustomButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:cst.Name forState:UIControlStateNormal];
        btn.frame=CGRectMake(X, Y, btn.titleLabel.intrinsicContentSize.width+20, 40);
        btn.cstData=cst;
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clikedOnCustomer:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView_Cmlist addSubview:btn];
        X+=btn.titleLabel.intrinsicContentSize.width+25;
        
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
            [btn setBackgroundColor:[UIColor grayColor]];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    [self fillLabelsWithText:sender];
}
-(void)fillLabelsWithText:(CustomButton*)btn{
    
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CustomerDataModel *cst=btn.cstData;    
    _customerNamelbl.text=cst.Name;
    _creditLimitLbl.text=cst.Credit_Limit__c;
    _acntBalanceLbl.text=cst.Account_Balance__c;
    NSString *status=[cst.Active__c isEqualToString:@"Y"]?@"Active":@"Inactive";
    _statusLbl.text=status;
    _Lbl90.text=[NSString stringWithFormat:@"%0.2f",[cst.X0_30__c floatValue]+[cst.X31_60__c floatValue]+[cst.X61_90__c floatValue]];
    _lbl150.text=[NSString stringWithFormat:@"%0.2f",[cst.X91_120__c floatValue]+[cst.X121_150__c floatValue]];
    _lbl180.text=[NSString stringWithFormat:@"%0.2f",[cst.X151_180__c floatValue]];
    _lbl360.text=[NSString stringWithFormat:@"%0.2f",[cst.X181_240__c floatValue]+[cst.X241_300__c floatValue]+[cst.X301_360__c floatValue]];
    _lbl360Above.text=[NSString stringWithFormat:@"%0.2f",[cst.X361__c floatValue]];
    _lblTotal.text=[NSString stringWithFormat:@"%0.2f",[_Lbl90.text floatValue]+[_lbl150.text floatValue]+[_lbl180.text floatValue]+[_lbl360.text floatValue]+[_lbl360Above.text floatValue]];
    [self showaddresses:btn];
    
}

-(void)showaddresses:(CustomButton*)btn{
    CustomerDataModel *cst=btn.cstData;
    
    NSString *billAddress=[NSString stringWithFormat:@"%@,\n%@,\n%@,\n%@.",cst.BillingStreet,cst.BillingState,cst.BillingCity,cst.BillingPostalCode];
    
    UITextView *textVi=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, _billAddress_scrlView.frame.size.width-10, _billAddress_scrlView.frame.size.height-10)];
    [_billAddress_scrlView addSubview:textVi];
    textVi.text=billAddress;
    textVi.font=sfFont(20);
    textVi.userInteractionEnabled=NO;
    
    
    //Shipping address.
    NSArray *arr=cst.Ship_to_Party__r.records;
    int vX=40 , vY=10 , bX=0, bY=15;
    for (int i=0; i<arr.count; i++)
    {
        Recodrs *rec=(Recodrs*)arr[i];
        NSString *shpAddress=[NSString stringWithFormat:@"%@,\n%@,\n%@,\n%@.",rec.Street__c,rec.City__c,rec.State__c,rec.Zipcode__c];
        UITextView *textVi=[[UITextView alloc]initWithFrame:CGRectMake(vX, vY, _billAddress_scrlView.frame.size.width, _billAddress_scrlView.frame.size.height-20)];
        [_shipAddress_scrlView addSubview:textVi];
        textVi.text=shpAddress;
        textVi.font=sfFont(18);
        textVi.userInteractionEnabled=NO;
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(bX, bY, 30, 30);
        [_shipAddress_scrlView addSubview:btn];
        btn.tag=100;
        [btn addTarget:self action:@selector(selectedAddress:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        vY+=_billAddress_scrlView.frame.size.height-20;
        bY+=_billAddress_scrlView.frame.size.height-20;
    }
    _shipAddress_scrlView.showsVerticalScrollIndicator=YES;
    _shipAddress_scrlView.contentSize=CGSizeMake(0, vY+20);

    
}
-(void)selectedAddress:(UIButton*)sender
{
    for (UIButton *btn in _shipAddress_scrlView.subviews)
    {
        if([btn isKindOfClass:[UIButton class]])
        {
            if(btn.tag)
            {
                [btn setBackgroundColor:[UIColor grayColor]];
            }
        }
    }
    sender.backgroundColor=[UIColor blueColor];
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
@end
