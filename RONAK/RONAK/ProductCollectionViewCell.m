//
//  ProductCollectionViewCell.m
//  RONAK
//
//  Created by Gaian on 8/13/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ProductCollectionViewCell.h"

@implementation ProductCollectionViewCell


-(void)awakeFromNib
{
    [super awakeFromNib];
}
-(void)bindData:(ItemMaster*)item{
    
    _item=item;
    _codeName.text=item.filters.color_Code__c;
    if([item.filters.stock__c intValue]>50)
    {
        _codeName.textColor=[UIColor blackColor];
    }
    else{
        _codeName.textColor=RGB(213,201,101);
    }
}

@end
