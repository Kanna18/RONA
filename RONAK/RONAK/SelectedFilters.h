//
//  SelectedFilters.h
//  RONAK
//
//  Created by Gaian on 8/26/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectedFilters : NSObject

//Default Filters1
@property NSString *brand;
@property NSMutableArray *categories;
@property NSMutableArray *collection;
//Default Filters2
@property NSString *warehouseType;
@property NSMutableArray *stockHouseFilter;
@property NSMutableArray *sampleHouseFilter;
//Advanced Filters1
@property NSMutableArray *lensDescription;
@property NSMutableArray *shape,*frameMaterial,*templeMaterial,*templeColor,*tipsColor;
//Advanced Filters2
@property NSMutableArray *size,*FrontColor,*LensColor;


-(NSPredicate*)getPredicateStringFromTable:(NSString*)str;
-(void)clearAllFilters;
@end
