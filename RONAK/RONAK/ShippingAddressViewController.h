//
//  ShippingAddressViewController.h
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShippingAddressViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView_Cmlist;
@property (strong, nonatomic) IBOutlet UIScrollView *billAddress_scrlView;
@property (strong, nonatomic) IBOutlet UIScrollView *shipAddress_scrlView;

@property (strong, nonatomic) IBOutlet IPInsetLabel *statusLbl;
@property (strong, nonatomic) IBOutlet IPInsetLabel *creditLimitLbl;
@property (strong, nonatomic) IBOutlet IPInsetLabel *acntBalanceLbl;
@property (strong, nonatomic) IBOutlet IPInsetLabel *pdcLbl;

@property (strong, nonatomic) IBOutlet CustomLabel *Lbl90;
@property (strong, nonatomic) IBOutlet CustomLabel *lbl150;
@property (strong, nonatomic) IBOutlet CustomLabel *lbl180;
@property (strong, nonatomic) IBOutlet CustomLabel *lbl360;
@property (strong, nonatomic) IBOutlet CustomLabel *lbl360Above;
@property (strong, nonatomic) IBOutlet CustomLabel *lblTotal;
@property (strong, nonatomic) IBOutlet UILabel *shipToHeading;

@property (strong, nonatomic) IBOutlet UIImageView *headingLabel;

@property (strong, nonatomic) IBOutlet CustomLabel *customerNamelbl;
@property (strong, nonatomic) IBOutlet UILabel *headingBarLabel;

@property CustomerDataModel *cst;
@property (strong, nonatomic) IBOutlet UILabel *billtoHeading;

- (IBAction)backClick:(id)sender;
- (IBAction)jumptoMenuVC:(id)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipe;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipe;
- (IBAction)pushSwipe:(id)sender;

@end
