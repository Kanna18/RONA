//
//  DraftsListViewController.h
//  RONAK
//
//  Created by Gaian on 1/25/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraftsCell.h"

@interface DraftsListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *statusTableView;
- (IBAction)homeClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *headingsView;
@property (strong, nonatomic) IBOutlet UIImageView *headingLabel;

@end
