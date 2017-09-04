//
//  CustomerDetails+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomerDetails+CoreDataProperties.h"

@implementation CustomerDetails (CoreDataProperties)

+ (NSFetchRequest<CustomerDetails *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CustomerDetails"];
}

@dynamic account_Balance__c;
@dynamic active__c;
@dynamic ageing_Date__c;
@dynamic bP_Code__c;
@dynamic category__c;
@dynamic category_Type__c;
@dynamic codeId;
@dynamic contact_Person__c;
@dynamic credit_Limit__c;
@dynamic customer_Name__c;
@dynamic discount__c;
@dynamic group_No__c;
@dynamic group_Type__c;
@dynamic name;
@dynamic ownerId;
@dynamic payment_Terms_Code__c;
@dynamic price_List_No__c;
@dynamic region__c;
@dynamic service_Period__c;
@dynamic x0_30__c;
@dynamic x31_60__c;
@dynamic x61_90__c;
@dynamic x91_120__c;
@dynamic x121_150__c;
@dynamic x151_180__c;
@dynamic x181_240__c;
@dynamic x241_300__c;
@dynamic x301_360__c;
@dynamic x361__c;
@dynamic atribute;
@dynamic billingAddress;
@dynamic shippingAddress;
@dynamic shipToParty;
@dynamic pdc_r;

@end
