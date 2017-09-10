//
//  DownloadProducts.m
//  RONAK
//
//  Created by Gaian on 8/22/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "DownloadProducts.h"

@implementation DownloadProducts{
    
    ServerAPIManager *serverAPI;
    NSURLSessionDataTask *sessionDatatask;
}

-(instancetype)init
{
    self=[super init];
    if(self)
    {
        serverAPI=[ServerAPIManager sharedinstance];
    }
    return self;
    
}
-(void)downloadStockWareHouseSavetoCoreData
{
    NSLog(@"--->%@",[NSPersistentContainer defaultDirectoryURL]);
    NSDictionary *headers = @{@"content-type": @"application/json",
                               @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
//    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)};
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_ProductList_B]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
//    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if(data!=nil)
        {
            [self performSelectorOnMainThread:@selector(fetchData:) withObject:data waitUntilDone:YES];
        }
        
    }];
    [dataTask resume];
}
-(void)fetchData:(NSData*)data
{
    {
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *code=obj[@"product"][@"Id"];
            NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:@"Filters"];
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"codeId == %@",code];
            [fetch setPredicate:predicate];
            NSArray *arr=[ronakGlobal.context executeFetchRequest:fetch error:nil];
            if(!(arr.count>0))
            {
                NSDictionary *dic=obj;
                
                NSEntityDescription *entitydesc=[NSEntityDescription entityForName:NSStringFromClass([ItemMaster class]) inManagedObjectContext:ronakGlobal.context];
//                ItemMaster *item=[[ItemMaster alloc]initWithContext:ronakGlobal.context];
                ItemMaster *item=[[ItemMaster alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:ronakGlobal.context];
                item.imageUrl=dic[@"imageURL"];
                item.imageName=dic[@"imageName"];
                
                NSDictionary *filtersDict=dic[@"product"];
        NSEntityDescription *entityFilter=[NSEntityDescription entityForName:NSStringFromClass([Filters class]) inManagedObjectContext:ronakGlobal.context];
//                Filters *filter=[[Filters alloc]initWithContext:ronakGlobal.context];
                Filters *filter=[[Filters alloc]initWithEntity:entityFilter insertIntoManagedObjectContext:ronakGlobal.context];
                filter.order_Month__c=filtersDict[@"Order_Month__c"];
                filter.stock__c=[NSString stringWithFormat:@"%@",filtersDict[@"Stock__c"]];
                filter.mRP__c=[NSString stringWithFormat:@"%@",filtersDict[@"MRP__c"]];
                filter.collection_Name__c=filtersDict[@"Collection_Name__c"];
                filter.tips_Color__c=filtersDict[@"Tips_Color__c"];
                filter.temple_Material__c=filtersDict[@"Temple_Material__c"];
                filter.temple_Color__c=filtersDict[@"Temple_Color__c"];
                filter.style_Code__c=filtersDict[@"Style_Code__c"];
                filter.size__c=filtersDict[@"Size__c"];
                filter.shape__c=filtersDict[@"Shape__c"];
                filter.product__c=filtersDict[@"Product__c"];
                filter.wS_Price__c=[NSString stringWithFormat:@"%@",filtersDict[@"WS_Price__c"]];
                filter.number__c=[NSString stringWithFormat:@"%@",filtersDict[@"Number__c"]];
                filter.logo_Type__c=filtersDict[@"Logo_Type__c"];
                filter.logo_Size__c=filtersDict[@"Logo_Size__c"];
                filter.logo_Color__c=filtersDict[@"Logo_Color__c"];
                filter.lens_Description__c=filtersDict[@"Lens_Description__c"];
                filter.lens_Color__c=filtersDict[@"Lens_Color__c"];
                filter.lens_Code__c=filtersDict[@"Lens_Code__c"];
                filter.item_No__c=filtersDict[@"Item_No__c"];
                filter.item_Group_Product_Family__c=filtersDict[@"Item_Group_Product_Family__c"];
                filter.item_Description__c=filtersDict[@"Item_Description__c"];
                filter.inactive_To__c=filtersDict[@"Inactive_To__c"];
                filter.inactive_From__c=filtersDict[@"Inactive_From__c"];
                filter.inactive__c=filtersDict[@"Inactive__c"];
                filter.group_Name__c=filtersDict[@"Group_Name__c"];
                filter.front_Color__c=filtersDict[@"Front_Color__c"];
                filter.frame_Structure__c=filtersDict[@"Frame_Structure__c"];
                filter.frame_Material__c=filtersDict[@"Frame_Material__c"];
                filter.foreign_Name__c=filtersDict[@"Foreign_Name__c"];
                filter.flex_Temple__c=filtersDict[@"Flex_Temple__c"];
                filter.factory_Company__c=filtersDict[@"Factory_Company__c"];
                filter.drawing_Code__c=filtersDict[@"Drawing_Code__c"];
                filter.delivery_Month__c=filtersDict[@"Delivery_Month__c"];
                filter.custom__c=filtersDict[@"Custom__c"];
                filter.color_Code__c=filtersDict[@"Color_Code__c"];
                filter.collection__c=filtersDict[@"Collection__c"];
                filter.category__c=filtersDict[@"Category__c"];
                filter.brand__c=filtersDict[@"Brand__c"];
                filter.active_To__c=filtersDict[@"Active_To__c"];
                filter.active_From__c=filtersDict[@"Active_From__c"];
                filter.stock_Warehouse__c=filtersDict[@"Stock_Warehouse__c"];
                filter.rim__c=filtersDict[@"Rim__c"];
                filter.lens_Material__c=filtersDict[@"Lens_Material__c"];
                filter.discount__c=[NSString stringWithFormat:@"%@",filtersDict[@"Discount__c"]];
                filter.codeId=filtersDict[@"Id"];
                filter.picture_Name__c=filtersDict[@"Picture_Name__c"];
        
                        
                NSDictionary *attDict=filtersDict[@"attributes"];
                
                NSEntityDescription *entityAtt=[NSEntityDescription entityForName:NSStringFromClass([Att class]) inManagedObjectContext:ronakGlobal.context];
                Att *attributes=[[Att alloc]initWithEntity:entityAtt insertIntoManagedObjectContext:ronakGlobal.context];
//                Att *attributes=[[Att alloc]initWithContext:ronakGlobal.context];
                attributes.type=attDict[@"type"];
                attributes.url=attDict[@"url"];
                
                item.filters=filter;
                item.filters.attribute=attributes;
                NSLog(@"%lu",(unsigned long)idx);
                [ronakGlobal.delegate saveContext];
            }            
        }];
        [_delegateProducts productsListFetched];
    }
}
-(void)getFilterFor:(NSString*)strFor withContext:(NSManagedObjectContext*)cntxt{
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Filters" inManagedObjectContext:cntxt];
    [fetchRequest setEntity:entity1];
    NSPredicate *predicate1=[NSPredicate predicateWithFormat:@"%@ like %@",strFor,strFor];
    [fetchRequest setPredicate:predicate1];
    NSError *error = nil;
    NSArray *allFilters = [cntxt executeFetchRequest:fetchRequest error:&error];
    
    ////////////////////////////////////////////////////////////////////////
    NSMutableArray *brandsF=[[NSMutableArray alloc]init];
    NSMutableArray *categoriesF=[[NSMutableArray alloc]init];
    NSMutableArray *collectionF=[[NSMutableArray alloc]init];
    
    NSMutableArray *sampleWarehouseF=[[NSMutableArray alloc]init];
    NSMutableArray *stockWarehouseF=[[NSMutableArray alloc]init];
    NSMutableArray *stockF=[[NSMutableArray alloc]init];
    
    NSMutableArray *lensDesF=[[NSMutableArray alloc]init];
    NSMutableArray *wsPrice=[[NSMutableArray alloc]init];
    NSMutableArray *shapeF=[[NSMutableArray alloc]init];
    NSMutableArray *genderF=[[NSMutableArray alloc]init];
    NSMutableArray *frameMateF=[[NSMutableArray alloc]init];
    NSMutableArray *templeMateF=[[NSMutableArray alloc]init];
    NSMutableArray *templeColF=[[NSMutableArray alloc]init];
    NSMutableArray *tipColourF=[[NSMutableArray alloc]init];
    
    NSMutableArray *discountF=[[NSMutableArray alloc]init];
    NSMutableArray *mrpF=[[NSMutableArray alloc]init];
    NSMutableArray *rimF=[[NSMutableArray alloc]init];
    NSMutableArray *sizeF=[[NSMutableArray alloc]init];
    NSMutableArray *lensMAteF=[[NSMutableArray alloc]init];
    NSMutableArray *frontColF=[[NSMutableArray alloc]init];
    NSMutableArray *lensColF=[[NSMutableArray alloc]init];
    
    
    [allFilters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
        Filters *fil=obj;
         !([brandsF containsObject:fil.brand__c])&&!(fil.brand__c==NULL)?[brandsF addObject:fil.brand__c]:@"";
         !([categoriesF containsObject:fil.product__c])&&!(fil.product__c==NULL)?[categoriesF addObject:fil.product__c]:@"";
         !([collectionF containsObject:fil.collection__c])&&!(fil.collection__c==NULL)?[collectionF addObject:fil.collection__c]:@"";
         
!([stockWarehouseF containsObject:fil.stock_Warehouse__c])&&!(fil.stock_Warehouse__c==NULL)?[stockWarehouseF addObject:fil.stock_Warehouse__c]:@"";
    !([stockF containsObject:fil.stock__c])&&!(fil.stock__c==NULL)?[stockF addObject:fil.stock__c]:@"";
     
         
         !([lensDesF containsObject:fil.lens_Description__c])&&!(fil.lens_Description__c==NULL)?[lensDesF addObject:fil.lens_Description__c]:@"";
         !([wsPrice containsObject:fil.wS_Price__c])&&!(fil.wS_Price__c==NULL)?[wsPrice addObject:fil.wS_Price__c]:@"";
         !([shapeF containsObject:fil.shape__c])&&!(fil.shape__c==NULL)?[shapeF addObject:fil.shape__c]:@"";
         !([genderF containsObject:fil.category__c])&&!(fil.category__c==NULL)?[genderF addObject:fil.category__c]:@"";
         !([frameMateF containsObject:fil.frame_Material__c])&&!(fil.frame_Material__c==NULL)?[frameMateF addObject:fil.frame_Material__c]:@"";
         !([templeMateF containsObject:fil.temple_Material__c])&&!(fil.temple_Material__c==NULL)?[templeMateF addObject:fil.temple_Material__c]:@"";
         !([templeColF containsObject:fil.temple_Color__c])&&!(fil.temple_Color__c==NULL)?[templeColF addObject:fil.temple_Color__c]:@"";
         !([tipColourF containsObject:fil.tips_Color__c])&&!(fil.tips_Color__c==NULL)?[tipColourF addObject:fil.tips_Color__c]:@"";
         
         !([discountF containsObject:fil.discount__c])&&!(fil.discount__c==NULL)?[discountF addObject:fil.discount__c]:@"";
         !([mrpF containsObject:fil.mRP__c])&&!(fil.mRP__c==NULL)?[mrpF addObject:fil.mRP__c]:@"";
         !([rimF containsObject:fil.frame_Structure__c])&&!(fil.frame_Structure__c==NULL)?[rimF addObject:fil.frame_Structure__c]:@"";
         !([sizeF containsObject:fil.size__c])&&!(fil.size__c==NULL)?[sizeF addObject:fil.size__c]:@"";
         !([lensMAteF containsObject:fil.lens_Material__c])&&!(fil.lens_Material__c==NULL)?[lensMAteF addObject:fil.lens_Material__c]:@"";
         !([frontColF containsObject:fil.front_Color__c])&&!(fil.front_Color__c==NULL)?[frontColF addObject:fil.front_Color__c]:@"";
         !([lensColF containsObject:fil.lens_Color__c])&&!(fil.lens_Color__c==NULL)?[lensColF addObject:fil.lens_Color__c]:@"";
         
    }];
    
    ronakGlobal.discArr=discountF;
    ronakGlobal.wsPriceArr=wsPrice;
    ronakGlobal.priceArr=mrpF;
    ronakGlobal.stockArr=stockF;
    
    ronakGlobal.DefFiltersOne=   @[@{ @"heading":kBrand,
                                      @"options":brandsF},
                                   @{ @"heading":kCategories,
                                      @"options":categoriesF},
                                   @{ @"heading":kCollection,
                                      @"options":collectionF}];
    ronakGlobal.DefFiltersTwo=   @[@{ @"heading":kStockWareHouse,
                                      @"options":stockWarehouseF},
//                                   @{ @"heading":kStockWareHouse,
//                                      @"options":stockWarehouseF},
                                   @{ @"heading":kStockvalue,
                                      @"options":@[@"nil"]}];
    ronakGlobal.advancedFilters1=@[@{ @"heading":kLensDescription,
                                      @"options":lensDesF},
                                   @{ @"heading":kWSPrice,
                                      @"options":@[@"nil"]},
                                   @{ @"heading":kShape,
                                      @"options":shapeF},
                                   @{ @"heading":kGender,
                                      @"options":genderF},
                                   @{ @"heading":kFrameMaterial,
                                      @"options":frameMateF},
                                   @{ @"heading":kTempleMaterial,
                                      @"options":templeMateF},
                                   @{ @"heading":kTempleColour,
                                      @"options":templeColF},
                                   @{ @"heading":kTipColor,
                                      @"options":tipColourF},
                                   ];
    ronakGlobal.advancedFilters2=@[
                                   @{ @"heading":kDiscount,
                                      @"options":@[@"nil"]},
                                   @{ @"heading":kMRP,
                                      @"options":@[@"nil"]},
                                   @{ @"heading":kRim,
                                      @"options":[rimF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
                                   @{ @"heading":kSize,
                                      @"options":sizeF},
                                   @{ @"heading":kLensMaterial,
                                      @"options":lensMAteF},
                                   @{ @"heading":kFrontColor,
                                      @"options":frontColF},
                                   @{ @"heading":kLensColor,
                                      @"options":lensColF},
                                   @{ @"heading":@"Poster Model",
                                      @"options":@[@"Yes",@"No"]}];
    
    NSLog(@"coredata managed objects count--%lu",(unsigned long)[[cntxt registeredObjects] count]);
    
}


-(NSMutableArray*)pickProductsFromFilters{
    
    NSPredicate *pre=[ronakGlobal.selectedFilter getPredicateStringFromTable:nil];
    
    NSMutableArray *items=[[NSMutableArray alloc]init];
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ItemMaster class])];
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.filters.brand__c == 'Idee'"];
//    NSPredicate *pred2=[NSPredicate predicateWithFormat:@"SELF.filters.category__c == 'Kids'"];
//    NSPredicate *placesPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[pred2, predicate]];
    [fetch setPredicate:pre];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"filters.item_No__c"                                                                   ascending:YES];
    [fetch setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSArray *arr=[ronakGlobal.context executeFetchRequest:fetch error:nil];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ItemMaster *item=obj;
        [items addObject:item];
    }];
    return items;
}

@end
