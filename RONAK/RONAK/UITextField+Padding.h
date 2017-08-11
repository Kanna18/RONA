//
//  UITextField+Padding.h
//  INCOIS
//
//  Created by Gaian on 7/6/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Padding)

-(void)setPadding;
-(void)setRightPadding;

-(BOOL)hasValidEmail;
-(BOOL)hasValidPhoneNumber;
-(BOOL)hasValidText;
-(BOOL)hasValidPassword;



@end
