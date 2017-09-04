//
//  CShippingAddressC+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CShippingAddressC+CoreDataProperties.h"

@implementation CShippingAddressC (CoreDataProperties)

+ (NSFetchRequest<CShippingAddressC *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CShippingAddressC"];
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
