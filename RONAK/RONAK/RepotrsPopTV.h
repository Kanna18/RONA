//
//  RepotrsPopTV.h
//  RONAK
//
//  Created by Gaian on 11/4/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderStatsResponse.h"

@interface RepotrsPopTV : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
-(void)bindData:(OrderStatusCustomResponse*)resp;
@end
