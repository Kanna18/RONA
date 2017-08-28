//
//  AdvancedSecondFilter.h
//  RONAK
//
//  Created by Gaian on 8/25/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTVCell.h"

@interface AdvancedSecondFilter : UIViewController<UITableViewDelegate,UITableViewDataSource,HideUnhideStatus>

@property (strong, nonatomic) IBOutlet UITableView *filterTable;

@end
