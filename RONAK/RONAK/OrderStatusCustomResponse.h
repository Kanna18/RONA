//
//  OrderStatusCustomResponse.h
//  RONAK
//
//  Created by Gaian on 11/7/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderStatsResponse.h"

@interface CustomRecord :NSObject

@property (nonatomic) NSString *typeOrder__c;
@property (nonatomic) NSString *typeId;
@property (nonatomic) NSString *typeName;
@property (nonatomic) NSString *typeDate__c;
@property (nonatomic) NSString *type_No__c;
@property (nonatomic) NSString *type_Status__c;
@property (nonatomic) NSString *typeSale_Order_No__c;
-(instancetype)initWithDict:(id)dict withRecodeType:(TypeOfRecord*)rec;
@end

@interface OrderStatusCustomResponse : NSObject

@property (nonatomic) NSString *cdId;
@property (nonatomic) NSString *Name;
@property (nonatomic) NSString *CreatedDate;
@property (nonatomic) NSString *Discount__c;
@property (nonatomic) NSString *Brand__c;
@property (nonatomic) NSString *Quantity__c;
@property (nonatomic) NSString *Account__c;
@property (nonatomic) NSString *Customer_Name__c;
@property (nonatomic) NSString *HOD_Date__c;
@property (nonatomic) NSString *MD_Date__c;
@property (nonatomic) NSString *Sale_Order_Date__c;
@property (nonatomic) NSString *Sale_Order_No__c;
@property (nonatomic) NSString *Ship_to_Party__c;
@property (nonatomic) NSString *Ship_To_Party_Nmae__c;
@property (nonatomic) NSString *Status__c;
@property (nonatomic) NSString *Net_Amount__c;
@property (nonatomic) NSString *Remarks__c;
@property (nonatomic) NSString *RSM_Date__c;
@property (nonatomic) NSString *SAP_Date__c;
@property (nonatomic) NSString *Sale_Order_No_Created_Date__c;
@property (nonatomic) TypeOfRecord *typeOfRec; //INVOICE or DELIVERY
@property (nonatomic) CustomRecord *record;
@property (nonatomic) NSString *statusCode_Response;
@property NSMutableArray *tvData;

-(instancetype)initWithDict:(OrderStatsResponse*)dict;
-(instancetype)initWithDict:(OrderStatsResponse*)dict andRecord:(id)rec;

@end
