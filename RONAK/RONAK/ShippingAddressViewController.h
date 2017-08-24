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

@property (strong, nonatomic) IBOutlet CustomLabel *statusLbl;
@property (strong, nonatomic) IBOutlet CustomLabel *creditLimitLbl;
@property (strong, nonatomic) IBOutlet CustomLabel *acntBalanceLbl;
@property (strong, nonatomic) IBOutlet CustomLabel *pdcLbl;

@property (strong, nonatomic) IBOutlet CustomLabel *Lbl90;
@property (strong, nonatomic) IBOutlet CustomLabel *lbl150;
@property (strong, nonatomic) IBOutlet CustomLabel *lbl180;
@property (strong, nonatomic) IBOutlet CustomLabel *lbl360;
@property (strong, nonatomic) IBOutlet CustomLabel *lbl360Above;
@property (strong, nonatomic) IBOutlet CustomLabel *lblTotal;


@property (strong, nonatomic) IBOutlet CustomLabel *customerNamelbl;

@property CustomerDataModel *cst;

- (IBAction)backClick:(id)sender;

@end
