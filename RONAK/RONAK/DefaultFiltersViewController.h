//
//  DefaultFiltersViewController.h
//  RONAK
//
//  Created by Gaian on 9/1/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultFiltersViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipe;
- (IBAction)leftSwipeFunction:(id)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipe;
- (IBAction)rightSwipeFunction:(id)sender;
- (IBAction)jumpMenuFunction:(id)sender;
- (IBAction)advancedFiltersFunction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *headingLabel;
@property (strong, nonatomic) IBOutlet UIButton *filterOptionBtn;

@end
