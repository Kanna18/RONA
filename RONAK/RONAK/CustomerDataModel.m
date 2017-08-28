//
//  CustomerDataModel.m
//  RONAK
//
//  Created by Gaian on 7/24/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomerDataModel.h"

@implementation ShippingAddress

@end

@implementation BillingAddress

@end

@implementation Attributes

@end

@implementation Recodrs


@end

@implementation Ship_to_Party__r


@end

@implementation PDCRecodrs

@end

@implementation PDC__r

@end


@implementation CustomerDefauls

-(instancetype)init
{
    self=[super init];
    if(self)
    {
        self.defaultAddressIndex=[NSNumber numberWithInt:0];
        self.itemsCount=[[NSMutableArray alloc]init];
    }
    return self;
}

@end

@implementation CustomerDataModel
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        _defaultsCustomer=[[CustomerDefauls alloc]init];
        
    }
    return self;
}
@end


