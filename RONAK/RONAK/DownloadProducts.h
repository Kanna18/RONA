//
//  DownloadProducts.h
//  RONAK
//
//  Created by Gaian on 8/22/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemMaster+CoreDataClass.h"
#import "Att+CoreDataClass.h"
#import "Filters+CoreDataClass.h"
#import "AppDelegate.h"

@protocol FetchedAllProducts <NSObject>

-(void)productsListFetched;

@end

@interface DownloadProducts : NSObject
@property id<FetchedAllProducts>delegateProducts ;

-(void)downloadStockWareHouseSavetoCoreData;
-(void)getFilterFor:(NSString*)strFor;
-(NSMutableArray*)pickProductsFromFilters;
@end
