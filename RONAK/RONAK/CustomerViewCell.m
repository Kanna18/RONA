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
    [self drawBorders:_customerName];
    [self drawBorders:_increment];
    [self drawBorders:_decrement];
    
    _clearButton.hidden=YES;
}



- (IBAction)incrementClick:(id)sender {
    
    int count=(int)_cstData.defaultsCustomer.itemsCount.count;
    if(count>=0)
    {
        [_cstData.defaultsCustomer.itemsCount addObject:ronakGlobal.item];
    }
    else
    {
        showMessage(@"No item Selected", self.contentView.superview);
    }
    NSCountedSet *set=[NSCountedSet setWithArray:_cstData.defaultsCustomer.itemsCount];
    int itemCount =(int)[set countForObject:ronakGlobal.item];
    _countLabel.text=[NSString stringWithFormat:@"%d",itemCount];
}
- (IBAction)decrementClick:(id)sender {

    
    if((_cstData.defaultsCustomer.itemsCount.count>0))
    {
        if([_cstData.defaultsCustomer.itemsCount containsObject:ronakGlobal.item])
        {
            [_cstData.defaultsCustomer.itemsCount removeObjectAtIndex:_cstData.defaultsCustomer.itemsCount.count-1];
        }
    }
    else
    {
        showMessage(@"No item Selected", self.superview);
    }
    NSCountedSet *set=[NSCountedSet setWithArray:_cstData.defaultsCustomer.itemsCount];
    int itemCount =(int)[set countForObject:ronakGlobal.item];
    _countLabel.text=[NSString stringWithFormat:@"%d",itemCount];
}

-(void)drawBorders:(id)element{
    if([element isKindOfClass:[CustomButton class]])
    {
        CustomButton *cst=element;
        cst.layer.borderColor=[UIColor lightGrayColor].CGColor;
        cst.layer.borderWidth=1.0f;
        cst.layer.shadowColor=[UIColor lightGrayColor].CGColor;
        cst.layer.shadowOffset=CGSizeMake(5.0, 5.0);
        cst.layer.shadowRadius=8.0f;
        cst.layer.shadowOpacity=5.0f;
    }
}
-(void)bindData:(CustomerDataModel*)cstData{
    
    _cstData=cstData;
    [_customerName setTitle:_cstData.Name forState:UIControlStateNormal];
    
    NSCountedSet *set=[NSCountedSet setWithArray:_cstData.defaultsCustomer.itemsCount];
    int itemCount =(int)[set countForObject:ronakGlobal.item];
    _countLabel.text=[NSString stringWithFormat:@"%d",itemCount];
    
    if(ronakGlobal.showClearOptionInCustomerCell)
    {
        _clearButton.hidden=NO;
    }
    else{
        _clearButton.hidden=YES;
    }
    
}

- (IBAction)clearCustomerClick:(id)sender {
    
    [ronakGlobal.selectedCustomersArray removeObject:self.cstData];
    [_delegate customerNameDeleted];
    
}
@end
