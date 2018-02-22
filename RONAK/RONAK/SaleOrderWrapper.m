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
        _ProductName=item.filters.item_No__c;
        _Brand=item.filters.brand__c;
        _Description=@"description";//item.filters.description;
        _Quantity=[NSString stringWithFormat:@"%d",count];
        float tot=count*item.filters.mRP__c;
        _Total=[NSString stringWithFormat:@"%f",tot];
        _Price=[NSString stringWithFormat:@"%f",item.filters.mRP__c];
        _Discount=[NSString stringWithFormat:@"%f",item.filters.discount__c];
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
        _account=cst.Id;
        Recodrs *rec=cst.Ship_to_Party__r.records[cst.defaultsCustomer.defaultAddressIndex.integerValue];
        _shipToParty=rec.Id;
        _DeliveryChallan=@"challan";
        _NetAmount=@"";
        _customerName=cst.Name;
        _Discount=cst.defaultsCustomer.discount>0?cst.defaultsCustomer.discount:0;
        
        NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
        [monthFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr=[monthFormatter stringFromDate: cst.defaultsCustomer.dateFuture];
        _FutureDeliveryDate=dateStr?dateStr:[NSNull null];
        NSString *str=cst.defaultsCustomer.customerRemarks;
        _Remarks=str.length>0?str:@" ";
        NSString *str2=cst.defaultsCustomer.customerROIPL;
        _Roipl=str2.length>0?str2 : @"";
        
        _WarehouseCode=@"";
        _TaxCode=@"";
        
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


-(void)sendResponseForString:(NSString*)oderStr{
    
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
        
        sl.draft=[oderStr isEqualToString:kSaleOrder]?false:true;
        sl.salesforceID=[oderStr isEqualToString:ksaveDraft]?@"":@"";
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:                                       sl.account,@"account",
            sl.shipToParty,@"shipToParty",
            sl.DeliveryChallan,@"DeliveryChallan",
            [NSNumber numberWithInt:[sl.NetAmount intValue]],@"NetAmount",
            [NSNumber numberWithInt:[sl.Discount intValue]],@"Discount",
            sl.FutureDeliveryDate,@"FutureDeliveryDate",
            sl.Remarks,@"Remarks",
            sl.WarehouseCode,@"WarehouseCode",
            sl.TaxCode,@"TaxCode",
            itemsArr,@"saleOrdeLineItems",
            [NSNumber numberWithBool:sl.draft],@"draft",
            sl.Roipl,@"roipl",
            nil];
//        if([oderStr isEqualToString:ksaveDraft]){
//            [dict setValue:sl.salesforceID forKey:@"salesforceID"];
//        }
        [responseArr addObject:dict];
    }];
    NSData *data=[NSJSONSerialization dataWithJSONObject:responseArr options:0 error:nil];
    NSString *jsinStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsinStr);
    DownloadProducts *dow=[[DownloadProducts alloc]init];
//    [dow regenerateAuthtenticationToken];
    [dow saveOrderWithAccessToken:responseArr];
}

@end
