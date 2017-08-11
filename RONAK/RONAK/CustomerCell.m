//
//  CustomerCell.m
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomerCell.h"

@implementation CustomerCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)bindData:(CustomerDataModel*)data
{
    self.nameLabel.text=data.Name;
    self.addressLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",data.ShippingAddress.street,data.ShippingAddress.state,data.ShippingAddress.postalCode,data.ShippingAddress.country];
    self.amountLabel.text=[NSString stringWithFormat:@"₹%@",data.Account_Balance__c];
    self.selectedImage.backgroundColor=[UIColor grayColor];
    self.cstData=data;
    
}
-(void)loadSelectedCustomerFromArrat:(NSMutableArray*)arr
{
    if([arr containsObject:self.cstData])
    {
        self.selectedImage.backgroundColor=[UIColor blueColor];
        self.baseView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.baseView.layer.shadowOffset = CGSizeMake(5, 5);
        self.baseView.layer.shadowOpacity = 1;
        self.baseView.layer.shadowRadius = 1.0;
        self.baseView.layer.borderWidth=1.0;
        self.baseView.layer.borderColor=[UIColor grayColor].CGColor;
    }
    else
    {
        self.selectedImage.backgroundColor=[UIColor grayColor];
        self.baseView.layer.shadowColor = [UIColor whiteColor].CGColor;
        self.baseView.layer.shadowOffset = CGSizeMake(0, 0);
        self.baseView.layer.shadowOpacity = 0;
        self.baseView.layer.shadowRadius = 0.0;
        self.baseView.layer.borderWidth=0.0;
        self.baseView.layer.borderColor=[UIColor whiteColor].CGColor;
    }
}
-(void)saveSelectedCustomertoArray:(NSMutableArray*)arr
{
    
   /*if([arr containsObject:self.cstData.BP_Code__c])
    {
        [arr removeObject:self.cstData.BP_Code__c];
    }
    else
    {
        [arr addObject:self.cstData.BP_Code__c];
    }*/
    
    if([arr containsObject:self.cstData])
    {
        [arr removeObject:self.cstData];
    }
    else
    {
        [arr addObject:self.cstData];
    }
    
    
}
@end
