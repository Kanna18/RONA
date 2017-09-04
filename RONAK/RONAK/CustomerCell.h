//
//  CustomerCell.h
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerDataModel.h"

@interface CustomerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet CustomLabel *nameLabel;
@property (weak, nonatomic) IBOutlet CustomLabel *addressLabel;
@property (weak, nonatomic) IBOutlet CustomLabel *amountLabel;
@property (nonatomic) CustomerDetails *cstData;

-(void)bindData:(CustomerDetails*)data;
-(void)loadSelectedCustomerFromArrat:(NSMutableArray*)arr;
-(void)saveSelectedCustomertoArray:(NSMutableArray*)arr;



@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (strong, nonatomic) IBOutlet UIImageView *selectedImage;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *trailingContraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *borderTrailing;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *borderLeading;

@end
