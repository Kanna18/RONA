//
//  ShippingAddressViewController.m
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ShippingAddressViewController.h"
#import "PDCViewController.h"

@interface ShippingAddressViewController ()

@end

@implementation ShippingAddressViewController{
    
    LoadingView *load;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self scrollViewDisplayListofCstmrs];
    _customerNamelbl.font=sfFont(28);
    
    _pdcLbl.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pdcLabelTapped:)];
    tap.numberOfTapsRequired=1;
    [_pdcLbl addGestureRecognizer:tap];
    
    load=[[LoadingView alloc]init];
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
-(void)fillLabelsWithText:(CustomButton*)btn{
    
    [UIView transitionWithView: self.view
                           duration: 0.35f
                            options: UIViewAnimationOptionTransitionCrossDissolve
                         animations: ^(void)
          {
          }
                    completion: nil];
    
    _cst=btn.cstData;
    [btn setBackgroundColor:BlueClr];
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
    
    float pdcAmount = 0.0;
    for (int i=0; i<cst.PDC__r.records.count; i++)
    {
        PDCRecodrs *rec=cst.PDC__r.records[i];
        pdcAmount+=[rec.Amount__c floatValue];
    }
    _pdcLbl.text=[NSString stringWithFormat:@"%0.1f",pdcAmount];
    
    [self showaddresses:btn];
    
}

-(void)showaddresses:(CustomButton*)btn{
    
    
    for (id sub in _billAddress_scrlView.subviews) {
        [sub removeFromSuperview];
    }
    for (id sub in _shipAddress_scrlView.subviews) {
        [sub removeFromSuperview];
    }
    
    CustomerDataModel *cst=btn.cstData;
    NSString *billAddress=[NSString stringWithFormat:@"%@,\n%@,\n%@,\n%@.",cst.BillingStreet,cst.BillingState,cst.BillingCity,cst.BillingPostalCode];
    
    UITextView *textVi=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, _billAddress_scrlView.frame.size.width-10, _billAddress_scrlView.frame.size.height-10)];
    [_billAddress_scrlView addSubview:textVi];
    textVi.text=billAddress;
    textVi.font=sfFont(20);
    textVi.userInteractionEnabled=NO;
    
    
    //Shipping address.
    NSArray *arr=cst.Ship_to_Party__r.records;
    int vX=20 , vY=5 , bX=0, bY=15;
    for (int i=0; i<arr.count; i++)
    {
        Recodrs *rec=(Recodrs*)arr[i];
        NSString *shpAddress=[NSString stringWithFormat:@"%@,\n%@,\n%@,\n%@.",rec.Street__c,rec.City__c,rec.State__c,rec.Zipcode__c];
        UITextView *textVi=[[UITextView alloc]initWithFrame:CGRectMake(vX, vY, _billAddress_scrlView.frame.size.width, _billAddress_scrlView.frame.size.height-20)];
        [_shipAddress_scrlView addSubview:textVi];
        textVi.text=shpAddress;
        textVi.font=sfFont(18);
        textVi.userInteractionEnabled=NO;
        
        CustomButton *btn=[CustomButton buttonWithType:UIButtonTypeSystem];
        btn.cstData=cst;
        btn.frame=CGRectMake(bX, bY, 15, 15);
        btn.tag=100+i;
        [_shipAddress_scrlView addSubview:btn];
        [btn addTarget:self action:@selector(selectedAddress:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:GrayLight];
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        vY+=_billAddress_scrlView.frame.size.height-20;
        bY+=_billAddress_scrlView.frame.size.height-20;
        
        if([cst.defaultsCustomer.defaultAddressIndex isEqual:[NSNumber numberWithInteger:i]])
        {
//            btn.backgroundColor=BlueClr;
            [btn setBackgroundImage:[UIImage imageNamed:@"checkBlue"] forState:UIControlStateNormal];
        }
    }
    _shipAddress_scrlView.showsVerticalScrollIndicator=YES;
    _shipAddress_scrlView.contentSize=CGSizeMake(0, vY+20);

    
}
-(void)selectedAddress:(CustomButton*)sender
{
    for (CustomButton *btn in _shipAddress_scrlView.subviews)
    {
        if([btn isKindOfClass:[CustomButton class]])
        {
            if(btn.tag)
            {
                [btn setBackgroundColor:GrayLight];
                [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            }
        }
    }
    sender.cstData.defaultsCustomer.defaultAddressIndex=[NSNumber numberWithInteger:sender.tag-100];
    //sender.backgroundColor=BlueClr;
    [sender setBackgroundImage:[UIImage imageNamed:@"checkBlue"] forState:UIControlStateNormal];
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
- (IBAction)jumptoMenuVC:(id)sender
{
    MenuViewController *men=[self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    [self.navigationController popToViewController:men animated:YES];
}
@end
