//
//  ProductsListController.h
//  RONAK
//
//  Created by Gaian on 8/12/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCollectionViewCell.h"
#import "CustomerViewCell.h"
#import <SevenSwitch/SevenSwitch-Swift.h>





@interface ProductsListController : UIViewController<CustomerDeleted,CalculatorDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *customersCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *pSymbol;
@property (strong, nonatomic) IBOutlet CustomButton *saleBtn;
@property (strong, nonatomic) IBOutlet CustomButton *allColoursBtn;
@property (strong, nonatomic) IBOutlet UIButton *searchEveryWhereOptn;

- (IBAction)searchEveryWhereClick:(id)sender;
- (IBAction)backButton:(id)sender;
- (IBAction)jumptoMenuVC:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *allModelsTopBtn;

@property (strong, nonatomic) IBOutlet UIButton *allColorsTopBtn;

-(IBAction)listImagesArray:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *detailedImageView;

@property (strong, nonatomic) IBOutlet UIView *discountVw;


@property (strong, nonatomic) IBOutlet CustomSwitch *pricingSwitch;
@property (strong, nonatomic) IBOutlet UILabel *pricingLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemModelNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *discountLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *selectedItemDesc;

@property ItemMaster *currentItem;

//SideMenu
@property (strong, nonatomic) IBOutlet UIButton *sideMenuButton;

@property (strong, nonatomic) IBOutlet UIView *sideView;
- (IBAction)sideMenuClick:(id)sender;
-(IBAction)closeSideMenuFilters;
@property (strong, nonatomic) IBOutlet UIView *containerView;
- (IBAction)clearCartClick:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *wsLabel;;
- (IBAction)priceSwitchChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *productDetailView;
- (IBAction)allmodelTopClick:(id)sender;
- (IBAction)allColorsTopClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cartOption;
@property (strong, nonatomic) IBOutlet UIButton *sortOption;
@property (strong, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) IBOutlet UIImageView *ronakheadingLabel;
- (IBAction)cancelOrderClick:(id)sender;
- (IBAction)calculatorClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelOrderBtn;

@property (strong, nonatomic) IBOutlet UIButton *calculatorBtn;

@property (strong, nonatomic) IBOutlet UILabel *displayLable;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeUp;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeDown;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *tripleSwipeUp;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *tripleSwipeDown;

@property (strong, nonatomic) IBOutlet SevenSwitch *switchPr;
- (IBAction)priceWithRupeeSymbolClick:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *calcTextField;
@end
