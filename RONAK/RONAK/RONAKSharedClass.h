//
//  IncoisSharedClass.h
//  INCOIS
//
//  Created by Gaian on 5/15/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectedFilters.h"
#import "AppDelegate.h"
#import "ItemMaster+CoreDataClass.h"

@interface RONAKSharedClass : NSObject

+ (RONAKSharedClass *)sharedInstance;

@property NSMutableArray *selectedCustomersArray;
@property NSMutableArray *allCustomersList;

@property SelectedFilters *selectedFilter;

@property NSMutableArray *filterdProductsArray;
@property (nonatomic,strong) NSManagedObjectContext *context;
@property (nonatomic,strong) AppDelegate *delegate;
@property ItemMaster *item;

//Filters
@property NSArray *DefFiltersOne,*DefFiltersTwo,*advancedFilters1,*advancedFilters2;
@property NSMutableArray *discArr,*wsPriceArr,*priceArr,*stockArr;

//Order Booking
@property BOOL showClearOptionInCustomerCell;
@property NSMutableArray *selectedItemsTocartArr;/*items that save to cart*/
@end
