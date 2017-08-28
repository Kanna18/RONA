//
//  SelectedFilters.m
//  RONAK
//
//  Created by Gaian on 8/26/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "SelectedFilters.h"

@implementation SelectedFilters

-(instancetype)init
{
    self=[super init];
    if(self)
    {
        _categories=[[NSMutableArray alloc]init];
        _collection=[[NSMutableArray alloc]init];
        _stockHouseFilter=[[NSMutableArray alloc]init];
        _sampleHouseFilter=[[NSMutableArray alloc]init];
        _lensDescription=[[NSMutableArray alloc]init];
        _shape=[[NSMutableArray alloc]init];
        _frameMaterial=[[NSMutableArray alloc]init];
        _templeMaterial=[[NSMutableArray alloc]init];
        _templeColor=[[NSMutableArray alloc]init];
        _tipsColor=[[NSMutableArray alloc]init];
        _size=[[NSMutableArray alloc]init];
        _FrontColor=[[NSMutableArray alloc]init];
        _LensColor=[[NSMutableArray alloc]init];
        
        
    }
    return self;
}
-(NSPredicate*)getPredicateStringFromTable:(NSString*)str
{
    ItemMaster *item;
    NSMutableArray *preArrary=[[NSMutableArray alloc]init];
    
    NSPredicate *Brandpred=[NSPredicate predicateWithFormat:@"SELF.filters.brand__c == %@",_brand];
    
    [_categories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.category__c == %@",obj];
        [preArrary addObject:pre];
    }];
    [_collection enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.collection__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    [_lensDescription enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Description__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    [_shape enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.shape__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    [_frameMaterial enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.frame_Material__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    [_templeMaterial enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Material__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    [_templeColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Color__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    [_tipsColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.tips_Color__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    [_size enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.size__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    [_FrontColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.front_Color__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    [_LensColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Color__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    NSPredicate *placesPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:preArrary];
    
    NSPredicate *finalPre=[NSCompoundPredicate andPredicateWithSubpredicates:@[Brandpred,placesPredicate]];

    
    return preArrary.count>0?finalPre:Brandpred;
}
-(void)clearAllFilters{
    
    [_categories removeAllObjects];
    [_collection removeAllObjects];
    [_stockHouseFilter removeAllObjects];
    [_sampleHouseFilter removeAllObjects];
    [_lensDescription removeAllObjects];
    [_shape removeAllObjects];
    [_frameMaterial removeAllObjects];
    [_templeMaterial  removeAllObjects];
    [_templeColor removeAllObjects];
    [_tipsColor removeAllObjects];
    [_size removeAllObjects];
    [_LensColor removeAllObjects];
    [_FrontColor removeAllObjects];
    
    
}
@end
