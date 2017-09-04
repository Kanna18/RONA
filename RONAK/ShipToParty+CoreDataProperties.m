//
//  ShipToParty+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ShipToParty+CoreDataProperties.h"

@implementation ShipToParty (CoreDataProperties)

+ (NSFetchRequest<ShipToParty *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ShipToParty"];
}

@dynamic done;
@dynamic totalSize;
@dynamic customer;
@dynamic records;

@end
