//
//  CustomerDetails+CoreDataClass.h
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CAttributes, CBillingAddressC, CPDC_R, CShippingAddressC, ShipToParty;

NS_ASSUME_NONNULL_BEGIN

@interface CustomerDetails : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "CustomerDetails+CoreDataProperties.h"
