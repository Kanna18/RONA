//
//  SelectedFilters.m
//  RONAK
//
//  Created by Gaian on 8/26/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "SelectedFilters.h"

@implementation SelectedFilters{
    
    AppDelegate *delegate;
    NSManagedObjectContext *filterContext;
}

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
        
        _rim=[[NSMutableArray alloc]init];
        _posterModel=[[NSMutableArray alloc]init];
        
        _disCountMinMax=[[NSMutableDictionary alloc] init];
        _priceMinMax=[[NSMutableDictionary alloc] init];
        _stockMinMax=[[NSMutableDictionary alloc] init];
        _wsPriceMinMax=[[NSMutableDictionary alloc] init];
        
        [_stockMinMax setValue:@"0" forKey:@"Min"];
        [_priceMinMax setValue:@"1" forKey:@"Min"];
        [_wsPriceMinMax setValue:@"1" forKey:@"Min"];
        
        delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        filterContext=delegate.managedObjectContext;
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
    
    float minV=[ronakGlobal.selectedFilter.stockMinMax[@"Min"] length]>0?[ronakGlobal.selectedFilter.stockMinMax[@"Min"] floatValue]:0;
    float maxV= [ronakGlobal.selectedFilter.stockMinMax[@"Max"] length]>0?  [ronakGlobal.selectedFilter.stockMinMax[@"Max"] floatValue]:100000;
    NSPredicate *stockQtyPred=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(SELF.stock__s.floatValue >=%f) AND (SELF.stock__s.floatValue <=%f)",minV,maxV]];
    
    NSPredicate *finalPre=[NSCompoundPredicate andPredicateWithSubpredicates:@[whousePre,Brandpred,stockQtyPred]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([StockDetails class]) inManagedObjectContext:filterContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:finalPre];
    NSError *error = nil;
    NSArray *fetchedObjects = [[filterContext executeFetchRequest:fetchRequest error:&error] valueForKey:@"item_Code_s"];
    
    ronakGlobal.stockIDsArray=fetchedObjects;
//    NSLog(@"%@",ronakGlobal.stockIDsArray);
}
-(NSPredicate*)getPredicateStringFromTable:(NSString*)str
{
    
    [self getStockDetailsIdsbasedonBrandWarehouse];
    

    NSMutableArray *cateGoryArray=[[NSMutableArray alloc]init];
    NSMutableArray *collectionArray=[[NSMutableArray alloc]init];
    NSMutableArray *lensDescArray=[[NSMutableArray alloc]init];
    NSMutableArray *shapeArray=[[NSMutableArray alloc]init];
    NSMutableArray *genderArray=[[NSMutableArray alloc]init];
    NSMutableArray *frameMateArray=[[NSMutableArray alloc]init];
    NSMutableArray *templeMateArray=[[NSMutableArray alloc]init];
    NSMutableArray *templeColorArray=[[NSMutableArray alloc]init];
    NSMutableArray *tipColorArray=[[NSMutableArray alloc]init];
    NSMutableArray *rimArray=[[NSMutableArray alloc]init];
    NSMutableArray *sizeArray=[[NSMutableArray alloc]init];
    NSMutableArray *lensMaterialArray=[[NSMutableArray alloc]init];
    NSMutableArray *frontColorArray=[[NSMutableArray alloc]init];
    NSMutableArray *lensColorArray=[[NSMutableArray alloc]init];
    NSMutableArray *p=[[NSMutableArray alloc]init];
    
    
    
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
        [collectionArray addObject:pre];
    }];
    
    /***************************************************************************************************/
    //Descriptions
    [_lensDescription enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Description__c ==  %@",obj];
        [lensDescArray addObject:pre];
    }];
    
    //Shape
    [_shape enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.shape__c ==  %@",obj];
        [shapeArray addObject:pre];
    }];
    
    //Gender
    [_gender enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.category__c == %@",obj];
        [genderArray addObject:pre];
    }];
    
//    //Stock Warehouse
//    [_stockHouseFilter enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.stock_Warehouse__c ==  %@",obj];
////        [preArrary addObject:pre];
//    }];
    
    //Frame Material
    [_frameMaterial enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.frame_Material__c ==  %@",obj];
        [frameMateArray addObject:pre];
    }];
    //Temple Material
    [_templeMaterial enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Material__c ==  %@",obj];
        [templeMateArray addObject:pre];
    }];
    
    //Temple Color
    [_templeColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Color__c ==  %@",obj];
        [templeColorArray addObject:pre];
    }];
    
    //Tips Color
    [_tipsColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.tips_Color__c ==  %@",obj];
        [tipColorArray addObject:pre];
    }];
    
    //rim
    [_rim enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.frame_Structure__c ==  %@",obj];
        [rimArray addObject:pre];
    }];

    
    //Size
    [_size enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.size__c ==  %@",obj];
        [sizeArray addObject:pre];
    }];
    
    //lens Material
    [_lensMaterial enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Material__c ==  %@",obj];
        [lensMaterialArray addObject:pre];
    }];
    
    
    
    //Front Color
    [_FrontColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.front_Color__c ==  %@",obj];
        [frontColorArray addObject:pre];
    }];
    
    //LensColor
    [_LensColor enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Color__c ==  %@",obj];

        [lensColorArray addObject:pre];
    }];
    

    
    float mrpMin =[ronakGlobal.selectedFilter.priceMinMax[@"Min"] floatValue];
    float mrpMax =[ronakGlobal.selectedFilter.priceMinMax[@"Max"] floatValue];
    NSPredicate *mrpPredicate =
    [NSPredicate predicateWithFormat:@"(SELF.filters.mRP__c.floatValue >= %f) AND (SELF.filters.mRP__c.floatValue <= %f)",mrpMin>0?mrpMin:0,mrpMax>0?mrpMax:100000];
    
    float wsMin =[ronakGlobal.selectedFilter.wsPriceMinMax[@"Min"] floatValue];
    float wsMax =[ronakGlobal.selectedFilter.wsPriceMinMax[@"Max"] floatValue];
    NSPredicate *wsPricePredicate =[NSPredicate predicateWithFormat:@"(SELF.filters.wS_Price__c.floatValue >= %f) AND (SELF.filters.wS_Price__c.floatValue <= %f)",wsMin>0?wsMin:0, wsMax>0?wsMax:100000];
    
    float discMin =[ronakGlobal.selectedFilter.disCountMinMax[@"Min"] floatValue];
    float discMax =[ronakGlobal.selectedFilter.disCountMinMax[@"Max"] floatValue];
    NSPredicate *discountPricePredicate =[NSPredicate predicateWithFormat:@"(SELF.filters.discount__c.floatValue >= %f) AND (SELF.filters.discount__c.floatValue <= %f)",discMin>0?discMin:0, discMax>0?discMax:100];
    
    NSPredicate *catePre=[NSCompoundPredicate orPredicateWithSubpredicates:cateGoryArray];
    NSPredicate *collePre=[NSCompoundPredicate orPredicateWithSubpredicates:collectionArray];
    NSPredicate *lensPre=[NSCompoundPredicate orPredicateWithSubpredicates:lensDescArray];
    NSPredicate *shapePre=[NSCompoundPredicate orPredicateWithSubpredicates:shapeArray];
    NSPredicate *genderPre=[NSCompoundPredicate orPredicateWithSubpredicates:genderArray];
    NSPredicate *frameMatePre=[NSCompoundPredicate orPredicateWithSubpredicates:frameMateArray];
    NSPredicate *templeMatePre=[NSCompoundPredicate orPredicateWithSubpredicates:templeMateArray];
    NSPredicate *templeColorPre=[NSCompoundPredicate orPredicateWithSubpredicates:templeColorArray];
    NSPredicate *tipColorPre=[NSCompoundPredicate orPredicateWithSubpredicates:tipColorArray];
    NSPredicate *rimPre=[NSCompoundPredicate orPredicateWithSubpredicates:rimArray];
    NSPredicate *sizePre=[NSCompoundPredicate orPredicateWithSubpredicates:sizeArray];
    NSPredicate *lensMaterialPre=[NSCompoundPredicate orPredicateWithSubpredicates:lensMaterialArray];
    NSPredicate *frontColorPre=[NSCompoundPredicate orPredicateWithSubpredicates:frontColorArray];
    NSPredicate *lensColorPre=[NSCompoundPredicate orPredicateWithSubpredicates:lensColorArray];
    
    
    NSMutableArray *allpredicates=[[NSMutableArray alloc]initWithObjects:Brandpred,catePre,collePre,lensPre,shapePre,genderPre,frameMatePre,templeMatePre,templeColorPre,tipColorPre,rimPre,sizePre,lensMaterialPre,frontColorPre,lensColorPre,wsPricePredicate,mrpPredicate,discountPricePredicate, nil];
    
    [allpredicates enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *p=obj;
        if([p.predicateFormat isEqualToString:@"FALSEPREDICATE"]){
            [allpredicates removeObject:p];
        }
    }];
    NSPredicate *finalPre;
    finalPre=[NSCompoundPredicate andPredicateWithSubpredicates:allpredicates];
    
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
    
    [_rim removeAllObjects];
    [_posterModel removeAllObjects];
    _brand=@"";
}
@end
