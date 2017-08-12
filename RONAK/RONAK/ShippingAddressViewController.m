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
