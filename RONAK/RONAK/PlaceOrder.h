//
//  Draft6.h
//  CustomAlert
//
//  Created by TTPLCOMAC1 on 28/08/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderSummaryVC.h"

@interface PlaceOrder : UIView

-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIViewController*)view;

@property (strong, nonatomic) IBOutlet UIButton *bookAnotherBrandBtn;
- (IBAction)bookAnotherBrandBtnActn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *exitBtn;
- (IBAction)exitBtnActn:(id)sender;




@end
