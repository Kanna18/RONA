//
//  SortProductsPage.m
//  RONAK
//
//  Created by Gaian on 9/11/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CategoryBased.h"

@implementation ColorBased

-(instancetype)initWithArray:(NSArray*)arr
{
    self=[super init];
    if(self)
    {
        _listItemsArray =[[NSMutableArray alloc]init];
         NSArray *color=[[NSSet setWithArray:[arr valueForKeyPath:@"filters.color_Code__c"]] allObjects];
        [color enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSPredicate *modelPre=[NSPredicate predicateWithFormat:@"SELF.filters.color_Code__c == %@",obj];
            NSArray *modelArr=[arr filteredArrayUsingPredicate:modelPre];
            [modelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ItemMaster *item=obj;
                [_listItemsArray addObject:item];                        
            }];
            
        }];
    }
    return self;
}
@end

@implementation ModelBased

-(instancetype)initWithArray:(NSArray*)arr
{
    self=[super init];
    if(self)
    {
        _ColorsArray =[[NSMutableArray alloc]init];
        NSArray *model=[[NSSet setWithArray:[arr valueForKeyPath:@"filters.style_Code__c"]] allObjects];
        
        [model enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *modelPre=[NSPredicate predicateWithFormat:@"SELF.filters.style_Code__c == %@",obj];
            NSArray *modelArr=[arr filteredArrayUsingPredicate:modelPre];
            ColorBased *colorB=[[ColorBased alloc]initWithArray:modelArr];
            colorB.model=obj;
            [_ColorsArray addObject:colorB];
        }];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"model" ascending:NO];
        NSArray *arr=[_ColorsArray sortedArrayUsingDescriptors:@[sortDescriptor]];
        _ColorsArray=[[NSMutableArray alloc]initWithArray:arr];
    }
    return self;
}
@end


@implementation CategoryBased
-(instancetype)initWithArray:(NSArray*)arr
{
    self=[super init];
    if(self)
    {
        _ModelsArray=[[NSMutableArray alloc]init];
        NSArray *cat = [[NSSet setWithArray:[arr valueForKeyPath:@"filters.product__c"]] allObjects];
        [cat enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSPredicate *catPre=[NSPredicate predicateWithFormat:@"SELF.filters.product__c == %@",obj];
            NSArray *catArr=[arr filteredArrayUsingPredicate:catPre];
            ModelBased *model=[[ModelBased alloc]initWithArray:catArr];
            model.category=obj;
            [_ModelsArray addObject:model];
        }];
        
    }
    return self;
}
-(NSMutableArray*)returnSortedItems
{
    return _ModelsArray;
}
@end

