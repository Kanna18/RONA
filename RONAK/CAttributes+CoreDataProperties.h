//
//  CAttributes+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CAttributes+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CAttributes (CoreDataProperties)

+ (NSFetchRequest<CAttributes *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) Records *attribute;
@property (nullable, nonatomic, retain) CustomerDetails *customer;
@property (nullable, nonatomic, retain) Records_PDC *pdcRecord;

@end

NS_ASSUME_NONNULL_END
