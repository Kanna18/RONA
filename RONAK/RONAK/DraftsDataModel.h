//
//  DraftsDataModel.h
//  RONAK
//
//  Created by Gaian on 1/25/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ItemRecord;

@interface ItemRecord :JSONModel
@property (nonatomic) NSString<Optional> *Sale_Order__c;
@property (nonatomic) NSString<Optional> *Id;
@property (nonatomic) NSString<Optional> *Brand__c;
@property (nonatomic) NSString<Optional> *Description__c;
@property (nonatomic) NSString<Optional> *Discount__c;
@property (nonatomic) NSString<Optional> *Price__c;
@property (nonatomic) NSString<Optional> *Product__c;
@property (nonatomic) NSString<Optional> *Quantity__c;
@property (nonatomic) NSString<Optional> *Total__c;
@end


@interface Order_Line_Items__r :JSONModel

@property (nonatomic) NSString<Optional> *totalSize;
@property (nonatomic) NSString<Optional> *done;
@property (nonatomic) NSArray <ItemRecord> *records;

@end

@interface DraftsDataModel : JSONModel

@property (nonatomic) NSString<Optional> *Id;
@property (nonatomic) NSString<Optional> *Account__c;
@property (nonatomic) NSString<Optional> *Delivery_Challan__c;
@property (nonatomic) NSString<Optional> *Discount__c;
@property (nonatomic) NSString<Optional> *Net_Amount__c;
@property (nonatomic) NSString<Optional> *Remarks__c;
@property (nonatomic) NSString<Optional> *Ship_to_Party__c;
@property (nonatomic) NSString<Optional> *Tax_Code__c;
@property (nonatomic) NSString<Optional> *Warehouse_Code__c;
@property (nonatomic) NSString<Optional> *Draft__c;
@property (nonatomic) NSString<Optional> *Brand__c;
@property (nonatomic) NSString<Optional> *Quantity__c;
@property (nonatomic) NSString<Optional> *customerName__c;
@property (nonatomic) Order_Line_Items__r<Optional> *Order_Line_Items__r;


@end
