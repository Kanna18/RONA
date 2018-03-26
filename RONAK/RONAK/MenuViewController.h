//
//  MenuViewController.h
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController


@property (weak, nonatomic) IBOutlet CustomButton *bookOrder;
@property (weak, nonatomic) IBOutlet CustomButton *reports;
@property (weak, nonatomic) IBOutlet CustomButton *activity;
@property (weak, nonatomic) IBOutlet CustomButton *logout;


- (IBAction)bookOrder_click:(id)sender;
- (IBAction)reports_click:(id)sender;
- (IBAction)activity_click:(id)sender;
- (IBAction)logout_click:(id)sender;
- (IBAction)multimedia_click:(id)sender;
- (IBAction)settings_click:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *downloadStatus;
@property (strong, nonatomic) IBOutlet UILabel *downloadStockDetails;
@property (strong, nonatomic) IBOutlet UILabel *imagesDownload;
@property (strong, nonatomic) IBOutlet UIView *ProgressView;
@property (strong, nonatomic) IBOutlet UILabel *matchingLabel;
@property (weak, nonatomic) IBOutlet UILabel *internetStatusLbl;

@end
