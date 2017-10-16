//
//  SortProductsPage.h
//  RONAK
//
//  Created by Gaian on 9/11/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorBased : NSObject
-(instancetype)initWithArray:(NSArray*)arr;
@property NSString *model;
@property NSMutableArray *listItemsArray;

@end

@interface ModelBased : NSObject
-(instancetype)initWithArray:(NSArray*)arr;
@property NSString *category;
@property NSMutableArray  *ColorsArray;
@end


@interface CategoryBased : NSObject

-(instancetype)initWithArray:(NSArray*)arr;
-(NSMutableArray*)returnSortedItems;

@property NSMutableArray *ModelsArray;

@end
