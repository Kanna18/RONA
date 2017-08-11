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

@interface CustomerDataModel : JSONModel

    @property (nonatomic) Attributes* attributes;
    @property (nonatomic) NSString<Optional>* Account_Balance__c;
    @property (nonatomic) NSString<Optional>* Active__c;
    @property (nonatomic) BillingAddress<Optional> *BillingAddress;
    @property (nonatomic) NSString<Optional>* BillingCity;
    @property (nonatomic) NSString<Optional>* BillingPostalCode;
    @property (nonatomic) NSString<Optional>* BillingState;
    @property (nonatomic) NSString<Optional>* BillingStreet;
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
    @property (nonatomic) NSString<Optional>* Telephone_1__c;
    @property (nonatomic) NSString<Optional>* Group_No__c;
    @property (nonatomic) NSString<Optional>* Group_Type__c;
    @property (nonatomic) NSString<Optional>* BP_Code__c;
    @property (nonatomic) NSString<Optional>* E_Mail__c;
    @property (nonatomic) NSString<Optional>* Contact_Person__c;
    @property (nonatomic) NSString<Optional>* Id;

@end
