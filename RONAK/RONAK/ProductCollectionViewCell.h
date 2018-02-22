//
//  ProductCollectionViewCell.h
//  RONAK
//
//  Created by Gaian on 8/13/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCollectionViewCell.h"
@protocol GestureProtocol
-(void)showStockCountofProduct:(ItemMaster *)st superView:(id)cell;
@end

@interface ProductCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thubImage;
@property (strong, nonatomic) IBOutlet UILabel *codeName;
@property (strong, nonatomic) IBOutlet UIView *bordrrViewColor;
@property id<GestureProtocol> delegate;

@property ItemMaster *item;
-(void)bindData:(ItemMaster*)item;

@end
