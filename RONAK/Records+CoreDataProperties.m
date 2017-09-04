//
//  Records+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "Records+CoreDataProperties.h"

@implementation Records (CoreDataProperties)

+ (NSFetchRequest<Records *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Records"];
}

@dynamic block__c;
@dynamic cardCode__c;
@dynamic city__c;
@dynamic codeID;
@dynamic country__c;
@dynamic customerName__c;
@dynamic name;
@dynamic state__c;
@dynamic street__c;
@dynamic street_No__c;
@dynamic zipcode__c;
@dynamic attribute;
@dynamic shiptoParty;

@end
