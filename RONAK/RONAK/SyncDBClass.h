//
//  SyncDBClass.h
//  RONAK
//
//  Created by Gaian on 1/13/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SyncDone
-(void)syncAllDataDone;
@end

@interface SyncDBClass : NSObject
@property id<SyncDone> delegate;
-(void)syncProductMaster;
-(void)syncStockWarehouse;
-(void)syncOrderStatusResponse;


@end
