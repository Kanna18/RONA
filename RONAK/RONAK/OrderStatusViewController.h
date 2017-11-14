//
//  OrderStatusViewController.h
//  RONAK
//
//  Created by Gaian on 10/30/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderStatusCell.h"
#import "RepotrsPopTV.h"

@interface OrderStatusViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *statusTableView;

- (IBAction)homeClick:(id)sender;

@property RepotrsPopTV *reportStatus;

@property (strong, nonatomic) IBOutlet UIView *headingsView;

@end
