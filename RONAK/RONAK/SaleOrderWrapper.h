//
//  SaleOrderWrapper.h
//  RONAK
//
//  Created by Gaian on 10/26/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SaleOrderLineItems : NSObject

@property NSString *ProductName;
@property NSString *Brand;
@property NSString *Description;
@property NSString *Quantity;
@property NSString *Total;
@property NSString *Price;
@property NSString *Discount;

-(instancetype)initWithItemDetails:(ItemMaster*)item Count:(int)count;

@end

@interface SaleOrderCustomers : NSObject
@property NSString *account;
@property NSString *shipToParty;
@property NSString *DeliveryChallan;
@property NSString *NetAmount;
@property NSString *Discount;
@property NSString *FutureDeliveryDate;
@property NSString *Remarks;
@property NSString *WarehouseCode;
@property NSString *TaxCode;
@property NSString *customerName;
@property BOOL draft;
@property NSString *salesforceID;

@property NSMutableArray *listItemsArray;
-(instancetype)initWithCustomerDetails:(CustomerDataModel*)cst;

@end

@interface SaleOrderWrapper : NSObject
-(instancetype)init;
@property NSMutableArray *finalArray;
-(void)sendResponseForString:(NSString*)str;

@end
