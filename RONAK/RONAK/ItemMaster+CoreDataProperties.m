//
//  ItemMaster+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 11/2/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//
//

#import "ItemMaster+CoreDataProperties.h"

@implementation ItemMaster (CoreDataProperties)

+ (NSFetchRequest<ItemMaster *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ItemMaster"];
}

@dynamic imageName;
@dynamic imageUrl;
@dynamic filters;
@dynamic stock;

@end
