//
//  StockDetails+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 10/16/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//
//

#import "StockDetails+CoreDataProperties.h"

@implementation StockDetails (CoreDataProperties)

+ (NSFetchRequest<StockDetails *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"StockDetails"];
}

@dynamic codeId_s;
@dynamic item_Code_s;
@dynamic product__s;
@dynamic stock__s;
@dynamic warehouse_Name_s;
@dynamic ordered_Quantity_s;
@dynamic warehouse_s;
@dynamic attrib;
@dynamic imagesArr;
@dynamic itemMaster;

@end