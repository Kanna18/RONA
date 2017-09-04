//
//  DownloadCustomersData.h
//  RONAK
//
//  Created by Gaian on 9/3/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomerDetails+CoreDataClass.h"
#import "ShipToParty+CoreDataClass.h"
#import "CShippingAddressC+CoreDataClass.h"
#import "CBillingAddressC+CoreDataClass.h"
#import "CAttributes+CoreDataClass.h"
#import "Records+CoreDataClass.h"
#import "CPDC_R+CoreDataClass.h"
#import "Records_PDC+CoreDataClass.h"



@interface DownloadCustomersData : NSObject
-(void)restServiceForCustomerList;
-(void)fetchAllsavedCustomers;
@end
