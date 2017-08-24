//
//  Filters+CoreDataProperties.m
//  RONAK
//
//  Created by Gaian on 8/23/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "Filters+CoreDataProperties.h"

@implementation Filters (CoreDataProperties)

+ (NSFetchRequest<Filters *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Filters"];
}

@dynamic codeId;
@dynamic stock_Warehouse__c;
@dynamic active_Form__c;
@dynamic brand__c;
@dynamic category__c;
@dynamic collection__c;
@dynamic color_Code__c;
@dynamic custom__c;
@dynamic delivery_Month__c;
@dynamic drawing_Code__c;
@dynamic factory_Company__c;
@dynamic flex_Temple__c;
@dynamic foreign_Name__c;
@dynamic frame_Material__c;
@dynamic frame_Structure__c;
@dynamic front_Color__c;
@dynamic group_Name__c;
@dynamic inactive__c;
@dynamic inactive_From__c;
@dynamic inactive_To__c;
@dynamic item_Description__c;
@dynamic item_Group_Product_Family__c;
@dynamic item_No__c;
@dynamic lens_Code__c;
@dynamic lens_Color__c;
@dynamic lens_Description__c;
@dynamic logo_Color__c;
@dynamic logo_Size__c;
@dynamic logo_Type__c;
@dynamic number__c;
@dynamic wS_Price__c;
@dynamic product__c;
@dynamic shape__c;
@dynamic size__c;
@dynamic style_Code__c;
@dynamic temple_Color__c;
@dynamic temple_Material__c;
@dynamic tips_Color__c;
@dynamic collection_Name__c;
@dynamic mRP__c;
@dynamic stock__c;
@dynamic order_Month__c;
@dynamic itemMaster;
@dynamic attribute;

@end
