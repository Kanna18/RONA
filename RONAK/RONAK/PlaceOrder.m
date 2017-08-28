//
//  Draft6.m
//  CustomAlert
//
//  Created by TTPLCOMAC1 on 28/08/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import "PlaceOrder.h"
#import "MenuViewController.h"

@implementation PlaceOrder{
    
    OrderSummaryVC *orderVC;
}

-(instancetype)initWithFrame:(CGRect)frame withSuperView:(OrderSummaryVC*)viewC
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self=[[NSBundle mainBundle]loadNibNamed:@"Draft6" owner:self options:nil][0];
        frame.origin.x=frame.origin.x/2-250;
        frame.size.width=500;
        frame.size.height=100;
        frame.origin.y=frame.origin.y/2-50;
        self.frame=frame;
        orderVC=viewC;
        
    }
    
    
    return self;
}

- (IBAction)bookAnotherBrandBtnActn:(id)sender {
    
    
}
- (IBAction)exitBtnActn:(id)sender {
    
    MenuViewController *menuVC=[orderVC.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    [orderVC.navigationController popToViewController:menuVC animated:YES];
}
@end
