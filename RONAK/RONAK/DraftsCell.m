//
//  DraftsCell.m
//  RONAK
//
//  Created by Gaian on 1/25/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import "DraftsCell.h"

@implementation DraftsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindData:(DraftsDataModel*)drft{
    _sfIDLabel.text=drft.Id;
    NSArray *arr=[drft.Order_Line_Items__r.records valueForKey:@"Brand__c"];
    NSSet *set=[NSSet setWithArray:arr];
    arr=[set allObjects];
    NSArray *qty=[drft.Order_Line_Items__r.records valueForKey:@"Quantity__c"];
    NSNumber * sum = [qty valueForKeyPath:@"@sum.self"];
    _quantityLabel.text=[NSString stringWithFormat:@"%@",sum];
    _brandLabel.text=[arr componentsJoinedByString:@","];
    _discountLabel.text=[drft.Discount__c stringByAppendingString:@"%"];
    [_amountLabel setTitle:drft.Net_Amount__c forState:UIControlStateNormal];
    _cstNameLabel.text=drft.Account__c;
}

@end
