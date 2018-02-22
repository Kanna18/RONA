//
//  SyncDBClass.m
//  RONAK
//
//  Created by Gaian on 1/13/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import "SyncDBClass.h"
#import "DownloadProducts.h"

@interface SyncDBClass(){

    AppDelegate *delegate;
    NSManagedObjectContext *syncMainContext;
    NSMutableArray *custDataOffsetArray, *productsOffsetArray,*stockDetailsOffsetArray, *issueStockDetailsArray;
    BOOL productMasterDone,stockWareHouseDone,customerDataDone;
    NSMutableData *custDataOffset;
    NSMutableArray *dataResp;
    RESTCalls *rest;
}

@end

int SyncoffSet=0, SyncproductsOffset=0,SyncstockOffset=0;

@implementation SyncDBClass
-(instancetype)init{
    self=[super init];
    if(self){

        dispatch_async(dispatch_get_main_queue(), ^{
            delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
            syncMainContext=delegate.managedObjectContext;
        });
        custDataOffsetArray=[[NSMutableArray alloc]init];
        productsOffsetArray=[[NSMutableArray alloc]init];
        stockDetailsOffsetArray=[[NSMutableArray alloc]init];
        issueStockDetailsArray=[[NSMutableArray alloc]init];
        
        DownloadProducts *dow=[[DownloadProducts alloc]init];
        [dow regenerateAuthtenticationToken];
    }
    return self;
}

#pragma  mark Product Master Integration
-(void)syncProductMaster
{
    NSLog(@"Products Started Getting");

    NSLog(@"--->%@",[NSPersistentContainer defaultDirectoryURL]);
    NSDictionary *headers = @{@"content-type": @"application/json",
                              @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail),
                                  @"offSet":[NSNumber numberWithInteger:SyncproductsOffset],
                                  @"sync":@"sync"
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
                                                  SyncproductsOffset=[slNoc[slNoc.count-1] intValue];
                                                  [productsOffsetArray addObjectsFromArray:arr];
                                                  [self syncProductMaster];
                                                  return ;
                                              }
                                              else{
                                                  SyncproductsOffset=0;
                                                  [self fetchData:productsOffsetArray];
                                                  return ;
                                              }
                                          }
                                      }];
    [dataTask resume];
}

-(void)fetchData:(NSMutableArray*)arr
{
    NSManagedObjectContext *productsContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    productsContext.parentContext=delegate.managedObjectContext;
    [productsContext performBlock:^{
        for (int i=0;i<arr.count;i++) {
            NSDictionary *dic =arr[i];
            NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ItemMaster class])];
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.filters.codeId == %@",dic[@"Id"]];
            [fetch setPredicate:predicate];
            NSArray *coreIds=[productsContext executeFetchRequest:fetch error:nil];//Get All IdsArray From Co`re Da
            if(coreIds.count>0||coreIds.count==0){
                ItemMaster *item;
                if(coreIds.count>0){
                    item=coreIds.lastObject;
                }else if(coreIds.count==0){
                    NSEntityDescription *entitydesc=[NSEntityDescription entityForName:NSStringFromClass([ItemMaster class]) inManagedObjectContext:productsContext];
                    item=[[ItemMaster alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:productsContext];
                }
                    item.imageUrl=dic[@"imageURL"];
                    item.imageName=dic[@"imageName"];
                Filters *filter=item.filters;
                NSDictionary *filtersDict=dic;
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
                NSError *errior;
                [productsContext save:nil];
                [syncMainContext save:&errior];
            }
            if(i==arr.count-1){
            [self syncStockWarehouse];
            [syncMainContext reset];
            }
        }
        if(arr.count==0){
            [self syncStockWarehouse];
            [syncMainContext reset];
        }
    }];
}


#pragma mark StockWareHouse
-(void)syncStockWarehouse
{
    NSLog(@"Stock Started Getting");
    NSDictionary *headers = @{@"content-type": @"application/json",
                              @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail),
                                  @"offSet":[NSNumber numberWithInteger:SyncstockOffset],
                                  @"sync":@"sync"
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
                                              if(arr.count>1)
                                              {
                                                  NSArray *slNoc=[arr valueForKeyPath:@"stock.Sl_No__c"];
                                                  SyncstockOffset=[slNoc[slNoc.count-1] intValue];
                                                  [stockDetailsOffsetArray addObjectsFromArray:arr];
                                                  [self syncStockWarehouse];
                                              }
                                              else{
                                                  SyncstockOffset=0;
                                                  NSArray *imgs=[stockDetailsOffsetArray valueForKeyPath:@"imageURL"];
                                                  [self firstSaveAllImagestoLocalDataBase:imgs];
                                                  [self saveStockDetailstoCoreData:stockDetailsOffsetArray];
                                              }
                                          }
                                      }];
    [dataTask resume];
}

-(void)saveStockDetailstoCoreData:(NSMutableArray*)arr
{
    NSManagedObjectContext *stockContext=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    stockContext.parentContext=syncMainContext;
    [stockContext performBlock:^{
        for (int i=0 ;i<arr.count;i++) {
            NSDictionary *dict = arr[i];
            NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([StockDetails class])];
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"item_Code_s == %@",dict[@"stock"][@"Item_Code__c"]];
            [fetch setPredicate:predicate];
            NSArray *coreIds=[stockContext executeFetchRequest:fetch error:nil];
            if(coreIds.count>0||coreIds.count==0){
                StockDetails *stockE;
                if(coreIds.count==0){
                    NSEntityDescription *entitydesc=[NSEntityDescription entityForName:NSStringFromClass([StockDetails class]) inManagedObjectContext:stockContext];
                    stockE=[[StockDetails alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:stockContext];
                }else{
                    stockE=coreIds.lastObject;
                    [self deleteExistedImagesforItem:stockE.item_Code_s];
                };
                NSDictionary *stDict=dict[@"stock"];
                stockE.codeId_s=stDict[@"Id"];
                stockE.item_Code_s=stDict[@"Item_Code__c"];
                stockE.product__s=stDict[@"Product__c"];
                stockE.stock__s=[stDict[@"Stock__c"] floatValue];
                stockE.warehouse_Name_s=stDict[@"Warehouse_Name__c"];
                stockE.ordered_Quantity_s=[NSString stringWithFormat:@"%@",stDict[@"Ordered_Quantity__c"]];
                NSSet *imagsArr=stockE.imagesArr;
                [stockE removeImagesArr:imagsArr];
                for (NSString *key in dict[@"imageURL"]) {
                    NSLog(@"My Key-%@--Value-%@",key,[dict[@"imageURL"] valueForKey:key]);
                    NSEntityDescription *enti=[NSEntityDescription entityForName:NSStringFromClass([ImagesArray class]) inManagedObjectContext:stockContext];                
                    ImagesArray *imgD=[[ImagesArray alloc]initWithEntity:enti insertIntoManagedObjectContext:stockContext];
                    imgD.imageName=key;
                    imgD.itemCode=stDict[@"Item_Code__c"];
                    imgD.imageUrlPath=[dict[@"imageURL"] valueForKey:key]!=[NSNull null]?[dict[@"imageURL"] valueForKey:key]:@" ";
                    [stockE addImagesArrObject:imgD];
                }
                [stockContext save:nil];
                NSError *erroor;
                [syncMainContext save:&erroor];
                NSLog(@"%@",erroor);
            }
            if(i==arr.count-1){
                [self matchStockIDSwithProductIDSandSavetoit:arr];
                [syncMainContext reset];
            }
        }
        if(arr.count==0){
            [self matchStockIDSwithProductIDSandSavetoit:arr];
            [syncMainContext reset];
        }
    }];
}

-(void)deleteExistedImagesforItem:(NSString*)itmCode{
    
//    NSManagedObjectContext *mainQc=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
//    mainQc.parentContext=syncMainContext;
//
//    [mainQc performBlock:^{
        NSFetchRequest *fet=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ImagesArray class])];
        NSPredicate *pred=[NSPredicate predicateWithFormat:@"itemCode LIKE %@",itmCode];
        [fet setPredicate:pred];
        NSArray *arr=[syncMainContext  executeFetchRequest:fet error:nil];
        for (ImagesArray *im in arr) {
            [syncMainContext deleteObject:im];
        }
//        [mainQc save:nil];
        [syncMainContext save:nil];
//    }];
}

-(void)firstSaveAllImagestoLocalDataBase:(NSArray*)arr
{
    NSLog(@"Thread 2-Started Saving Images");
    NSArray* firstHalf = [arr subarrayWithRange:NSMakeRange(0, [arr count]/2)];
    NSArray* secondHalf = [arr subarrayWithRange:NSMakeRange([arr count]/2, [arr count] - [arr count]/2)];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        [firstHalf enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *imgDict=obj;
            for (NSString *keyName in imgDict) {
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
                if(keyName&&imgDict[keyName]!=[NSNull null])
                {
                    [self downloadImageFromURL:imgDict[keyName] withName:keyName];
                }
                NSLog(@"Downloading Array 2-%@",keyName);
            }
        }];
    });
}
-(void) downloadImageFromURL :(NSString *)imageUrl withName:(NSString*)name{
    NSArray *listImageNames=[fileManager contentsOfDirectoryAtPath:[docPath stringByAppendingString:@"IMAGES/"] error:nil];
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
            //            NSLog(@"Completed...");
        }
    }
}

-(void)matchStockIDSwithProductIDSandSavetoit:(NSMutableArray*)arr
{
    NSManagedObjectContext *mathingContext=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        mathingContext.parentContext=syncMainContext;
        [mathingContext performBlock:^{
            for (int i=0; i<arr.count; i++) {
                NSDictionary *dict = arr[i];
                NSDictionary *stDict=dict[@"stock"];
                NSFetchRequest *fetchIds=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([StockDetails class])];
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"item_Code_s == %@",stDict[@"Item_Code__c"]];
                [fetchIds setPredicate:predicate];//Get All Stock Details in to array and macth the id to  Item master
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
                        NSError *error,*erroorr;
                        [mathingContext save:&error];
                        [syncMainContext save:&erroorr];
                        NSLog(@"Error while saving--%@",error);
                        /*----------------------------------------------------*/
                    }else{
                        NSLog(@"Id not matching in product Master-- %@",st.item_Code_s);
                    }
                }];
                if(i==arr.count-1){
                    [[NSNotificationCenter defaultCenter] postNotificationName:syncProductMasternotification object:nil];
                    [syncMainContext reset];
                }
            }
            if(arr.count==0){
                if(arr.count==0){
                    [[NSNotificationCenter defaultCenter] postNotificationName:syncProductMasternotification object:nil];
                    [syncMainContext reset];
                }
            }
        }];
}



-(void)syncOrderStatusResponse{
    
    NSDictionary *headers = @{ @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)],
                               @"content-type": @"application/json",
                               };
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_OrderStatus_b]
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
                                              NSArray *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                              NSError *err;
                                              defaultSet(dict, orderStatusArrayOffline);//Saving to defaults
                                            }
                                      }];
    [dataTask resume];
    
}

@end

