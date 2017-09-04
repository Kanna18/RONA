//
//  ShipToParty+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ShipToParty+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ShipToParty (CoreDataProperties)

+ (NSFetchRequest<ShipToParty *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *done;
@property (nullable, nonatomic, copy) NSString *totalSize;
@property (nullable, nonatomic, retain) CustomerDetails *customer;
@property (nullable, nonatomic, retain) NSSet<Records *> *records;

@end

@interface ShipToParty (CoreDataGeneratedAccessors)

- (void)addRecordsObject:(Records *)value;
- (void)removeRecordsObject:(Records *)value;
- (void)addRecords:(NSSet<Records *> *)values;
- (void)removeRecords:(NSSet<Records *> *)values;

@end

NS_ASSUME_NONNULL_END
