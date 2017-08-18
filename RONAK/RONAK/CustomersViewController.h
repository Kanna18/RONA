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

@interface CustomersViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet CustomTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)backButton:(id)sender;
- (IBAction)addCustomer:(id)sender;
- (IBAction)gemMarketing:(id)sender;




@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *addCustomerBtn;
@property (strong, nonatomic) IBOutlet UIButton *geomarketingBtn;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView_selCustmr;

@property (strong, nonatomic) IBOutlet UIScrollView *aplhabetsIndexScroll;

@end
