//
//  PDCViewController.h
//  RONAK
//
//  Created by Gaian on 8/16/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDCViewController : UIViewController
@property (strong, nonatomic) IBOutlet CustomLabel *customerNmLbl;
@property (strong, nonatomic) IBOutlet UITableView *listTableView;
- (IBAction)backClick:(id)sender;
- (IBAction)homeClick:(id)sender;
- (IBAction)jumptoMenuVC:(id)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGest;

@property CustomerDataModel *cst;
@end
