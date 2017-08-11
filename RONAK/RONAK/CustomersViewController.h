//
//  CustomersViewController.h
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerCell.h"
#import "HeaderReusableView.h"
#import "CustomerDataModel.h"

@interface CustomersViewController : UIViewController

@property (weak, nonatomic) IBOutlet CustomButton *menuButton;
- (IBAction)menubuttonClick:(id)sender;

@property (weak, nonatomic) IBOutlet CustomTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)backButton:(id)sender;
- (IBAction)addCustomer:(id)sender;
- (IBAction)appointments:(id)sender;
- (IBAction)gemMarketing:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *addCustomerBtn;
@property (strong, nonatomic) IBOutlet UIButton *appointmentsBtn;
@property (strong, nonatomic) IBOutlet UIButton *geomarketingBtn;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView_selCustmr;


@end
