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

@end
