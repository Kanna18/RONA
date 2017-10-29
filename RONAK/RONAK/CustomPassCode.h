//
//  CustomPassCode.h
//  RONAK
//
//  Created by Gaian on 10/29/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//


#import <UIKit/UIKit.h>

@class CustomPassCode;

@protocol CustomPasscodeController <NSObject>

-(void)enteredPasscode:(CustomPassCode*)passcodeController;

@end


@interface CustomPassCode : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *tf1;
@property (strong, nonatomic) IBOutlet UITextField *tf2;
@property (strong, nonatomic) IBOutlet UITextField *tf3;
@property (strong, nonatomic) IBOutlet UITextField *tf4;
@property (strong, nonatomic) IBOutlet UIView *codeView;

@property NSString *passscode;
- (IBAction)deleteClick:(id)sender;

@property id <CustomPasscodeController> delegate;
@end
