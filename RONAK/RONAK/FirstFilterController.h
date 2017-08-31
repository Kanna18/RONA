//
//  FirstFilterController.h
//  RONAK
//
//  Created by Gaian on 8/11/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTVCell.h"



@interface FirstFilterController : UIViewController<UITableViewDelegate,UITableViewDataSource,HideUnhideStatus,UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>

@property (strong, nonatomic) IBOutlet UITableView *filterTable;

@end
