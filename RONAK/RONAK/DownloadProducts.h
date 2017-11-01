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
#import "StockDetails+CoreDataClass.h"
#import "ImagesArray+CoreDataClass.h"

#import "AppDelegate.h"

@protocol FetchedAllProducts <NSObject>

-(void)productsListFetched;

@end

@interface DownloadProducts : NSObject

@property id<FetchedAllProducts>delegateProducts ;

-(void)downloadStockWareHouseSavetoCoreData;
-(void)getBrandsAndWarehousesListandsavetoDefaults;
-(void)downloadCustomersListInBackground;
-(void)downLoadStockDetails;

-(NSArray*)getFilterFor:(NSString*)strFor;
-(void)getFilterFor:(NSString*)strFor withContext:(NSManagedObjectContext*)cntxt;
-(NSMutableArray*)pickProductsFromFilters;
-(void)downloadImagesandSavetolocalDataBase;
-(void)saveOrderWithAccessToken:(NSString*)jsonParameter;
-(void)regenerateAuthtenticationToken;
@end
