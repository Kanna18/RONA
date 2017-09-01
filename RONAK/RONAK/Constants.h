//
//  Constants.h
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#ifndef Constants_h
#define Constants_h


//Fonts
#define  sfFont(hgt)  [UIFont fontWithName:@"SFUIDisplay-Regular" size:hgt]
#define calibriBol(si)    [UIFont fontWithName: @"Calibri Bold" size:si]

//User Defaults
#define defaultSet(value,key)    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key]
#define defaultGet(key)          [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define defaultRemove(obj)       [[NSUserDefaults standardUserDefaults]removeObjectForKey:obj]

//Loading View
#define showMessage(message,view) [[[LoadingView alloc]init]waringLabelText:message onView:view]

//TextField Validationsf
#define MinPasswordLength 8
#define RegexHasDigit @"[0-9]+(\.[0-9][0-9]?)?"
#define RegexHasCapitalAndSmallLetters @"^(?=.*[a-z])(?=.*[A-Z]).+$"
#define RegexHasSpecialCharacter @"[!,@,#,$,%,^,&,*,?,_,~,-,£,(,)]"

//Rest Services
#define rest_generateToken_B @"https://cs57.salesforce.com/services/oauth2/token"
#define rest_clientID_B  @"3MVG959Nd8JMmavR0MNi_h5fdNCoOUDS_ypUngOOSVfBs_SR13nYZOUVEL_EicYnkB2zIviYaiVt.APVTqGXq&client_secret=1609466711200752982"
#define rest_redirectURI_B @"sfdc://success"
#define rest_customersList_B @"https://cs57.salesforce.com/services/apexrest/CustomerMaster/getCustomerMasterDetails"
#define rest_ProductList_B @"https://cs57.salesforce.com/services/apexrest/SampleProductDetails/"


//constants to save in defaults
#define kaccess_token @"access_token"

//loginCredentials
#define savedUserEmail @"userEmail"
#define savedUserPassword @"userPassword"

//CustomersData
#define savedCustomersList @"savedCustomersList"
#define selectedCustomersList [RONAKSharedClass sharedInstance].selectedCustomersArray
#define ronakGlobal [RONAKSharedClass sharedInstance]

//Paths
#define fileManager [NSFileManager defaultManager]
#define docPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"/"]
#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"/"]
#define customersFilePath @"Customers.json"
#define productFilePath @"Products.json"


//colorCodes

#define RGB(r,g,b) [[UIColor alloc]initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define GreenClr RGB(0, 165, 80)
#define BlueClr RGB(0, 122, 255)
#define RedClr RGB(237, 29, 36)
#define GrayLight RGB(228, 230, 232)
#define GrayLight1 RGB(193, 196, 201)
#define Blacktitle RGB(69, 69, 69)
#define BlackDull RGB((96, 96, 96)


//Filtertypes
#define kBrand @"Brand"
#define kCategories @"Categories"
#define kCollection @"Collection"
#define kSampleWareHouse @"SampleWare House"
#define kStockWareHouse @"StockWare House"

//AdvancedFirstFilter
#define kLensDescription @"Lens Description"
#define kWSPrice @"WS Price"
#define kShape @"Shape"
#define kGender @"Gender"
#define kFrameMaterial @"Frame Material"
#define kTempleMaterial @"Temple Material"
#define kTempleColour @"Temple Colour"
#define kTipColor @"Tip Color"
//AdvancedF2
#define kDiscount @"Discount"
#define kMRP @"MRP"
#define kRim @"Rim"
#define kSize @"Size"
#define kLensMaterial @"Lens Material"
#define kFrontColor @"Front Color"
#define kLensColor @"Lens Color"
#define  firstTimeLaunching @"FirstTime"


//Additional
#define storyBoard(mvc) [self.storyboard instantiateViewControllerWithIdentifier:mvc]
#define noOfTouches 1



#endif /* Constants_h */


