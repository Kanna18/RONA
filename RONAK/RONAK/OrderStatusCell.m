//
//  OrderStatusCell.m
//  RONAK
//
//  Created by Gaian on 10/30/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "OrderStatusCell.h"
#import "RepotrsPopTV.h"
@implementation OrderStatusCell{
    
    OrderStatusViewController *orderStatusVC;
    OrderStatusCustomResponse *currentresponse;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindData:(OrderStatusCustomResponse*)resp superViewCon:(OrderStatusViewController*)superVc;
{
    _dateLbl.text=@"";
    _brandLabel.text=@"";
    _qtyLabel.text=@"";
    _invoiceIDLbl.text=@"";
    _customerNameLabel.text=@"";
    _discLabel.text=@"";
    _amountLabel.text=@"";
    [_statusBtn setTitle:@"" forState:UIControlStateNormal];
    
    [_sfID setAdjustsFontSizeToFitWidth:YES];
    [_invoiceIDLbl setAdjustsFontSizeToFitWidth:YES];
    [_dateLbl setAdjustsFontSizeToFitWidth:YES];
    
    _sfID.text=resp.Name;
    _customerNameLabel.text=resp.Customer_Name__c;
    orderStatusVC=superVc;
    currentresponse=resp;
    _dateLbl.text=resp.CreatedDate;
    _brandLabel.text=resp.Brand__c;
    _qtyLabel.text=resp.Quantity__c;
    _discLabel.text=resp.Discount__c;
    _amountLabel.text=resp.Net_Amount__c;
    _dateLbl.text=[resp.CreatedDate substringToIndex:10];
    
    if(resp.typeOfRec==INVOICE_Type)
    {
        _dateLbl.text=@"";
        _invoiceIDLbl.text=resp.record.typeName;
        _dateLbl.text=resp.record.typeDate__c;
    }
    if(resp.typeOfRec==DELIVERY_Type)
    {
        _dateLbl.text=@"";
        _dateLbl.text=resp.record.typeDate__c;

    }
    
}

- (IBAction)statusClick:(id)sender {
    
    [orderStatusVC.reportStatus bindData:currentresponse];
}
@end
