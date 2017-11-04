//
//  ReportsStatusCell.h
//  RONAK
//
//  Created by Gaian on 11/4/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderStatsResponse.h"

@interface ReportsStatusCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *statusCell;
@property (strong, nonatomic) IBOutlet UILabel *dateCell;
@property (strong, nonatomic) IBOutlet UILabel *daysLbl;
@property (strong, nonatomic) IBOutlet UILabel *detailsLbl;

-(void)bindData:(OrderStatsResponse*)resp;

@end
