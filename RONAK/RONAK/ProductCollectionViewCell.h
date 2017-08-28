//
//  ProductCollectionViewCell.h
//  RONAK
//
//  Created by Gaian on 8/13/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thubImage;
@property (strong, nonatomic) IBOutlet UILabel *codeName;
@property (strong, nonatomic) IBOutlet UIView *bordrrViewColor;

@property ItemMaster *item;
-(void)bindData:(ItemMaster*)item;

@end
