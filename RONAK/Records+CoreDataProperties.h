//
//  Records+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "Records+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Records (CoreDataProperties)

+ (NSFetchRequest<Records *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *block__c;
@property (nullable, nonatomic, copy) NSString *cardCode__c;
@property (nullable, nonatomic, copy) NSString *city__c;
@property (nullable, nonatomic, copy) NSString *codeID;
@property (nullable, nonatomic, copy) NSString *country__c;
@property (nullable, nonatomic, copy) NSString *customerName__c;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *state__c;
@property (nullable, nonatomic, copy) NSString *street__c;
@property (nullable, nonatomic, copy) NSString *street_No__c;
@property (nullable, nonatomic, copy) NSString *zipcode__c;
@property (nullable, nonatomic, retain) CAttributes *attribute;
@property (nullable, nonatomic, retain) ShipToParty *shiptoParty;

@end

NS_ASSUME_NONNULL_END
