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
    OrderStatsResponse *currentresponse;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindData:(OrderStatsResponse*)resp superViewCon:(OrderStatusViewController*)superVc;
{
    [_sfID setAdjustsFontSizeToFitWidth:YES];
    _sfID.text=resp.Id;
    _customerNameLabel.text=resp.Customer_Name__c;
    orderStatusVC=superVc;
    currentresponse=resp;
    
}

- (IBAction)statusClick:(id)sender {
    
    [orderStatusVC.reportStatus bindData:currentresponse];
}
@end
