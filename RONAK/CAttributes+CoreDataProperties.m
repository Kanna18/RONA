//
//  CAttributes+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CAttributes+CoreDataProperties.h"

@implementation CAttributes (CoreDataProperties)

+ (NSFetchRequest<CAttributes *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CAttributes"];
}

@dynamic type;
@dynamic url;
@dynamic attribute;
@dynamic customer;
@dynamic pdcRecord;

@end
