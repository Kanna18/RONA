//
//  ImagesArray+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 11/2/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//
//

#import "ImagesArray+CoreDataProperties.h"

@implementation ImagesArray (CoreDataProperties)

+ (NSFetchRequest<ImagesArray *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ImagesArray"];
}

@dynamic imageName;
@dynamic imageUrlPath;
@dynamic itemCode;
@dynamic localPath;
@dynamic stock;

@end
