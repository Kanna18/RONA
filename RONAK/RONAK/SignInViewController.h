//
//  SignInViewController.h
//  RONAK
//
//  Created by Gaian on 7/14/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <TOPasscodeViewController/TOPasscodeViewController.h>
#import <UIKit/UIKit.h>
#import <SalesforceSDKCore/SalesforceSDKCore.h>
#import <AFNetworking/AFNetworking.h>
#import "MenuViewController.h"

#import "UnzipViewController.h"


@interface SignInViewController : UIViewController<SFRestDelegate>

@property (strong, nonatomic) IBOutlet CustomTextField *emailTf;
@property (strong, nonatomic) IBOutlet CustomTextField *passwordTF;

@property (strong, nonatomic) IBOutlet CustomButton *remembermeBtn;
- (IBAction)rememberMeClick:(id)sender;

@property (strong, nonatomic) IBOutlet CustomButton *loginBtn;
- (IBAction)loginClick:(id)sender;

@property (strong, nonatomic) IBOutlet CustomButton *forgtPwdBtn;
- (IBAction)forgtPasswordClick:(id)sender;

@end
