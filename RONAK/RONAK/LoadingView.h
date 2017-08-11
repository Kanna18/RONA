//
//  LoadingView.h
//  INCOIS
//
//  Created by Gaian on 2/2/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIActivityIndicatorView

//-(instancetype)initWithView:(UIView*)view with_message:(NSString*)text;

-(void)WithView:(UIView*)view with_message:(NSString*)text;
-(void)loadingWithlightAlpha:(UIView*)view with_message:(NSString*)text;

-(void)waringLabelText:(NSString*)msg onView:(UIView*)view;

@property (nonatomic,strong) NSString *messageText;
-(void)start;
-(void)stop;
@end
