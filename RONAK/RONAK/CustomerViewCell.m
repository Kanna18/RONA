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
    int allItemsCount;
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
        [self addtoCustomerBasket:ronakGlobal.selectedItemsTocartArr add:YES];
    }
    else{
        showMessage(@"No item Selected", self.contentView.superview);
    }
    if(ronakGlobal.selectedItemsTocartArr.count==1){
        NSCountedSet *set=[NSCountedSet setWithArray:_cstData.defaultsCustomer.itemsCount];
        int itemCount =(int)[set countForObject:ronakGlobal.selectedItemsTocartArr.lastObject];
        _countLabel.text=[NSString stringWithFormat:@"%d",itemCount];
    }
    else{
        unsigned long value=[_countLabel.text integerValue];
        value++;
        _countLabel.text=[NSString stringWithFormat:@"%ld",value];
    }
    [_delegate cartCount];
}

- (IBAction)decrementClick:(id)sender {
    
    if((_cstData.defaultsCustomer.itemsCount.count>0))
    {
        [self addtoCustomerBasket:ronakGlobal.selectedItemsTocartArr add:NO];
    }
    else
    {
        showMessage(@"No item Selected", self.superview);
    }
    if(ronakGlobal.selectedItemsTocartArr.count==1){
        NSCountedSet *set=[NSCountedSet setWithArray:_cstData.defaultsCustomer.itemsCount];
        int itemCount =(int)[set countForObject:ronakGlobal.selectedItemsTocartArr.lastObject];
        _countLabel.text=[NSString stringWithFormat:@"%d",itemCount];
    }
    else{
        unsigned long value=[_countLabel.text integerValue];
        if(value>0){
        value--;
        _countLabel.text=[NSString stringWithFormat:@"%ld",value];
        }
    }
    [_delegate cartCount];

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
    if(ronakGlobal.selectedItemsTocartArr.count==1)
    {
        NSCountedSet *set=[NSCountedSet setWithArray:_cstData.defaultsCustomer.itemsCount];
        int itemCount =(int)[set countForObject:ronakGlobal.selectedItemsTocartArr.lastObject];
        _countLabel.text=[NSString stringWithFormat:@"%d",itemCount];
    }else{
        _countLabel.text=@"0";
    }
    if(ronakGlobal.showClearOptionInCustomerCell){
        _clearButton.hidden=NO;
    }else{
        _clearButton.hidden=YES;
    }
}

-(void)addtoCustomerBasket:(NSMutableArray*)arr add:(BOOL)add
{
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if(add==YES){
            [_cstData.defaultsCustomer.itemsCount addObject:obj];
        }
        else if(add==NO){
            if([_cstData.defaultsCustomer.itemsCount containsObject:obj]){
                [_cstData.defaultsCustomer.itemsCount removeObjectAtIndex:[_cstData.defaultsCustomer.itemsCount indexOfObject:obj]];
            }
            else{
                showMessage(@"No Item Available", self.superview);
            }
            
        }
        
    }];
}
- (IBAction)clearCustomerClick:(id)sender {
    
    [ronakGlobal.selectedCustomersArray removeObject:self.cstData];
    [_delegate customerNameDeleted];
    
}
@end
