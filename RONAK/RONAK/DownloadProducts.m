//
//  DownloadProducts.m
//  RONAK
//
//  Created by Gaian on 8/22/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//



#import "DownloadProducts.h"

#define Local_CallBackFor_Products_Stock_Fetched  @"PRODUCTS_FETCHED"


@interface DownloadProducts(){
    
    ServerAPIManager *serverAPI;
    NSURLSessionDataTask *sessionDatatask;
    NSMutableArray *custDataOffsetArray, *productsOffsetArray,*stockDetailsOffsetArray, *issueStockDetailsArray;
    RESTCalls *rest;
    BOOL fetchedStockMaster,fetchedProductMaster;
    AppDelegate *delegate;
    NSManagedObjectContext *downloadContext;
    
}
@end
int offSet=0, productsOffset=0,stockOffset=0;
int totalImages=0, currentImage=0, savedImages=0;

@implementation DownloadProducts


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
        issueStockDetailsArray=[[NSMutableArray alloc]init];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
            downloadContext=delegate.managedObjectContext;
        });
        
        
        //These two booleans will be set true based on completion of respective Service.
        fetchedStockMaster=NO;
        fetchedProductMaster=NO;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(matchStockIDSwithProductIDSandSavetoit) name:Local_CallBackFor_Products_Stock_Fetched object:nil];
    }
    return self;
}
#pragma  mark Product Master Integration
-(void)downloadStockWareHouseSavetoCoreData
{
    NSLog(@"Products Started Getting");
    
    NSLog(@"--->%@",[NSPersistentContainer defaultDirectoryURL]);
    NSDictionary *headers = @{@"content-type": @"application/json",
                               @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail),
                                  @"offSet":[NSNumber numberWithInteger:productsOffset],
                                  @"sync":@""
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
            if(arr.count>=1){
                NSArray *slNoc=[arr valueForKeyPath:@"Sl_No__c"];
                productsOffset=[slNoc[slNoc.count-1] intValue];
                [productsOffsetArray addObjectsFromArray:arr];
                [self downloadStockWareHouseSavetoCoreData];
                return ;
            }
            else{
                productsOffset=0;
                [self fetchData:productsOffsetArray];
                return ;
            }
        }
    }];
    [dataTask resume];
}
-(void)fetchData:(NSMutableArray*)arr
{
    NSManagedObjectContext *productsContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    productsContext.parentContext=downloadContext;    
    [productsContext performBlock:^{
        NSMutableArray *ids=[arr valueForKeyPath:@"Id"];//Get All IdsArray From Response
        NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:@"Filters"];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"codeId == codeId"];
        [fetch setPredicate:predicate];
        NSArray *coreIds=[[productsContext executeFetchRequest:fetch error:nil] valueForKey:@"codeId"];//Get All IdsArray From Core Data
        NSSet *set2=[NSSet setWithArray:coreIds];
        NSIndexSet *ind=[ids indexesOfObjectsPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [set2 containsObject:obj];
        }];
        [arr removeObjectsAtIndexes:ind];//Find out dupilcate IDS indexes that existed in Coredata with Response and remove them
        
        int Count=0;
        for (NSDictionary *obj in arr)
        {
                NSDictionary *dic=obj;
                NSEntityDescription *entitydesc=[NSEntityDescription entityForName:NSStringFromClass([ItemMaster class]) inManagedObjectContext:productsContext];
                
                ItemMaster *item=[[ItemMaster alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:productsContext];
                item.imageUrl=dic[@"imageURL"];
                item.imageName=dic[@"imageName"];
                NSDictionary *filtersDict=dic;
                NSEntityDescription *entityFilter=[NSEntityDescription entityForName:NSStringFromClass([Filters class]) inManagedObjectContext:productsContext];
                Filters *filter=[[Filters alloc]initWithEntity:entityFilter insertIntoManagedObjectContext:productsContext];
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
                filter.lens_Material__c=filtersDict[@"lence_material__c"];
                filter.discount__c=[filtersDict[@"Discount__c"] floatValue];
                filter.codeId=filtersDict[@"Id"];
                filter.picture_Name__c=filtersDict[@"Picture_Name__c"];
//                NSDictionary *attDict=filtersDict[@"attributes"];
//                NSEntityDescription *entityAtt=[NSEntityDescription entityForName:NSStringFromClass([Att class]) inManagedObjectContext:productsContext];
//                Att *attributes=[[Att alloc]initWithEntity:entityAtt insertIntoManagedObjectContext:productsContext];
//                attributes.type=attDict[@"type"];
//                attributes.url=attDict[@"url"];
                item.filters=filter;
//                item.filters.attribute=attributes;
            if(Count%1000==0||arr.count-Count==1)
            {
                NSError *err;
                [productsContext save:nil];
                [downloadContext save:&err];
                [productsContext reset];
            }
            if(arr.count-Count==1){
                fetchedProductMaster=YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:Local_CallBackFor_Products_Stock_Fetched object:nil];//Local Notification When All products fetched Completely
            }
            Count++;
            NSLog(@"Product-%d",Count);
            int percentage=[self progressofdownloadtotalValue:ids.count currentValue:Count remainingValue:arr.count];
            [[NSNotificationCenter defaultCenter] postNotificationName:PRODUC_FETCHING_STATUS_NOTIFICATION object:[NSNumber numberWithInteger:percentage]];
        }
        if(arr.count==0){
            fetchedProductMaster=YES;
            int percentage=[self progressofdownloadtotalValue:ids.count currentValue:Count remainingValue:arr.count];
            [[NSNotificationCenter defaultCenter] postNotificationName:PRODUC_FETCHING_STATUS_NOTIFICATION object:[NSNumber numberWithInteger:percentage]];
            [[NSNotificationCenter defaultCenter] postNotificationName:Local_CallBackFor_Products_Stock_Fetched object:nil];//Local Notification When All products fetched Completely
        }
    }];
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
    
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [collectionF removeObject:@"OLD"];
    [collectionF removeObject:@"Old"];
//    [collectionF removeObject:@"Sept-17"];
    NSSet *dupDat=[NSSet setWithArray:collectionF];
    NSArray *finalAr=[dupDat allObjects];
    [df setDateFormat:@"MM-yy"];
    NSArray *sortedArray = [finalAr sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSDate *d1 = [df dateFromString: obj1];
        NSDate *d2 = [df dateFromString: obj2];
        NSLog(@"comparing (%@ with %@) =%ld",obj2,obj1,(long)[d2 compare: d1]);
        if([d2 compare: d1]!=0){
            return [d2 compare: d1];
        }else{
            return nil;
        }
    }];
    
    
    ronakGlobal.discArr=discountF;
    ronakGlobal.wsPriceArr=wsPrice;
    ronakGlobal.priceArr=mrpF;
    ronakGlobal.stockArr=stockF;
    
    NSLog(@"%@",brandsF);
    NSMutableArray *bArr=[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(brandsArrayList)]];
    [bArr reverse];
    ronakGlobal.DefFiltersOne=   @[@{ @"heading":kBrand,
                                      @"options":[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(brandsArrayList)]?bArr:@[]},
                                   @{ @"heading":kCategories,
                                      @"options":[categoriesF sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]},
                                   @{ @"heading":kCollection,
                                      @"options":sortedArray}];
    ronakGlobal.DefFiltersTwo=   @[@{ @"heading":kStockWareHouse,
                                      @"options":[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(warehouseArrayList)]?[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(warehouseArrayList)]:@[]},
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
    [[NSNotificationCenter defaultCenter] postNotificationName:filtersQueryFetched object:nil];
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
    NSArray *arr=[downloadContext executeFetchRequest:fetch error:nil];
//    NSLog(@"%@",arr);
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
                                  @"offSet":[NSNumber numberWithInteger:offSet],
                                  @"sync":@""
                                  };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_customersList_B]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
            NSArray *arr;
            if(data){
            arr=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
            if(arr.count>=1){
                NSArray *slNoc=[arr valueForKeyPath:@"Sl_No__c"];
                offSet=[slNoc[slNoc.count-1] intValue];
                [custDataOffsetArray addObjectsFromArray:arr];
                [self restServiceForCustomerList];
            }
            else{
                    NSError *cerr;
                    offSet=0;
                    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:custDataOffsetArray options:0 error:nil];
                    [rest writeJsonDatatoFile:jsonData toPathExtension:customersFilePath error:cerr];
                    [[NSNotificationCenter defaultCenter] postNotificationName:syncCustomerMasterNotification object:cerr];
                }
            }
    }];
    [dataTask resume];

}
#pragma mark Warehouse Master Integration
static NSString * extracted() {
    return rest_warehouseMaster_b;
}

-(void)getBrandsAndWarehousesListandsavetoDefaults{
    
    NSDictionary *headers = @{@"content-type": @"application/json",
                              @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:extracted()] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
         {
            if(data)
            {
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if([dict isKindOfClass:[NSDictionary class]]){
                NSMutableArray *brandsA=dict[@"brandList"];
                NSMutableArray *warehouseLisA=dict[@"warehouseList"];
                defaultSet([NSKeyedArchiver archivedDataWithRootObject:brandsA], brandsArrayList);
                defaultSet([NSKeyedArchiver archivedDataWithRootObject:warehouseLisA], warehouseArrayList);
                NSLog(@"%@--%@",[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(brandsArrayList)],  [NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(warehouseArrayList)]);
                [[NSNotificationCenter defaultCenter] postNotificationName:syncBrandsStockNotification object:nil];
                }
            }
    }];
    [dataTask resume];
}

#pragma mark Stock Details Integration

-(void)downLoadStockDetails
{
    NSLog(@"Stock Started Getting");
    NSDictionary *headers = @{@"content-type": @"application/json",
                              @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail),
                                  @"offSet":[NSNumber numberWithInteger:stockOffset],
                                  @"sync":@""
                                };
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_stockDetails_b]];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
              {
                  if(data)
                  {
                      NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
                      if(arr.count>=1)
                      {
                          NSArray *slNoc=[arr valueForKeyPath:@"stock.Sl_No__c"];
                          stockOffset=[slNoc[slNoc.count-1] intValue];
                          [stockDetailsOffsetArray addObjectsFromArray:arr];
                          [self downLoadStockDetails];
                      }
              else{
                      stockOffset=0;
                      NSArray *imgs=[stockDetailsOffsetArray valueForKeyPath:@"imageURL"];
                      [self saveStockDetailstoCoreData:stockDetailsOffsetArray];
                      [self firstSaveAllImagestoLocalDataBase:imgs];
                  }
              }
          }];
    [dataTask resume];
}


-(void)firstSaveAllImagestoLocalDataBase:(NSArray*)arr
{
    NSSet *set=[NSSet setWithArray:arr];
    NSArray *dupArr=[set allObjects];
//    NSMutableArray *allImagesArray=[[NSMutableArray alloc]init];
    for (NSDictionary *dic in dupArr)
    {
        totalImages+=(int)dic.allKeys.count;
    }
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
//    dispatch_async(queue, ^{
//    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSDictionary *imgDict=obj;
//                    for (NSString *keyName in imgDict) {
//                        if(keyName&&imgDict[keyName]!=[NSNull null])
//                        {
//                            [self downloadImageFromURL:imgDict[keyName] withName:keyName];
//                        }
//                        NSLog(@"Downloading Images-%@",keyName);
//                    }
//    }];
//    });
    
    NSLog(@"Thread 2-Started Saving Images");
    NSArray* firstHalf = [dupArr subarrayWithRange:NSMakeRange(0, [dupArr count]/2)];
    NSArray* secondHalf = [dupArr subarrayWithRange:NSMakeRange([dupArr count]/2, [dupArr count] - [dupArr count]/2)];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [firstHalf enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *imgDict=obj;
            for (NSString *keyName in imgDict) {
                currentImage++;//SampleCode
                if(keyName&&imgDict[keyName]!=[NSNull null])
                {
                    [self downloadImageFromURL:imgDict[keyName] withName:keyName];
                }
                NSLog(@"Downloading Array1 Image-%@",keyName);
            }
        }];
    });

    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue2, ^{

        [secondHalf enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *imgDict=obj;
            for (NSString *keyName in imgDict) {
                currentImage++;//SampleCode
                if(keyName&&imgDict[keyName]!=[NSNull null])
                {
                    [self downloadImageFromURL:imgDict[keyName] withName:keyName];
                }
                NSLog(@"Downloading Array 2-%@",keyName);
            }
        }];
    });
}


-(void)saveStockDetailstoCoreData:(NSMutableArray*)arr
{
    NSManagedObjectContext *stockContext=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    stockContext.parentContext=downloadContext;
    
    [stockContext performBlock:^{
        int localCount=0;
        NSMutableArray *ids=[arr valueForKeyPath:@"stock.Id"];//Get All IdsArray From Response
        NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([StockDetails class])];
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"codeId_s LIKE codeId_s"];
        [fetch setPredicate:predicate];
        NSArray *coreIds=[[stockContext executeFetchRequest:fetch error:nil] valueForKey:@"codeId_s"];//Get All IdsArray From Core Data
        NSSet *set2=[NSSet setWithArray:coreIds];
        NSIndexSet *ind=[ids indexesOfObjectsPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [set2 containsObject:obj];
        }];
        [arr removeObjectsAtIndexes:ind];//Find out dupilcate IDS indexes that existed in Coredata with Response and remove them
    
        for (NSDictionary *dict in arr)
        {
//            NSPredicate *pre=[NSPredicate predicateWithFormat:@"stock.Id == %@",obj];
//            NSArray *sortedArray=[arr filteredArrayUsingPredicate:pre];
//            NSDictionary *dict=sortedArray[0];
            NSDictionary *stDict=dict[@"stock"];
            NSEntityDescription *entitydesc=[NSEntityDescription entityForName:NSStringFromClass([StockDetails class]) inManagedObjectContext:stockContext];
            //                ItemMaster *item=[[ItemMaster alloc]initWithContext:downloadContext];
            StockDetails *stockE=[[StockDetails alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:stockContext];
            stockE.codeId_s=stDict[@"Id"];
            stockE.item_Code_s=stDict[@"Item_Code__c"];
            stockE.product__s=stDict[@"Product__c"];
            stockE.stock__s=[stDict[@"Stock__c"] floatValue];
            stockE.warehouse_Name_s=stDict[@"Warehouse_Name1__c"];
            stockE.ordered_Quantity_s=[NSString stringWithFormat:@"%@",stDict[@"Ordered_Quantity__c"]];
            
            /*-----------------*/
            for (NSString *key in dict[@"imageURL"]) {
                NSLog(@"My Key-%@--Value-%@",key,[dict[@"imageURL"] valueForKey:key]);
                NSEntityDescription *enti=[NSEntityDescription entityForName:NSStringFromClass([ImagesArray class]) inManagedObjectContext:stockContext];
                ImagesArray *imgD=[[ImagesArray alloc]initWithEntity:enti insertIntoManagedObjectContext:stockContext];
                imgD.imageName=key;
                imgD.itemCode=stDict[@"Item_Code__c"];
                imgD.imageUrlPath=[dict[@"imageURL"] valueForKey:key]!=[NSNull null]?[dict[@"imageURL"] valueForKey:key]:@" ";
                [stockE addImagesArrObject:imgD];
            }
            /*-----------------*/            
            if(localCount%1000==0||arr.count-localCount==1)
            {
                [stockContext save:nil];
                [downloadContext save:nil];
                [stockContext reset];        
            }
            if(arr.count-localCount==1){
                fetchedStockMaster=YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:Local_CallBackFor_Products_Stock_Fetched object:nil];
            }
            NSLog(@"Stock Count--%d",localCount);
            localCount++;
            int percentage=[self progressofdownloadtotalValue:ids.count currentValue:localCount remainingValue:arr.count];
            [[NSNotificationCenter defaultCenter] postNotificationName:STOCK_FETCHING_STATUS_NOTIFICATION object:[NSNumber numberWithInteger:percentage]];
        }
        if(arr.count==0){
            fetchedStockMaster=YES;    
            int percentage=[self progressofdownloadtotalValue:ids.count currentValue:localCount remainingValue:arr.count];
            [[NSNotificationCenter defaultCenter] postNotificationName:STOCK_FETCHING_STATUS_NOTIFICATION object:[NSNumber numberWithInteger:percentage]];
            [[NSNotificationCenter defaultCenter] postNotificationName:Local_CallBackFor_Products_Stock_Fetched object:nil];
        }
    }];
    
}

-(void)matchStockIDSwithProductIDSandSavetoit
{
    if(fetchedStockMaster&&fetchedProductMaster)
    {
        [[NSNotificationCenter defaultCenter]removeObserver:Local_CallBackFor_Products_Stock_Fetched];
       __block NSManagedObjectContext *mathingContext=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        mathingContext.parentContext=downloadContext;
        [mathingContext performBlock:^{
            NSFetchRequest *fetchIds=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([StockDetails class])];
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"item_Code_s LIKE item_Code_s"];
            NSPredicate *brnD=[NSPredicate predicateWithFormat:@"brand_s == nil"];
            NSCompoundPredicate *fPre=[NSCompoundPredicate andPredicateWithSubpredicates:@[brnD,predicate]];
            [fetchIds setPredicate:fPre];//Get All Stock Details in to array and macth the id to  Item master
            NSArray *idsarr=[mathingContext executeFetchRequest:fetchIds error:nil];
            [idsarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                StockDetails *st=obj;
                NSLog(@"checking Code %@",st.item_Code_s);
                /*-Attach Stock Object to Item  master Object in Core Data*/
                NSFetchRequest *fetchitems=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ItemMaster class])];
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"filters.item_No__c == %@",st.item_Code_s];
                [fetchitems setPredicate:predicate];
                NSArray *itemsObjs=[mathingContext executeFetchRequest:fetchitems error:nil];
                if(itemsObjs.count>0){
                    ItemMaster *item=itemsObjs.lastObject;
                    NSLog(@"ProItemCode %@--StocItemCode%@",item.filters.item_No__c,st.item_Code_s);
                    item.stock=st;
                    st.brand_s=item.filters.brand__c; /*save product item brand to stock details item*/
//                    NSError *error;
//                    [mathingContext save:&error];
//                    [downloadContext save:nil];
//                    NSLog(@"Error while saving--%@",error);
                    /*----------------------------------------------------*/
                }else{
                    st.brand_s=@"Id not matching in product Master";
                    NSLog(@"Id not matching in product Master-- %@",st.item_Code_s);
                }
                if(idsarr.count-idx==1)
                {
                    //                [_delegateProducts productsListFetched];
                }
                float percent=((float)idx/(float)idsarr.count)*100.0;
                [[NSNotificationCenter defaultCenter] postNotificationName:STOCK_PRODUCT_ID_MATCHING_NOTIFICATION object:[NSNumber numberWithInteger:percent]];
                NSError *error;
                [mathingContext save:&error];
                [downloadContext save:nil];
            }];
            
            if(idsarr.count==0){
                float percent=100.0;
                [[NSNotificationCenter defaultCenter] postNotificationName:STOCK_PRODUCT_ID_MATCHING_NOTIFICATION object:[NSNumber numberWithInteger:percent]];
            }
            
        }];
    }
}
-(void) downloadImageFromURL :(NSString *)imageUrl withName:(NSString*)name{
    
//    currentImage++;//SampleCode
    NSArray *listImageNames=[fileManager contentsOfDirectoryAtPath:[docPath stringByAppendingString:@"IMAGES/"] error:nil];
    savedImages=(int)listImageNames.count;
    float ImagesPercentage=((float)currentImage/(float)totalImages) * 100.0;
    [[NSNotificationCenter defaultCenter]postNotificationName:IMAGES_FETCHING_STATUS_NOTIFICATION object:[NSNumber numberWithInteger:ImagesPercentage]];
    if([listImageNames containsObject:name])
    {
        return;
    }
    else
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
                        NSLog(@"imageUrl Completed...");
        }
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
                [self removeFromOfflineDraftsArray:jsonParameter];
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
         [[NSNotificationCenter defaultCenter]postNotificationName:@"SaveOrderStatus" object:@"Order will be saved when there is active internet connection"];
         [self addtoOfflineDraftsArray:jsonParameter];
     }];
}
-(void)addtoOfflineDraftsArray:(NSMutableArray*)jsonStr
{
    NSMutableArray *demoArr=[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(saveOrDraftsOrderArrayOffline)]];
    if(![demoArr containsObject:jsonStr]){
        [demoArr addObject:jsonStr];
    }
    defaultSet([NSKeyedArchiver archivedDataWithRootObject:demoArr], saveOrDraftsOrderArrayOffline);
    if(ronakGlobal.currentDraftRecord!=nil){//if Draft Rec is available;
        NSMutableArray *drfsArr=[[NSMutableArray alloc]initWithArray:defaultGet(deleteDraftOfflineArray)];
        [drfsArr addObject:ronakGlobal.currentDraftRecord];
        ronakGlobal.currentDraftRecord=nil;
        defaultSet(drfsArr, deleteDraftOfflineArray);
    }
}
-(void)removeFromOfflineDraftsArray:(NSMutableArray*)jsonStr
{
    NSMutableArray *demoArr=[NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:defaultGet(saveOrDraftsOrderArrayOffline)]];
    if([demoArr containsObject:jsonStr]){
        [demoArr removeObject:jsonStr];
    }
    defaultSet([NSKeyedArchiver archivedDataWithRootObject:demoArr], saveOrDraftsOrderArrayOffline);
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

-(int)progressofdownloadtotalValue:(float)total
                      currentValue:(float)current
                    remainingValue:(float)remainig
{
    float percentage = total-remainig+current;
    float Pdown=(percentage / total)*100;
    return Pdown;
}
-(void)deleteDraftWithRecID:(NSString*)recID{
    
    NSDictionary *headers = @{ @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)],
                               @"content-type": @"application/json" };
    NSDictionary *parameters = @{ @"recordId": recID,
                                  };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_DeleteDreaft_b]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if(data){
                                          NSString *jsonD=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          ronakGlobal.currentDraftRecord=nil;
                                          }
                                      }];
    [dataTask resume];
}
@end
