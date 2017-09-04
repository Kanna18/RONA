//
//  CAddressDetails+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CAddressDetails+CoreDataProperties.h"

@implementation CAddressDetails (CoreDataProperties)

+ (NSFetchRequest<CAddressDetails *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CAddressDetails"];
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

@end
