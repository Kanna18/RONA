//
//  CustomSwipe.m
//  RONAK
//
//  Created by Gaian on 8/29/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomSwipe.h"

@implementation CustomSwipe

-(instancetype)init
{
    self=[super init];
    if(self)
    {
        self.numberOfTouchesRequired=1;
    }
    return self;
}


@end
