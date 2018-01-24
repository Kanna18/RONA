//
//  Constants.h
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define searchFiilterCount 10

//Fonts
#define  helvTica(hgt)  [UIFont fontWithName:@"Helvetica" size:hgt]
#define  sfFont(hgt)  [UIFont fontWithName:@"SFUIDisplay-Regular" size:hgt]
#define calibriBol(si)    [UIFont fontWithName: @"Calibri Bold" size:si]

#define gothBook(si)    [UIFont fontWithName: @"Gotham-Book" size:si]
#define gothThin(si)    [UIFont fontWithName: @"Gotham-Thin" size:si]
#define gothBold(si)    [UIFont fontWithName: @"Gotham-Bold" size:si]
#define gothMedium(si)    [UIFont fontWithName: @"Gotham-Medium" size:si]


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
#define rest_generateToken_B @"https://test.salesforce.com/services/oauth2/token"
#define rest_clientID_B  @"3MVG9e2mBbZnmM6lFmND2Ju7xFYp.iaixYWQ7tuDZKWs4Jqs9pxjm3kenjwAqhG28yWavIReD9wkchzFaBcMO&client_secret=8967652660758155787"
#define rest_redirectURI_B @"sfdc://success"
#define rest_customersList_B @"https://cs6.salesforce.com/services/apexrest/CustomerMaster/"
#define rest_ProductList_B @"https://cs6.salesforce.com/services/apexrest/SampleProductDetails/"
#define rest_stockDetails_b @"https://cs6.salesforce.com/services/apexrest/StockDetails/"
#define rest_warehouseMaster_b @"https://cs6.salesforce.com/services/apexrest/WarehouseMaster1/"
#define rest_saveOrder_b  @"https://cs6.salesforce.com/services/apexrest/SaveSaleOrder"
#define rest_OrderStatus_b  @"https://cs6.salesforce.com/services/apexrest/SalesOrderStatus/"

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
#define RedClr RGB(237, 28, 36)
#define GrayLight RGB(228, 230, 232)
#define GrayLight1 RGB(193, 196, 201)
#define Blacktitle RGB(69, 69, 69)
#define BlackDull RGB((96, 96, 96)


//Filtertypes
#define kBrand @"Brand"
#define kCategories @"Categories"
#define kCollection @"Collection"
#define kSampleWareHouse @"Sample Warehouse"
#define kStockWareHouse @"Stock Warehouse"

//AdvancedFirstFilter
#define kLensDescription @"Lens Description"
#define kWSPrice @"WS Price"
#define kShape @"Shape"
#define kGender @"Gender"
#define kFrameMaterial @"Frame Material"
#define kTempleMaterial @"Temple Material"
#define kTempleColour @"Temple Color"
#define kTipColor @"Tip Color"
//AdvancedF2
#define kDiscount @"Discount"
#define kMRP @"MRP"
#define kRim @"Rim"
#define kSize @"Size"
#define kLensMaterial @"Lens Material"
#define kFrontColor @"Front Color"
#define kLensColor @"Lens Color"
#define kStockvalue @"Stock Qty"
#define  firstTimeLaunching @"FirstTime"
#define unzipedItemsSuccess @"unzip"

//OrderStatus
#define orderStatusArrayOffline @"OrderstatusArray" // Reports -Json Response saving array key
#define kSaleOrder @"SaleOrder"
#define ksaveDraft @"SaveDraft"
#define saveOrDraftsOrderArrayOffline @"SaveDraftOrder"


//Additional
#define storyBoard(mvc) [self.storyboard instantiateViewControllerWithIdentifier:mvc]
#define noOfTouches 1

#define passcode @"passcode"
#define confirmPasscode @"confirmPasscode"

#define brandsArrayList @"brandsList"
#define warehouseArrayList @"warehouseArrayLisy"


typedef NS_ENUM(NSUInteger, TypeOfRecord) {
    Parent_Type,
    DELIVERY_Type,
    INVOICE_Type,    
};

#define PRODUC_FETCHING_STATUS_NOTIFICATION @"ProductsFetchingStatus"
#define STOCK_FETCHING_STATUS_NOTIFICATION @"StockFetchingStatus"
#define IMAGES_FETCHING_STATUS_NOTIFICATION @"ImagesFecthingStatus"
#define STOCK_PRODUCT_ID_MATCHING_NOTIFICATION @"StockAndProductMatching"

#define orderStatusFolder @"ORDERSTATUS/"
#define orderSummaryFolder @"ORDERSUMMARYFOLDER/"
#endif /* Constants_h */


