//
//  ItemMaster+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 8/23/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ItemMaster+CoreDataProperties.h"

@implementation ItemMaster (CoreDataProperties)

+ (NSFetchRequest<ItemMaster *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ItemMaster"];
}

@dynamic imageUrl;
@dynamic imageName;
@dynamic filters;

@end
