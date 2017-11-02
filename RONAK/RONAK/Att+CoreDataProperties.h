//
//  Att+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 11/2/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//
//

#import "Att+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Att (CoreDataProperties)

+ (NSFetchRequest<Att *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) Filters *filters;
@property (nullable, nonatomic, retain) StockDetails *stock;

@end

NS_ASSUME_NONNULL_END
