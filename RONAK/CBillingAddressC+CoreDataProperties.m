//
//  CBillingAddressC+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CBillingAddressC+CoreDataProperties.h"

@implementation CBillingAddressC (CoreDataProperties)

+ (NSFetchRequest<CBillingAddressC *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CBillingAddressC"];
}

@dynamic city;
@dynamic country;
@dynamic countryCode;
@dynamic geocodeAccuracy;
@dynamic latitude;
@dynamic longitude;
@dynamic postalCode;
@dynamic state;
@dynamic stateCode;
@dynamic street;
@dynamic customer;

@end
