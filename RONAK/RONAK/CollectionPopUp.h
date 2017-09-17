//
//  Draft3.h
//  CustomAlert
//
//  Created by TTPLCOMAC1 on 28/08/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderSummaryVC.h"


@interface CollectionPopUp : UIView

-(instancetype)initWithFrame:(CGRect)frame witTitle:(NSString*)title withSuperView:(OrderSummaryVC*)supVw;


-(IBAction)noClick:(id)sender;
-(IBAction)yesClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *yesBtn;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property OrderSummaryVC *osVC;

@end
