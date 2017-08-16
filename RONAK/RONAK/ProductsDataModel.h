//
//  ProductsDataModel.h
//  RONAK
//
//  Created by Gaian on 8/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface Product : JSONModel

@property (nonatomic) Attributes<Optional>* attributes;
@property (nonatomic) NSString<Optional>* Flex_Temple__c;
@property (nonatomic) NSString<Optional>* Frame_Material__c;
@property (nonatomic) NSString<Optional>* Frame_Structure__c;
@property (nonatomic) NSString<Optional>* Front_Color__c;
@property (nonatomic) NSString<Optional>* Group_Name__c;
@property (nonatomic) NSString<Optional>* Item_Description__c;
@property (nonatomic) NSString<Optional>* Item_No__c;
@property (nonatomic) NSString<Optional>* Logo_Color__c;
@property (nonatomic) NSString<Optional>* WS_Price__c;
@property (nonatomic) NSString<Optional>* Product__c;
@property (nonatomic) NSString<Optional>* Shape__c;
@property (nonatomic) NSString<Optional>* Size__c;
@property (nonatomic) NSString<Optional>* Style_Code__c;
@property (nonatomic) NSString<Optional>* Temple_Color__c;
@property (nonatomic) NSString<Optional>* Temple_Material__c;
@property (nonatomic) NSString<Optional>* Tips_Color__c;
@property (nonatomic) NSString<Optional>* Collection_Name__c;
@property (nonatomic) NSString<Optional>* MRP__c;
@property (nonatomic) NSString<Optional>* Stock__c;
@end

@interface ProductsDataModel : JSONModel
@property (nonatomic) Product<Optional>* attributes;
@property (nonatomic) NSString<Optional>* imageURL;
@property (nonatomic) NSString<Optional>* imageName;
@end
