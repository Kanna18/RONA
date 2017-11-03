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
    NSMutableArray *custDataOffsetArray, *productsOffsetArray,*stockDetailsOffsetArray;
    RESTCalls *rest;
}
int offSet=0, productsOffset=0,stockOffset=0;

-(instancetype)init
{
    self=[super init];
    if(self)
    {
        serverAPI=[ServerAPIManager sharedinstance];
        rest=[[RESTCalls alloc]init];
        custDataOffsetArray=[[NSMutableArray alloc]init];
        productsOffsetArray=[[NSMutableArray alloc]init];
        stockDetailsOffsetArray=[[NSMutableArray alloc]init];
        
        
    }
    return self;
}

#pragma  mark Product Master Integration
-(void)downloadStockWareHouseSavetoCoreData
{
    NSLog(@"--->%@",[NSPersistentContainer defaultDirectoryURL]);
    NSDictionary *headers = @{@"content-type": @"application/json",
                               @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail),
                                  @"offSet":[NSNumber numberWithInteger:productsOffset]
                                  };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_ProductList_B]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if(data){            
            NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if(arr.count>1){
                NSArray *slNoc=[arr valueForKeyPath:@"Sl_No__c"];
                productsOffset=[slNoc[slNoc.count-1] intValue];
                [productsOffsetArray addObjectsFromArray:arr];
                [self downloadStockWareHouseSavetoCoreData];
                return ;
            }
            else{
                [self fetchData:productsOffsetArray];
                return ;
            }
        }
    }];
    [dataTask resume];
}
-(void)fetchData:(NSMutableArray*)arr
{
    NSArray *idsA=[arr valueForKeyPath:@"Id"];
    NSMutableArray *ids=[[NSMutableArray alloc]initWithArray:idsA];
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:@"Filters"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"codeId == codeId"];
    [fetch setPredicate:predicate];
    NSArray *coreIds=[[ronakGlobal.context executeFetchRequest:fetch error:nil] valueForKey:@"codeId"];
    [ids removeObjectsInArray:coreIds];
    __block NSInteger objectsCount=coreIds.count;
    for (NSString *uniQid in ids)
    {
        NSPredicate *pred=[NSPredicate predicateWithFormat:@"Id == %@",uniQid];
        NSArray *sortedArr=[arr filteredArrayUsingPredicate:pred];
        NSArray *duplicateArr=[NSArray arrayWithObjects:sortedArr.lastObject, nil];
        sortedArr=nil;
        [duplicateArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //            NSString *code=obj[@"product"][@"Id"]; /*old*/
            NSString *code=obj[@"Id"];
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
                
                //                NSDictionary *filtersDict=dic[@"product"];/*Old*/
                NSDictionary *filtersDict=dic;
                NSEntityDescription *entityFilter=[NSEntityDescription entityForName:NSStringFromClass([Filters class]) inManagedObjectContext:ronakGlobal.context];
                //                Filters *filter=[[Filters alloc]initWithContext:ronakGlobal.context];
                Filters *filter=[[Filters alloc]initWithEntity:entityFilter insertIntoManagedObjectContext:ronakGlobal.context];
                filter.order_Month__c=filtersDict[@"Order_Month__c"];
                filter.stock__c=[NSString stringWithFormat:@"%@",filtersDict[@"Stock__c"]];
                filter.mRP__c=[filtersDict[@"MRP__c"] floatValue];
                filter.collection_Name__c=filtersDict[@"Collection_Name__c"];
                filter.tips_Color__c=filtersDict[@"Tips_Color__c"];
                filter.temple_Material__c=filtersDict[@"Temple_Material__c"];
                filter.temple_Color__c=filtersDict[@"Temple_Color__c"];
                filter.style_Code__c=filtersDict[@"Style_Code__c"];
                filter.size__c=filtersDict[@"Size__c"];
                filter.shape__c=filtersDict[@"Shape__c"];
                filter.product__c=filtersDict[@"Product__c"];
                filter.wS_Price__c=[filtersDict[@"WS_Price__c"] floatValue];
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
                filter.discount__c=[filtersDict[@"Discount__c"] floatValue];
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
                [ronakGlobal.delegate saveContext];
                objectsCount++;
                [ronakGlobal.context reset];
                NSLog(@"%lu--%lu",(long)objectsCount,(unsigned long)ronakGlobal.context.registeredObjects.count);
            }
        }];
    }
    
        [self downLoadStockDetails];
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
//         !([wsPrice containsObject:fil.wS_Price__c])&&!(fil.wS_Price__c==NULL)?[wsPrice addObject:fil.wS_Price__c]:@"";
         !([shapeF containsObject:fil.shape__c])&&!(fil.shape__c==NULL)?[shapeF addObject:fil.shape__c]:@"";
         !([genderF containsObject:fil.category__c])&&!(fil.category__c==NULL)?[genderF addObject:fil.category__c]:@"";
         !([frameMateF containsObject:fil.frame_Material__c])&&!(fil.frame_Material__c==NULL)?[frameMateF addObject:fil.frame_Material__c]:@"";
         !([templeMateF containsObject:fil.temple_Material__c])&&!(fil.temple_Material__c==NULL)?[templeMateF addObject:fil.temple_Material__c]:@"";
         !([templeColF containsObject:fil.temple_Color__c])&&!(fil.temple_Color__c==NULL)?[templeColF addObject:fil.temple_Color__c]:@"";
         !([tipColourF containsObject:fil.tips_Color__c])&&!(fil.tips_Color__c==NULL)?[tipColourF addObject:fil.tips_Color__c]:@"";
         
//         !([discountF containsObject:fil.discount__c])&&!(fil.discount__c==NULL)?[discountF addObject:fil.discount__c]:@"";
//         !([mrpF containsObject:fil.mRP__c])&&!(fil.mRP__c==NULL)?[mrpF addObject:fil.mRP__c]:@"";
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
    
    NSLog(@"%@",brandsF);
    ronakGlobal.DefFiltersOne=   @[@{ @"heading":kBrand,
                                      @"options":[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(brandsArrayList)]},
                                   @{ @"heading":kCategories,
                                      @"options":categoriesF},
                                   @{ @"heading":kCollection,
                                      @"options":[collectionF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]}];
    ronakGlobal.DefFiltersTwo=   @[@{ @"heading":kStockWareHouse,
                                      @"options":[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(warehouseArrayList)]},
//                                   @{ @"heading":kStockWareHouse,
//                                      @"options":stockWarehouseF},
                                   @{ @"heading":kStockvalue,
                                      @"options":@[@"nil"]}];
    ronakGlobal.advancedFilters1=@[@{ @"heading":kLensDescription,
                                      @"options":[lensDesF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
                                   @{ @"heading":kWSPrice,
                                      @"options":@[@"nil"]},
                                   @{ @"heading":kShape,
                                      @"options":shapeF},
                                   @{ @"heading":kGender,
                                      @"options":genderF},
                                   @{ @"heading":kFrameMaterial,
                                      @"options":[frameMateF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
                                   @{ @"heading":kTempleMaterial,
                                      @"options":[templeMateF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
                                   @{ @"heading":kTempleColour,
                                      @"options":[templeColF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
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
                                      @"options":[sizeF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
                                   @{ @"heading":kLensMaterial,
                                      @"options":[lensMAteF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
                                   @{ @"heading":kFrontColor,
                                      @"options":[frontColF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
                                   @{ @"heading":kLensColor,
                                      @"options":[lensColF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
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
    NSLog(@"%@",arr);
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ItemMaster *item=obj;
        if([ronakGlobal.stockIDsArray containsObject:item.filters.item_No__c]){
        [items addObject:item];
        }
    }];
    return items;
}

#pragma mark  -Customer Master Integration-

-(void)downloadCustomersListInBackground
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [self restServiceForCustomerList];
    });

}


-(void)restServiceForCustomerList
{
    
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail),
                                  @"offSet":[NSNumber numberWithInteger:offSet]
                                  };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_customersList_B]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSArray *arr;
                                          if(data){
                                              arr=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
                                          if(arr.count>0)
                                          {
                                              NSArray *slNoc=[arr valueForKeyPath:@"Sl_No__c"];
                                              offSet=[slNoc[slNoc.count-1] intValue];
                                              [custDataOffsetArray addObjectsFromArray:arr];
                                              [self restServiceForCustomerList];
                                          }
                                          else{
                                              NSError *cerr;
                                              NSData *jsonData=[NSJSONSerialization dataWithJSONObject:custDataOffsetArray options:0 error:nil];
                                              [rest writeJsonDatatoFile:jsonData toPathExtension:customersFilePath error:cerr];
                                              }
                                          }
                                      }];
    
    [dataTask resume];

}
#pragma mark Warehouse Master Integration
-(void)getBrandsAndWarehousesListandsavetoDefaults{
    
    NSDictionary *headers = @{@"content-type": @"application/json",
                              @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)
                                  };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_warehouseMaster_b]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if(data)
                                                    {
                                                        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        NSArray *brandsA=dict[@"brandList"];
                                                        NSArray *warehouseLisA=dict[@"warehouseList"];
                                                        defaultSet([NSKeyedArchiver archivedDataWithRootObject:brandsA], brandsArrayList);
                                                        defaultSet([NSKeyedArchiver archivedDataWithRootObject:warehouseLisA], warehouseArrayList);
                                                        NSLog(@"%@--%@",[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(brandsArrayList)],  [NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(warehouseArrayList)]);
                                                        //                    [_delegateProducts productsListFetched];
                                                    }
                                                }];
    
    [dataTask resume];
}

#pragma mark Stock Details Integration
-(void)downLoadStockDetails
{
        NSDictionary *headers = @{@"content-type": @"application/json",
                                  @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
        NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail),
                                      @"offSet":[NSNumber numberWithInteger:stockOffset]
                                      };
        NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_stockDetails_b]];
        [request setHTTPMethod:@"POST"];
        [request setAllHTTPHeaderFields:headers];
        [request setHTTPBody:postData];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                      {
                          if(data){
                              NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
                              if(arr.count>1)
                                  {
                                      NSArray *slNoc=[arr valueForKeyPath:@"stock.Sl_No__c"];
                                      stockOffset=[slNoc[slNoc.count-1] intValue];
                                      [stockDetailsOffsetArray addObjectsFromArray:arr];
                                      [self downLoadStockDetails];
                                  }
                              else{
                                      [self saveStockDetailstoCoreData:stockDetailsOffsetArray];
                                  }
                              }
            }];
        [dataTask resume];
    
//    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://c.cs6.content.force.com/servlet/servlet.FileDownload?file=015N0000000fd6a"]]];
//
//    NSURLSessionDownloadTask *download=[session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        NSLog(@"Response---%@",response);
//        NSLog(@"Error---%@",error);
//        NSLog(@"Location--%@",location);
//
//        NSError *error1;
//        NSString *cachePathE = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:@"resourImage.jpeg"]                                                      ;
//        [fileManager moveItemAtPath:[location path]  toPath:cachePathE error:&error1];
//        NSLog(@"Error---%@",error1);
//    }];
//    [download resume];
}
-(void)saveStockDetailstoCoreData:(NSMutableArray*)arr
{
    NSArray *ids=[arr valueForKeyPath:@"stock.Id"];
    NSMutableArray *a=[[NSMutableArray alloc]init];
    [a addObjectsFromArray:ids];
    NSFetchRequest *fetchIds=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([StockDetails class])];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"codeId_s LIKE codeId_s"];
    [fetchIds setPredicate:predicate];
    NSArray *idsarr=[[ronakGlobal.context executeFetchRequest:fetchIds error:nil] valueForKeyPath:@"codeId_s"];
    [a removeObjectsInArray:idsarr];
    [a enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *pre=[NSPredicate predicateWithFormat:@"stock.Id == %@",obj];
        NSArray *sortedArray=[arr filteredArrayUsingPredicate:pre];
        NSDictionary *dict=sortedArray[0];
        NSDictionary *stDict=dict[@"stock"];
        NSEntityDescription *entitydesc=[NSEntityDescription entityForName:NSStringFromClass([StockDetails class]) inManagedObjectContext:ronakGlobal.context];
        //                ItemMaster *item=[[ItemMaster alloc]initWithContext:ronakGlobal.context];
        StockDetails *stockE=[[StockDetails alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:ronakGlobal.context];
        stockE.codeId_s=stDict[@"Id"];
        stockE.item_Code_s=stDict[@"Item_Code__c"];
        stockE.product__s=stDict[@"Product__c"];
        stockE.stock__s=[stDict[@"Stock__c"] floatValue];
        stockE.warehouse_Name_s=stDict[@"Warehouse_Name__c"];
        stockE.ordered_Quantity_s=[NSString stringWithFormat:@"%@",stDict[@"Ordered_Quantity__c"]];
        
        /*-----------------*/
        for (NSString *key in dict[@"imageURL"]) {
            NSLog(@"My Key-%@--Value-%@",key,[dict[@"imageURL"] valueForKey:key]);
            NSEntityDescription *enti=[NSEntityDescription entityForName:NSStringFromClass([ImagesArray class]) inManagedObjectContext:ronakGlobal.context];
            ImagesArray *imgD=[[ImagesArray alloc]initWithEntity:enti insertIntoManagedObjectContext:ronakGlobal.context];
            imgD.imageName=key;
            imgD.itemCode=stDict[@"Item_Code__c"];
            imgD.imageUrlPath=[dict[@"imageURL"] valueForKey:key]!=[NSNull null]?[dict[@"imageURL"] valueForKey:key]:@" ";
            [stockE addImagesArrObject:imgD];
        }
        /*-----------------*/
        [ronakGlobal.delegate saveContext];
        NSLog(@"Stock Count--%lu",(unsigned long)idx);
    }];
    [self getBrandsAndWarehousesListandsavetoDefaults];
    [self downloadImagesandSavetolocalDataBase];
}

-(void)downloadImagesandSavetolocalDataBase
{
    NSFetchRequest *fetchIds=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([StockDetails class])];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"item_Code_s LIKE item_Code_s"];
    [fetchIds setPredicate:predicate];
    NSArray *idsarr=[ronakGlobal.context executeFetchRequest:fetchIds error:nil];
    [idsarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        StockDetails *st=obj;
        /*-Attach Stock Object to Item  master Object in Core Data*/
            NSFetchRequest *fetchitems=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ItemMaster class])];
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"filters.item_No__c == %@",st.item_Code_s];
            [fetchitems setPredicate:predicate];
        NSArray *itemsObjs=[ronakGlobal.context executeFetchRequest:fetchitems error:nil];
        if(itemsObjs.count>0)
        {
            ItemMaster *item=itemsObjs.lastObject;
            NSLog(@"ProItemCode %@--StocItemCode%@",item.filters.item_No__c,st.item_Code_s);
            item.stock=st;
            st.brand_s=item.filters.brand__c; /*save product item brand to stock details item*/
            [ronakGlobal.delegate saveContext];
            /*----------------------------------------------------*/
            NSArray *arrImgs=[st.imagesArr allObjects];
            [arrImgs  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ImagesArray *img=obj;
                [self downloadImageFromURL:img.imageUrlPath withName:img.imageName];
            }];
    
        }
        else
        {
            NSLog(@"Id not matching in product Master-- %@",st.item_Code_s);
        }
        
    }];
    [_delegateProducts productsListFetched];
}
-(void) downloadImageFromURL :(NSString *)imageUrl withName:(NSString*)name{
    
    NSArray *listImageNames=[fileManager contentsOfDirectoryAtPath:[docPath stringByAppendingString:@"IMAGES/"] error:nil];
    if(![listImageNames containsObject:name])
    {
        NSURL  *url = [NSURL URLWithString:imageUrl];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
//            NSLog(@"Downloading started...");
            NSString *documentsDirectory = [docPath stringByAppendingString:@"IMAGES/"];
            NSString *filePath = [NSString stringWithFormat:@"%@%@",documentsDirectory,name];
//            NSLog(@"FILE : %@",filePath);
            [urlData writeToFile:filePath atomically:YES];
//            NSLog(@"Completed...");
        }
    }
    else
    {
        return;
    }
}
#pragma mark SaveOrder Integration

-(void)saleOrderIntegration:(NSMutableArray*)jsonParameter
{
    NSDictionary *headers = @{ @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)],
                               @"content-type": @"application/json" };
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail),
                                  @"saleOrderWrapper":jsonParameter};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_saveOrder_b]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
            {
                NSArray *jsonD=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@",jsonD);
                NSString *str=jsonD.count>0?jsonD[0][@"message"]:@"Succes";
                [[NSNotificationCenter defaultCenter]postNotificationName:@"SaveOrderStatus" object:str];
            }];
    [dataTask resume];
}

-(void)saveOrderWithAccessToken:(NSMutableArray*)jsonParameter{
    
    NSString *bodyStr =[NSString stringWithFormat:@"client_id=%@&RedirectURL=%@&grant_type=password&username=%@&password=%@",rest_clientID_B,rest_redirectURI_B,defaultGet(savedUserEmail),defaultGet(savedUserPassword)];
    [serverAPI getAuthTokenPath:rest_generateToken_B bodyString:bodyStr SuccessBlock:^(id responseObj)
     {
         NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
         NSLog(@"authToken Dictionary-->%@",dict);
         if(dict[@"access_token"]){
             defaultSet(dict[@"access_token"], kaccess_token);
             [self saleOrderIntegration:jsonParameter];
         }
         else{
             [[NSNotificationCenter defaultCenter]postNotificationName:@"SaveOrderStatus" object:dict[@"error_description"]];
         }
     } andErrorBlock:^(NSError *error) {
         [[NSNotificationCenter defaultCenter]postNotificationName:@"SaveOrderStatus" object:error.localizedDescription];
     }];
    
}

#pragma mark -Getting Auth Token--

-(void)regenerateAuthtenticationToken{
    
    NSString *bodyStr =[NSString stringWithFormat:@"client_id=%@&RedirectURL=%@&grant_type=password&username=%@&password=%@",rest_clientID_B,rest_redirectURI_B,defaultGet(savedUserEmail),defaultGet(savedUserPassword)];
    [serverAPI getAuthTokenPath:rest_generateToken_B bodyString:bodyStr SuccessBlock:^(id responseObj)
     {
         NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
         if(dict[@"access_token"])
         {
             defaultSet(dict[@"access_token"], kaccess_token);
             NSLog(@"--New Auth Token Generated -%@",defaultGet(kaccess_token));
         }
     } andErrorBlock:^(NSError *error) {
         
     }];
}

@end
