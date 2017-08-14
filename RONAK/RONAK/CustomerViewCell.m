//
//  CustomerViewCell.m
//  RONAK
//
//  Created by Gaian on 8/13/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomerViewCell.h"

@implementation CustomerViewCell
{
    int Count;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    Count=0;
    
    [self drawBorders:_customerName];
    [self drawBorders:_increment];
    [self drawBorders:_decrement];
    
}
- (IBAction)incrementClick:(id)sender {
    
    Count++;
    _countLabel.text=[NSString stringWithFormat:@"%d",Count];
    
}
- (IBAction)decrementClick:(id)sender {
    if(Count>0)
    Count--;
    _countLabel.text=[NSString stringWithFormat:@"%d",Count];
}

-(void)drawBorders:(id)element{
    if([element isKindOfClass:[CustomButton class]])
    {
        CustomButton *cst=element;
        cst.layer.borderColor=[UIColor lightGrayColor].CGColor;
        cst.layer.borderWidth=1.0f;
        cst.layer.shadowColor=[UIColor lightGrayColor].CGColor;
        cst.layer.shadowOffset=CGSizeMake(1.0, 1.0);
        cst.layer.shadowRadius=1.0f;
        cst.layer.shadowOpacity=1.0f;
        
    }
}
@end
