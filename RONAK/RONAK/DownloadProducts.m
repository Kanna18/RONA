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
        _delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        _context=_delegate.persistentContainer.viewContext;
    }
    return self;
    
}
-(void)downloadStockWareHouseSavetoCoreData
{
    NSLog(@"--->%@",[NSPersistentContainer defaultDirectoryURL]);
    NSDictionary *headers = @{@"content-type": @"application/json",
                               @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://cs57.salesforce.com/services/apexrest/ProductDetails/"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        
        NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *code=obj[@"product"][@"Id"];
            NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:@"Filters"];
            NSPredicate *predicate=[NSPredicate predicateWithFormat:@"codeId == %@",code];
            [fetch setPredicate:predicate];
            NSArray *arr=[_context executeFetchRequest:fetch error:nil];
            if(!(arr.count>0))
            {
                NSDictionary *dic=obj;
                ItemMaster *item=[[ItemMaster alloc]initWithContext:_context];
                item.imageUrl=dic[@"imageURL"];
                item.imageName=dic[@"imageName"];
            
                NSDictionary *filtersDict=dic[@"product"];
                Filters *filter=[[Filters alloc]initWithContext:_context];
                filter.brand__c=filtersDict[@"Brand__c"];
                filter.category__c=filtersDict[@"Category__c"];
                filter.codeId=filtersDict[@"Id"];
                filter.collection__c=filtersDict[@"Collection__c"];
                filter.stock_Warehouse__c=filtersDict[@"Stock_Warehouse__c"];
                filter.stock__c=[NSString stringWithFormat:@"%@",filtersDict[@"Stock__c"]];
    
                NSDictionary *attDict=filtersDict[@"attributes"];
                Att *attributes=[[Att alloc]initWithContext:_context];
                attributes.type=attDict[@"type"];
                attributes.url=attDict[@"url"];
                
                item.filters=filter;
                item.filters.attribute=attributes;
            }
        }];
        [_delegate saveContext];
    }];
    [dataTask resume];
}
-(NSArray*)getFilterFor:(NSString*)strFor{
    
    NSMutableArray *brandsF=[[NSMutableArray alloc]init];
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([Filters class])];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%@ like %@",strFor,strFor];
    [fetch setPredicate:predicate];
    NSArray *brands=[_context executeFetchRequest:fetch error:nil];
    [brands enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
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
-(NSArray*)pickURLSfromBrand{
    NSMutableArray *images=[[NSMutableArray alloc]init];
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ItemMaster class])];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.filters.brand__c == 'Chopard'"];
    [fetch setPredicate:predicate];
    NSArray *arr=[_context executeFetchRequest:fetch error:nil];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ItemMaster *item=obj;
        [images addObject:item.imageUrl];
    }];
    
    return images;
}

@end
