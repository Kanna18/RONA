//
//  OrderStatsResponse.h
//  RONAK
//
//  Created by Gaian on 11/1/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol DeliveryRecords;

@interface DeliveryRecords :JSONModel
@property (nonatomic) Attributes<Optional>* attributes;
@property (nonatomic) NSString<Optional> *Sale_Order__c;
@property (nonatomic) NSString<Optional> *Id;
@property (nonatomic) NSString<Optional> *Name;
@property (nonatomic) NSString<Optional> *Delivery_Date__c;
@property (nonatomic) NSString<Optional> *Delivery_No__c;
@property (nonatomic) NSString<Optional> *Delivery_Status__c;
@property (nonatomic) NSString<Optional> *Sale_Order_No__c;
@end

@protocol InvoiceRecords;

@interface InvoiceRecords :JSONModel
@property (nonatomic) Attributes<Optional>* attributes;
@property (nonatomic) NSString<Optional> *Sale_Order__c;
@property (nonatomic) NSString<Optional> *Id;
@property (nonatomic) NSString<Optional> *Name;
@property (nonatomic) NSString<Optional> *Invoice_Date__c;
@property (nonatomic) NSString<Optional> *Invoice_No__c;
@property (nonatomic) NSString<Optional> *Invoice_Status__c;
@property (nonatomic) NSString<Optional> *Sale_Order_No__c;
@end

@interface Deliveries__R :JSONModel
@property (nonatomic) NSString<Optional> *totalSize;
@property (nonatomic) NSString<Optional> *done;
@property (nonatomic) NSArray <DeliveryRecords> *records;
@end

@interface Invoices__R :JSONModel

@property (nonatomic) NSString<Optional> *totalSize;
@property (nonatomic) NSString<Optional> *done;
@property (nonatomic) NSArray <InvoiceRecords> *records;

@end


@interface OrderStatsResponse : JSONModel

@property (nonatomic) Attributes<Optional>* attributes;
@property (nonatomic) NSString<Optional> *Id;
@property (nonatomic) NSString<Optional> *Name;
@property (nonatomic) NSString<Optional> *CreatedDate;
@property (nonatomic) NSString<Optional> *Discount__c;
@property (nonatomic) NSString<Optional> *Brand__c;
@property (nonatomic) NSString<Optional> *Quantity__c;
@property (nonatomic) NSString<Optional> *Account__c;
@property (nonatomic) NSString<Optional> *Customer_Name__c;
@property (nonatomic) NSString<Optional> *HOD_Date__c;
@property (nonatomic) NSString<Optional> *MD_Date__c;
@property (nonatomic) NSString<Optional> *Sale_Order_Date__c;
@property (nonatomic) NSString<Optional> *Sale_Order_No__c;
@property (nonatomic) NSString<Optional> *Ship_to_Party__c;
@property (nonatomic) NSString<Optional> *Ship_To_Party_Nmae__c;
@property (nonatomic) NSString<Optional> *Status__c;
@property (nonatomic) NSString<Optional> *Net_Amount__c;
@property (nonatomic) NSString<Optional> *Remarks__c;
@property (nonatomic) NSString<Optional> *RSM_Date__c;
@property (nonatomic) NSString<Optional> *SAP_Date__c;
@property (nonatomic) NSString<Optional> *Sale_Order_No_Created_Date__c;
@property (nonatomic) Deliveries__R<Optional> *Deliveries__r;
@property (nonatomic) Invoices__R<Optional> *Invoices__r;

@end
