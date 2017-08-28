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
                filter.discount__c=[NSString stringWithFormat:@"%@",filtersDict[@"Discount__c"]];
                filter.codeId=filtersDict[@"Id"];
                                
                NSDictionary *attDict=filtersDict[@"attributes"];
                
                NSEntityDescription *entityAtt=[NSEntityDescription entityForName:NSStringFromClass([Att class]) inManagedObjectContext:ronakGlobal.context];
                Att *attributes=[[Att alloc]initWithEntity:entityAtt insertIntoManagedObjectContext:ronakGlobal.context];
//                Att *attributes=[[Att alloc]initWithContext:ronakGlobal.context];
                attributes.type=attDict[@"type"];
                attributes.url=attDict[@"url"];
                
                item.filters=filter;
                item.filters.attribute=attributes;
            }
            NSLog(@"%lu",(unsigned long)idx);
        }];
        [ronakGlobal.delegate saveContext];
        [_delegateProducts productsListFetched];
    }
}
-(NSArray*)getFilterFor:(NSString*)strFor{
    
    NSMutableArray *brandsF=[[NSMutableArray alloc]init];
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([Filters class])];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%@ like %@",strFor,strFor];
    [fetch setPredicate:predicate];
    NSArray *brands=[ronakGlobal.context executeFetchRequest:fetch error:nil];
    [brands enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
        Filters *fil=obj;
        [brandsF addObject:[fil valueForKeyPath:[NSString stringWithFormat:@"%@",strFor]]?[fil valueForKeyPath:[NSString stringWithFormat:@"%@",strFor]]:@""];
    }];
    if([brandsF containsObject:@""]){
        [brandsF removeObject:@""];
    }
    NSSet *set=[NSSet setWithArray:brandsF];
    brandsF=(NSMutableArray*)[set allObjects];
    return brandsF;
}
-(NSMutableArray*)pickProductsFromFilters{
    
    NSPredicate *pre=[ronakGlobal.selectedFilter getPredicateStringFromTable:nil];
    
    NSMutableArray *items=[[NSMutableArray alloc]init];
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ItemMaster class])];
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.filters.brand__c == 'Idee'"];
//    NSPredicate *pred2=[NSPredicate predicateWithFormat:@"SELF.filters.category__c == 'Kids'"];
//    NSPredicate *placesPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[pred2, predicate]];
    [fetch setPredicate:pre];

    NSArray *arr=[ronakGlobal.context executeFetchRequest:fetch error:nil];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ItemMaster *item=obj;
        [items addObject:item];
    }];
    
    return items;
}

@end
