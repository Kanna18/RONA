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
        _warehouseFilter=[[NSMutableArray alloc]init];
        
        _lensDescription=[[NSMutableArray alloc]init];
        _shape=[[NSMutableArray alloc]init];
        _frameMaterial=[[NSMutableArray alloc]init];
        _templeMaterial=[[NSMutableArray alloc]init];
        _templeColor=[[NSMutableArray alloc]init];
        _tipsColor=[[NSMutableArray alloc]init];
        _size=[[NSMutableArray alloc]init];
        _FrontColor=[[NSMutableArray alloc]init];
        _LensColor=[[NSMutableArray alloc]init];
        _gender=[[NSMutableArray alloc]init];
        _lensMaterial=[[NSMutableArray alloc]init];
        
        _disCountMinMax=[[NSMutableDictionary alloc] init];
        _priceMinMax=[[NSMutableDictionary alloc] init];
        _stockMinMax=[[NSMutableDictionary alloc] init];
        _wsPriceMinMax=[[NSMutableDictionary alloc] init];
        
        [_stockMinMax setValue:@"1" forKey:@"Min"];
        [_priceMinMax setValue:@"1" forKey:@"Min"];
        [_wsPriceMinMax setValue:@"1" forKey:@"Min"];
        

    }
    return self;
}

-(void)getStockDetailsIdsbasedonBrandWarehouse
{
    NSPredicate *Brandpred=[NSPredicate predicateWithFormat:@"SELF.brand_s == %@",_brand];
    NSMutableArray *wareHousesPreArr=[[NSMutableArray alloc]init];
    [_warehouseFilter enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate* pre=[NSPredicate predicateWithFormat:@"SELF.warehouse_Name_s == %@",obj];
        [wareHousesPreArr addObject:pre];
    }];
    NSPredicate *whousePre=[NSCompoundPredicate orPredicateWithSubpredicates:wareHousesPreArr];
    
    NSPredicate *finalPre=[NSCompoundPredicate andPredicateWithSubpredicates:@[whousePre,Brandpred]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([StockDetails class]) inManagedObjectContext:ronakGlobal.context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:finalPre];
    NSError *error = nil;
    NSArray *fetchedObjects = [[ronakGlobal.context executeFetchRequest:fetchRequest error:&error] valueForKey:@"item_Code_s"];
    ronakGlobal.stockIDsArray=fetchedObjects;
    NSLog(@"%@",ronakGlobal.stockIDsArray);
}
-(NSPredicate*)getPredicateStringFromTable:(NSString*)str
{
    
    [self getStockDetailsIdsbasedonBrandWarehouse];
    
    NSMutableArray *preArrary=[[NSMutableArray alloc]init];
    NSMutableArray *cateGoryArray=[[NSMutableArray alloc]init];
    
    
    /*************************************Filters1********************************************/
    //Brands
    NSPredicate *Brandpred=[NSPredicate predicateWithFormat:@"SELF.filters.brand__c == %@",_brand];
    
    //Categories (Product__c)
    [_categories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.product__c == %@",obj];
        [cateGoryArray addObject:pre];
    }];
    
    //Collections
    [_collection enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.collection__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    /***************************************************************************************************/
    //Gender
    [_gender enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.category__c == %@",obj];
        [preArrary addObject:pre];
    }];


    //Descriptions
    [_lensDescription enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Description__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    //Shape
    [_shape enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.shape__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    //Stock Warehouse
    [_stockHouseFilter enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.stock_Warehouse__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    //Frame Material
    [_frameMaterial enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.frame_Material__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    //Temple Material
    [_templeMaterial enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Material__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    //Temple Color
    [_templeColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Color__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    //Tips Color
    [_tipsColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.tips_Color__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    [_lensMaterial enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Material__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    //Size
    [_size enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.size__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    //Front Color
    [_FrontColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.front_Color__c ==  %@",obj];
        [preArrary addObject:pre];
    }];
    
    //LensColor
    [_LensColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Color__c ==  %@",obj];

        [preArrary addObject:pre];
    }];
    
    NSPredicate *remPre=[NSCompoundPredicate orPredicateWithSubpredicates:preArrary];
    NSPredicate *catePre=[NSCompoundPredicate orPredicateWithSubpredicates:cateGoryArray];
    NSPredicate *finalPre;
    NSArray *precArr=@[remPre,catePre];
    for (NSPredicate *pre in precArr) {
        if(![pre.predicateFormat isEqualToString:@"FALSEPREDICATE"])
        {
            finalPre=[NSCompoundPredicate andPredicateWithSubpredicates:@[Brandpred,pre]];
        }
    }
    return finalPre!=nil?finalPre:Brandpred;
    
}
-(void)clearAllFilters{
    
    [_categories removeAllObjects];
    [_collection removeAllObjects];
    [_stockHouseFilter removeAllObjects];
    [_sampleHouseFilter removeAllObjects];
    [_warehouseFilter removeAllObjects];
    [_lensDescription removeAllObjects];
    [_shape removeAllObjects];
    [_frameMaterial removeAllObjects];
    [_templeMaterial  removeAllObjects];
    [_templeColor removeAllObjects];
    [_tipsColor removeAllObjects];
    [_size removeAllObjects];
    [_LensColor removeAllObjects];
    [_FrontColor removeAllObjects];
    [_gender removeAllObjects];
    [_lensMaterial removeAllObjects];
    
    [_disCountMinMax removeAllObjects];
    [_priceMinMax removeAllObjects];
    [_wsPriceMinMax removeAllObjects];
    [_stockMinMax removeAllObjects];
    _brand=@"";
    
    
}
@end
