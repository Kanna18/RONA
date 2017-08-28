//
//  IncoisSharedClass.m
//  INCOIS
//
//  Created by Gaian on 5/15/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import "RONAKSharedClass.h"

@implementation RONAKSharedClass


+ (RONAKSharedClass *)sharedInstance
{
    static RONAKSharedClass *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RONAKSharedClass alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        
        _selectedCustomersArray=[[NSMutableArray alloc]init];
        _selectedFilter=[[SelectedFilters alloc]init];
        _filterdProductsArray=[[NSMutableArray alloc]init];;
        _delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
        _context=_delegate.managedObjectContext;
    }
    return self;
}
@end
