//
//  PDCCell.m
//  RONAK
//
//  Created by Gaian on 8/16/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "PDCCell.h"

@implementation PDCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)bindData:(PDCRecodrs*)rec
{
    _chequeNo.text=rec.Cheque_No__c;
    _chequeDate.text=rec.Cheque_Date__c;
    _amount.text=rec.Amount__c;
    _drawOn.text=rec.Customer_Bank__c;
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
