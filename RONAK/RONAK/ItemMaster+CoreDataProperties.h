//
//  ItemMaster+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 11/2/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//
//

#import "ItemMaster+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ItemMaster (CoreDataProperties)

+ (NSFetchRequest<ItemMaster *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *imageName;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, retain) Filters *filters;
@property (nullable, nonatomic, retain) StockDetails *stock;

@end

NS_ASSUME_NONNULL_END
