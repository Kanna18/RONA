//
//  OrderStatusCell.h
//  RONAK
//
//  Created by Gaian on 10/30/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderStatsResponse.h"

@class OrderStatusViewController;


@interface OrderStatusCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *sfID;

@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *brandLabel;

@property (strong, nonatomic) IBOutlet UILabel *qtyLabel;
@property (strong, nonatomic) IBOutlet UILabel *discLabel;

@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UIButton *statusBtn;
- (IBAction)statusClick:(id)sender;
-(void)bindData:(OrderStatsResponse*)resp superViewCon:(OrderStatusViewController*)superVc;

@end
