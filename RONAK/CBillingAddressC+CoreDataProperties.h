//
//  CBillingAddressC+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CBillingAddressC+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CBillingAddressC (CoreDataProperties)

+ (NSFetchRequest<CBillingAddressC *> *)fetchRequest;

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
@property (nullable, nonatomic, retain) CustomerDetails *customer;

@end

NS_ASSUME_NONNULL_END
