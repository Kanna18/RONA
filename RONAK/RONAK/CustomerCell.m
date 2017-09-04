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
    _selectedImage.layer.cornerRadius=3.0f;
    _selectedImage.clipsToBounds=YES;
    
    _addressLabel.font=sfFont(15);
    _addressLabel.textColor=[UIColor grayColor];
}

-(void)bindData:(CustomerDetails*)data
{
    self.nameLabel.text=data.name;
    self.addressLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",data.shippingAddress.street,data.shippingAddress.state,data.shippingAddress.postalCode,data.shippingAddress.country];
    self.amountLabel.text=[NSString stringWithFormat:@"₹%@",data.account_Balance__c];
    self.selectedImage.backgroundColor=GrayLight;
    
    float due=[data.x181_240__c floatValue]+[data.x241_300__c floatValue]+[data.x301_360__c floatValue]+[data.x361__c floatValue]+[data.x0_30__c floatValue]+[data.x31_60__c floatValue]+[data.x61_90__c floatValue]+[data.x91_120__c floatValue]+[data.x121_150__c floatValue]+[data.x151_180__c floatValue];
    
    if(due>0||due<0)
    {
        _amountLabel.textColor=RedClr;
    }
    else{
        _amountLabel.textColor=GreenClr;
    }
    _amountLabel.text=[NSString stringWithFormat:@"180+=₹%d",(int)due];
    self.cstData=data;

}
-(void)loadSelectedCustomerFromArrat:(NSMutableArray*)arr
{
    if([arr containsObject:self.cstData])
    {
//        self.selectedImage.backgroundColor=BlueClr;
        self.selectedImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
//        self.baseView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//        self.baseView.layer.shadowOffset = CGSizeMake(5, 5);
//        self.baseView.layer.shadowOpacity = 1;
//        self.baseView.layer.shadowRadius = 1.0;
//        self.baseView.layer.borderWidth=1.0;
//        self.baseView.layer.borderColor=[UIColor grayColor].CGColor;
    }
    else
    {
        self.selectedImage.backgroundColor=GrayLight;
        self.selectedImage.image=nil;
//        self.baseView.layer.shadowColor = [UIColor whiteColor].CGColor;
//        self.baseView.layer.shadowOffset = CGSizeMake(0, 0);
//        self.baseView.layer.shadowOpacity = 0;
//        self.baseView.layer.shadowRadius = 0.0;
//        self.baseView.layer.borderWidth=0.0;
//        self.baseView.layer.borderColor=[UIColor whiteColor].CGColor;
    }
}
-(void)saveSelectedCustomertoArray:(NSMutableArray*)arr
{
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
