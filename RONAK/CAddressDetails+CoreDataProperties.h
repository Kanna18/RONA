//
//  CAddressDetails+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CAddressDetails+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CAddressDetails (CoreDataProperties)

+ (NSFetchRequest<CAddressDetails *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *country;
@property (nullable, nonatomic, copy) NSString *countryCode;
@property (nullable, nonatomic, copy) NSString *geocodeAccuracy;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *postalCode;
@property (nullable, nonatomic, copy) NSString *state;
@property (nullable, nonatomic, copy) NSString *stateCode;
@property (nullable, nonatomic, copy) NSString *street;

@end

NS_ASSUME_NONNULL_END
