//
//  NSMutableArray+ArrayReverse.m
//  RONAK
//
//  Created by Gaian on 1/24/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import "NSMutableArray+ArrayReverse.h"

@implementation NSMutableArray (ArrayReverse)

- (void)reverse {
    if ([self count] <= 1)
        return;
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while (i < j) {
        [self exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
        
        i++;
        j--;
    }
}

@end
