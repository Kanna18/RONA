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

@interface DownloadProducts : NSObject
@property (nonatomic,strong) NSManagedObjectContext *context;
@property (nonatomic,strong) AppDelegate *delegate;
-(void)downloadStockWareHouseSavetoCoreData;
-(NSArray*)getFilterFor:(NSString*)strFor;
-(NSArray*)pickURLSfromBrand;
@end
