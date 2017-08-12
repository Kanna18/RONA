//
//  IncoisSharedClass.h
//  INCOIS
//
//  Created by Gaian on 5/15/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RONAKSharedClass : NSObject

+ (RONAKSharedClass *)sharedInstance;

@property NSMutableArray *selectedCustomersArray;

@end
