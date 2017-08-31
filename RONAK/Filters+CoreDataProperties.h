//
//  Filters+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 8/27/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "Filters+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Filters (CoreDataProperties)

+ (NSFetchRequest<Filters *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *active_From__c;
@property (nullable, nonatomic, copy) NSString *brand__c;
@property (nullable, nonatomic, copy) NSString *category__c;
@property (nullable, nonatomic, copy) NSString *codeId;
@property (nullable, nonatomic, copy) NSString *collection__c;
@property (nullable, nonatomic, copy) NSString *collection_Name__c;
@property (nullable, nonatomic, copy) NSString *color_Code__c;
@property (nullable, nonatomic, copy) NSString *custom__c;
@property (nullable, nonatomic, copy) NSString *delivery_Month__c;
@property (nullable, nonatomic, copy) NSString *drawing_Code__c;
@property (nullable, nonatomic, copy) NSString *factory_Company__c;
@property (nullable, nonatomic, copy) NSString *flex_Temple__c;
@property (nullable, nonatomic, copy) NSString *foreign_Name__c;
@property (nullable, nonatomic, copy) NSString *frame_Material__c;
@property (nullable, nonatomic, copy) NSString *frame_Structure__c;
@property (nullable, nonatomic, copy) NSString *front_Color__c;
@property (nullable, nonatomic, copy) NSString *group_Name__c;
@property (nullable, nonatomic, copy) NSString *inactive__c;
@property (nullable, nonatomic, copy) NSString *inactive_From__c;
@property (nullable, nonatomic, copy) NSString *inactive_To__c;
@property (nullable, nonatomic, copy) NSString *item_Description__c;
@property (nullable, nonatomic, copy) NSString *item_Group_Product_Family__c;
@property (nullable, nonatomic, copy) NSString *item_No__c;
@property (nullable, nonatomic, copy) NSString *lens_Code__c;
@property (nullable, nonatomic, copy) NSString *lens_Color__c;
@property (nullable, nonatomic, copy) NSString *lens_Description__c;
@property (nullable, nonatomic, copy) NSString *logo_Color__c;
@property (nullable, nonatomic, copy) NSString *logo_Size__c;
@property (nullable, nonatomic, copy) NSString *logo_Type__c;
@property (nullable, nonatomic, copy) NSString *mRP__c;
@property (nullable, nonatomic, copy) NSString *number__c;
@property (nullable, nonatomic, copy) NSString *order_Month__c;
@property (nullable, nonatomic, copy) NSString *product__c;
@property (nullable, nonatomic, copy) NSString *shape__c;
@property (nullable, nonatomic, copy) NSString *size__c;
@property (nullable, nonatomic, copy) NSString *stock__c;
@property (nullable, nonatomic, copy) NSString *stock_Warehouse__c;
@property (nullable, nonatomic, copy) NSString *style_Code__c;
@property (nullable, nonatomic, copy) NSString *temple_Color__c;
@property (nullable, nonatomic, copy) NSString *temple_Material__c;
@property (nullable, nonatomic, copy) NSString *tips_Color__c;
@property (nullable, nonatomic, copy) NSString *wS_Price__c;
@property (nullable, nonatomic, copy) NSString *discount__c;
@property (nullable, nonatomic, copy) NSString *active_To__c;
@property (nullable, nonatomic, copy) NSString *rim__c;
@property (nullable, nonatomic, copy) NSString *lens_Material__c;
@property (nullable, nonatomic, retain) Att *attribute;
@property (nullable, nonatomic, retain) ItemMaster *itemMaster;

@end

NS_ASSUME_NONNULL_END
