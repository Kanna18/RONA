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


@interface ProductsListController : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *customersCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *pSymbol;
@property (strong, nonatomic) IBOutlet CustomButton *saleBtn;
@property (strong, nonatomic) IBOutlet CustomButton *allColoursBtn;
@property (strong, nonatomic) IBOutlet UIButton *searchEveryWhereOptn;

- (IBAction)searchEveryWhereClick:(id)sender;
- (IBAction)dismissViewController:(id)sender;


-(IBAction)listImagesArray:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *detailedImageView;

@property (strong, nonatomic) IBOutlet UIView *discountVw;
@property (strong, nonatomic) IBOutlet UILabel *discountLbl;
@end
