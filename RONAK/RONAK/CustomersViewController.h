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
#import "ShippingAddressViewController.h"

@interface CustomersViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet CustomTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)backButton:(id)sender;
- (IBAction)jumptoMenuVC:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView_selCustmr;
@property (strong, nonatomic) IBOutlet UIScrollView *aplhabetsIndexScroll;

@property(nonatomic, assign) BOOL automaticallyAdjustsScrollViewInsets;



@end
