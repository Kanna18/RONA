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
    

    _addressLabel.textColor=[UIColor grayColor];
    
//    self.selectedImage.layer.borderColor=RGB(209, 210, 212).CGColor;
//    self.selectedImage.layer.borderWidth=1.0;
//    _selectedImage.layer.cornerRadius=5.0f;
//    _selectedImage.clipsToBounds=YES;
//    
}

-(void)bindData:(CustomerDataModel*)data
{
    _nameLabel.font=gothBold(16);
    _addressLabel.font=gothMedium(12);
    _amountLabel.font=gothMedium(16);
    self.nameLabel.text=[data.Name uppercaseString];
    self.addressLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",data.ShippingAddress.street,data.ShippingAddress.state,data.ShippingAddress.postalCode,data.ShippingAddress.country];
    self.amountLabel.text=[NSString stringWithFormat:@"₹%@",data.Account_Balance__c];
//    self.selectedImage.backgroundColor=GrayLight;
    self.selectedImage.image=[UIImage imageNamed:@"grayBackground"];
    float due=[data.X181_240__c floatValue]+[data.X241_300__c floatValue]+[data.X301_360__c floatValue]+[data.X361__c floatValue]/*+[data.X0_30__c floatValue]+[data.X31_60__c floatValue]+[data.X61_90__c floatValue]+[data.X91_120__c floatValue]+[data.X121_150__c floatValue]+[data.X151_180__c floatValue]*/;
    
    if(due>0)
    {
        _amountLabel.textColor=RedClr;
    }
    else{
        _amountLabel.textColor=GreenClr;
    }
    _amountLabel.text=[NSString stringWithFormat:@"180 + = ₹%d",(int)due];
    self.cstData=data;

}
-(void)loadSelectedCustomerFromArrat:(NSMutableArray*)arr
{
    if([arr containsObject:self.cstData])
    {
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
//        self.selectedImage.backgroundColor=GrayLight;
      self.selectedImage.image=[UIImage imageNamed:@"grayBackground"];
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
