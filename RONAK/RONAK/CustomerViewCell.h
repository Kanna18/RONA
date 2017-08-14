//
//  CustomerViewCell.h
//  RONAK
//
//  Created by Gaian on 8/13/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet CustomButton *increment;
- (IBAction)incrementClick:(id)sender;
@property (strong, nonatomic) IBOutlet CustomButton *decrement;
;
- (IBAction)decrementClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet CustomButton *customerName;

@end
