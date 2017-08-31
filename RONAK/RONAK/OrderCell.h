//
//  OrderCell.h
//  RONAK
//
//  Created by Gaian on 8/25/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReloadInstruction <NSObject>

-(void)quantityChangedforCustomer:(CustomButton*)cst;

@end

@interface OrderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImage;
- (IBAction)deleteProduct:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *brandLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) IBOutlet UIButton *incrementPro;
@property (strong, nonatomic) IBOutlet UIButton *decrementPro;
@property (strong, nonatomic) IBOutlet UILabel *qtyLabel;
- (IBAction)qtyFunction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *discountLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;

@property ItemMaster *item;
@property CustomerDataModel *cstData;
@property CustomButton *cstButtomCustomer;

@property int count;
-(void)bindData:(ItemMaster *)item withCount:(int)Count customerData:(CustomerDataModel*)cst forCustome:(CustomButton*)btn;

@property id<ReloadInstruction> delegate;
@end
