//
//  Att+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 10/16/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//
//

#import "Att+CoreDataProperties.h"

@implementation Att (CoreDataProperties)

+ (NSFetchRequest<Att *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Att"];
}

@dynamic type;
@dynamic url;
@dynamic filters;
@dynamic stock;

@end
