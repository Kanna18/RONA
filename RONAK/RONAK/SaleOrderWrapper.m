//
//  SaleOrderWrapper.m
//  RONAK
//
//  Created by Gaian on 10/26/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "SaleOrderWrapper.h"
/**************************************************************************************************************/
@implementation SaleOrderLineItems
-(instancetype)initWithItemDetails:(ItemMaster*)item Count:(int)count
{
    self=[super init];
    if(self)
    {
        _ProductName=item.filters.brand__c;
        _Brand=item.filters.brand__c;
        _Description=@"description";//item.filters.description;
        _Quantity=[NSString stringWithFormat:@"%d",count];
        float tot=count*[item.filters.mRP__c floatValue];
        _Total=@"total";//[NSString stringWithFormat:@"%f",tot];
        _Price=@"price";//[NSString stringWithFormat:@"%@",item.filters.mRP__c];
        _Discount=@"disc";//[NSString stringWithFormat:@"%@",item.filters.discount__c];
    }
    return self;
}
@end

/**************************************************************************************************************/
@implementation SaleOrderCustomers

-(instancetype)initWithCustomerDetails:(CustomerDataModel*)cst
{
    self=[super init];
    if(self)
    {
        _listItemsArray=[[NSMutableArray alloc]init];
        _account=@"accont";
        Recodrs *rec=cst.Ship_to_Party__r.records[cst.defaultsCustomer.defaultAddressIndex.integerValue];
        _shipToParty=rec.Id;
        _DeliveryChallan=@"challan";
        _NetAmount=@"netammount";
        _Discount=@"discount";
        _FutureDeliveryDate=@"27-10-18";
        _Remarks=@"remarks";
        _WarehouseCode=@"warehouse";
        _TaxCode=@"taxcode";
        
        NSSet *setItems=[NSSet setWithArray:cst.defaultsCustomer.itemsCount];
        NSCountedSet *countSet=[[NSCountedSet alloc]initWithArray:cst.defaultsCustomer.itemsCount];
        NSArray *arr=[setItems allObjects];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SaleOrderLineItems *line=[[SaleOrderLineItems alloc]initWithItemDetails:obj Count:(int)[countSet countForObject:obj]];
            [_listItemsArray addObject:line];
        }];
    }
    return self;
}
@end

/**************************************************************************************************************/
@implementation SaleOrderWrapper
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        _finalArray=[[NSMutableArray alloc]init];
        [ronakGlobal.selectedCustomersArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CustomerDataModel *c=obj;
            if(c.defaultsCustomer.itemsCount>0)
            {
                SaleOrderCustomers *saleCust=[[SaleOrderCustomers alloc]initWithCustomerDetails:c];
                [_finalArray addObject:saleCust];
            }
        }];
    }
    return self;
}


-(void)sendResponse{
    
    NSMutableArray *responseArr=[[NSMutableArray alloc]init];
    [_finalArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        SaleOrderCustomers *sl=obj;
        NSMutableArray *itemsArr=[[NSMutableArray alloc]init];
        
        [sl.listItemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SaleOrderLineItems *slItem=obj;
            NSDictionary *dict=@{@"ProductName":slItem.ProductName,
                                 @"Brand":slItem.Brand,
                                 @"Description":slItem.Description,
                                 @"Quantity":[NSNumber numberWithInt:[slItem.Quantity intValue]],
                                 @"Total":[NSNumber numberWithInt:[slItem.Total intValue]],
                                 @"Price":[NSNumber numberWithInt:[slItem.Price intValue]],
                                 @"Discount":[NSNumber numberWithInt:[slItem.Discount intValue]]
                                 };
            [itemsArr addObject:dict];
        }];
        
        
        [responseArr addObject:@{@"account":sl.account,
                                 @"shipToParty":sl.shipToParty,
                                 @"DeliveryChallan":sl.DeliveryChallan,
                                 @"NetAmount":[NSNumber numberWithInt:[sl.NetAmount intValue]],
                                 @"Discount":[NSNumber numberWithInt:[sl.Discount intValue]],
                                 @"FutureDeliveryDate":sl.FutureDeliveryDate,
                                 @"Remarks":sl.Remarks,
                                 @"WarehouseCode":sl.WarehouseCode,
                                 @"TaxCode":sl.TaxCode,
                                 @"saleOrdeLineItems":itemsArr
                                 }];
    }];
//    NSDictionary *dict=@{@"saleOrderWrapper":responseArr};
    NSData *data=[NSJSONSerialization dataWithJSONObject:responseArr options:0 error:nil];
    NSString *jsinStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsinStr);
    DownloadProducts *dow=[[DownloadProducts alloc]init];
    [dow saveOrderWithAccessToken:jsinStr];
}

@end
