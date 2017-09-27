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
    [self drawBorders:_customerNameBtn];
    [self drawBorders:_increment];
    [self drawBorders:_decrement];
    [self drawBorders:_backview];
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
    
    UIView *cst=element;
    float shadowSize = 1.0f;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(cst.frame.origin.x - shadowSize / 2,
                                                                           cst.frame.origin.y - shadowSize / 2,
                                                                           cst.frame.size.width + shadowSize,
                                                                           cst.frame.size.height + shadowSize)];
    ////        cst.layer.borderColor=[UIColor lightGrayColor].CGColor;
    ////        cst.layer.borderWidth=1.0f;
    //        cst.layer.shadowColor=[UIColor lightGrayColor].CGColor;
    //        cst.layer.shadowOffset=CGSizeMake(2.0, 2.0);
    //        cst.layer.shadowRadius=2.0f;
    //        cst.layer.shadowOpacity=1.0f;
    cst.layer.masksToBounds = NO;
    cst.layer.shadowColor = [UIColor blackColor].CGColor;
    cst.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    cst.layer.shadowOpacity = 0.4f;
    //    cst.layer.shadowPath = shadowPath.CGPath;
    

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
