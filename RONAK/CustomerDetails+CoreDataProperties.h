//
//  CustomerDetails+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomerDetails+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CustomerDetails (CoreDataProperties)

+ (NSFetchRequest<CustomerDetails *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *account_Balance__c;
@property (nullable, nonatomic, copy) NSString *active__c;
@property (nullable, nonatomic, copy) NSString *ageing_Date__c;
@property (nullable, nonatomic, copy) NSString *bP_Code__c;
@property (nullable, nonatomic, copy) NSString *category__c;
@property (nullable, nonatomic, copy) NSString *category_Type__c;
@property (nullable, nonatomic, copy) NSString *codeId;
@property (nullable, nonatomic, copy) NSString *contact_Person__c;
@property (nullable, nonatomic, copy) NSString *credit_Limit__c;
@property (nullable, nonatomic, copy) NSString *customer_Name__c;
@property (nullable, nonatomic, copy) NSString *discount__c;
@property (nullable, nonatomic, copy) NSString *group_No__c;
@property (nullable, nonatomic, copy) NSString *group_Type__c;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *ownerId;
@property (nullable, nonatomic, copy) NSString *payment_Terms_Code__c;
@property (nullable, nonatomic, copy) NSString *price_List_No__c;
@property (nullable, nonatomic, copy) NSString *region__c;
@property (nullable, nonatomic, copy) NSString *service_Period__c;
@property (nullable, nonatomic, copy) NSString *x0_30__c;
@property (nullable, nonatomic, copy) NSString *x31_60__c;
@property (nullable, nonatomic, copy) NSString *x61_90__c;
@property (nullable, nonatomic, copy) NSString *x91_120__c;
@property (nullable, nonatomic, copy) NSString *x121_150__c;
@property (nullable, nonatomic, copy) NSString *x151_180__c;
@property (nullable, nonatomic, copy) NSString *x181_240__c;
@property (nullable, nonatomic, copy) NSString *x241_300__c;
@property (nullable, nonatomic, copy) NSString *x301_360__c;
@property (nullable, nonatomic, copy) NSString *x361__c;
@property (nullable, nonatomic, retain) CAttributes *atribute;
@property (nullable, nonatomic, retain) CBillingAddressC *billingAddress;
@property (nullable, nonatomic, retain) CShippingAddressC *shippingAddress;
@property (nullable, nonatomic, retain) ShipToParty *shipToParty;
@property (nullable, nonatomic, retain) CPDC_R *pdc_r;

@end

NS_ASSUME_NONNULL_END
