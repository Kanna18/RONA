//
//  CustomerDataModel.h
//  RONAK
//
//  Created by Gaian on 7/24/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface Attributes : JSONModel

@property (nonatomic) NSString<Optional>* type;
@property (nonatomic) NSString<Optional>* url;

@end

@interface BillingAddress : JSONModel

    @property (nonatomic) NSString<Optional>* city;
    @property (nonatomic) NSString<Optional>* country;
    @property (nonatomic) NSString<Optional>* countryCode;
    @property (nonatomic) NSString<Optional>* geocodeAccuracy;
    @property (nonatomic) NSString<Optional>* latitude;
    @property (nonatomic) NSString<Optional>* longitude;
    @property (nonatomic) NSString<Optional>* postalCode;
    @property (nonatomic) NSString<Optional>* state;
    @property (nonatomic) NSString<Optional>* stateCode;
    @property (nonatomic) NSString<Optional>* street;

@end

@interface ShippingAddress : JSONModel

    @property (nonatomic) NSString<Optional>* city;
    @property (nonatomic) NSString<Optional>* country;
    @property (nonatomic) NSString<Optional>* countryCode;
    @property (nonatomic) NSString<Optional>* geocodeAccuracy;
    @property (nonatomic) NSString<Optional>* latitude;
    @property (nonatomic) NSString<Optional>* longitude;
    @property (nonatomic) NSString<Optional>* postalCode;
    @property (nonatomic) NSString<Optional>* state;
    @property (nonatomic) NSString<Optional>* stateCode;
    @property (nonatomic) NSString<Optional>* street;
@end


@protocol Recodrs;

@interface Recodrs : JSONModel
    @property (nonatomic) Attributes<Optional>* attributes;
    @property (nonatomic) NSString<Optional>* CustomerName__c;
    @property (nonatomic) NSString<Optional>* Id;
    @property (nonatomic) NSString<Optional>* Name;
    @property (nonatomic) NSString<Optional>* Block__c;
    @property (nonatomic) NSString<Optional>* CardCode__c;
    @property (nonatomic) NSString<Optional>* City__c;
    @property (nonatomic) NSString<Optional>* Country__c;
    @property (nonatomic) NSString<Optional>* State__c;
    @property (nonatomic) NSString<Optional>* Street__c;
    @property (nonatomic) NSString<Optional>* Street_No__c;
    @property (nonatomic) NSString<Optional>* Zipcode__c;
@end

@interface Ship_to_Party__r : JSONModel
    @property (nonatomic) NSString<Optional>* totalSize;
    @property (nonatomic) NSString<Optional>* done;
    @property (nonatomic) NSArray<Recodrs>* records;
@end

@interface CustomerDataModel : JSONModel

    @property (nonatomic) Attributes* attributes;
    @property (nonatomic) NSString<Optional>* Account_Balance__c;
    @property (nonatomic) NSString<Optional>* Active__c;
    @property (nonatomic) BillingAddress<Optional> *BillingAddress;
    @property (nonatomic) NSString<Optional>* BillingCity;
    @property (nonatomic) NSString<Optional>* BillingPostalCode;
    @property (nonatomic) NSString<Optional>* BillingState;
    @property (nonatomic) NSString<Optional>* BillingStreet;
    @property (nonatomic) NSString<Optional>* Category_Type__c;
    @property (nonatomic) NSString<Optional>* Category__c;
    @property (nonatomic) NSString<Optional>* Credit_Limit__c;
    @property (nonatomic) NSString<Optional>* Discount__c;
    @property (nonatomic) NSString<Optional>* Name;
    @property (nonatomic) NSString<Optional>* OwnerId;
    @property (nonatomic) NSString<Optional>* Payment_Terms_Code__c;
    @property (nonatomic) NSString<Optional>* Price_List_No__c;
    @property (nonatomic) NSString<Optional>* Region__c;
    @property (nonatomic) NSString<Optional>* Service_Period__c;
    @property (nonatomic) ShippingAddress<Optional> *ShippingAddress;
    @property (nonatomic) NSString<Optional>* ShippingCity;
    @property (nonatomic) NSString<Optional>* ShippingCountry;
    @property (nonatomic) NSString<Optional>* ShippingPostalCode;
    @property (nonatomic) NSString<Optional>* ShippingState;
    @property (nonatomic) NSString<Optional>* ShippingStreet;
    @property (nonatomic) NSString<Optional>* Group_No__c;
    @property (nonatomic) NSString<Optional>* Group_Type__c;
    @property (nonatomic) NSString<Optional>* BP_Code__c;
    @property (nonatomic) NSString<Optional>* Contact_Person__c;
    @property (nonatomic) NSString<Optional>* X0_30__c ;
    @property (nonatomic) NSString<Optional>* Ageing_Date__c;
    @property (nonatomic) NSString<Optional>* X121_150__c;
    @property (nonatomic) NSString<Optional>* X151_180__c;
    @property (nonatomic) NSString<Optional>* X181_240__c;
    @property (nonatomic) NSString<Optional>* X241_300__c;
    @property (nonatomic) NSString<Optional>* X301_360__c;
    @property (nonatomic) NSString<Optional>* X31_60__c;
    @property (nonatomic) NSString<Optional>* X361__c;
    @property (nonatomic) NSString<Optional>* X61_90__c;
    @property (nonatomic) NSString<Optional>* X91_120__c;
    @property (nonatomic) NSString<Optional>* Customer_Name__c;
    @property (nonatomic) NSString<Optional>* Id;
    @property (nonatomic) Ship_to_Party__r<Optional>* Ship_to_Party__r;


@property (nonatomic) NSString<Optional>* Telephone_1__c;
@property (nonatomic) NSString<Optional>* E_Mail__c;

@end
