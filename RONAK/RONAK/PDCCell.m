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
    for (CustomLabel *lbl in self.contentView.subviews)
    {
        if([lbl isKindOfClass:[CustomLabel class]])
        {
            lbl.layer.borderColor=[[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
            lbl.layer.borderWidth=1.0f;
            lbl.clipsToBounds=YES;
        }
    }
}

-(void)bindData:(PDCRecodrs*)rec
{
    _chequeNo.text=rec.Cheque_No__c;
    _chequeDate.text=rec.Receipt_Date__c;
    _amount.text=rec.Amount__c;
    _drawOn.text=rec.Customer_Bank__c;
    _cheQueType.text=rec.attributes.type;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
