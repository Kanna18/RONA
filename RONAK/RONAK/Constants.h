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
#define rest_itemList_B @"https://cs57.salesforce.com/services/apexrest/ProductDetails/"

//constants to save in defaults
#define kaccess_token @"access_token"

//loginCredentials
#define savedUserEmail @"userEmail"
#define savedUserPassword @"userPassword"

//CustomersData
#define savedCustomersList @"savedCustomersList"
#define selectedCustomersList [RONAKSharedClass sharedInstance].selectedCustomersArray

//Paths
#define fileManager [NSFileManager defaultManager]
#define docPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"/"]
#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"/"]
#define customersFilePath @"Customers.json"

#endif /* Constants_h */


