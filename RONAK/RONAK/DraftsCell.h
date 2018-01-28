//
//  DraftsCell.h
//  RONAK
//
//  Created by Gaian on 1/25/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DraftsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *sfIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *cstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *brandLabel;
@property (strong, nonatomic) IBOutlet UILabel *quantityLabel;
@property (strong, nonatomic) IBOutlet UILabel *discountLabel;
@property (strong, nonatomic) IBOutlet UIButton *amountLabel;
@property DraftsDataModel *singleDraft;
-(void)bindData:(DraftsDataModel*)drft;
@end
