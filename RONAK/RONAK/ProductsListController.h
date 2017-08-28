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
#import "CustomTVCell.h"

@interface ProductsListController : UIViewController<CustomerDeleted,UITableViewDelegate,UITableViewDataSource,HideUnhideStatus>

@property (strong, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *customersCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *pSymbol;
@property (strong, nonatomic) IBOutlet CustomButton *saleBtn;
@property (strong, nonatomic) IBOutlet CustomButton *allColoursBtn;
@property (strong, nonatomic) IBOutlet UIButton *searchEveryWhereOptn;

- (IBAction)searchEveryWhereClick:(id)sender;
- (IBAction)backButton:(id)sender;
- (IBAction)jumptoMenuVC:(id)sender;



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
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITableView *filterTable;

@end
