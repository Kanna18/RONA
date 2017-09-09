//
//  AdvancedViewController.h
//  RONAK
//
//  Created by Gaian on 9/1/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvancedViewController : UIViewController

@property IBOutlet UISwipeGestureRecognizer *leftSwipe;
@property IBOutlet UISwipeGestureRecognizer *rightSwipe;
-(IBAction)leftSiwpeFunction:(id)sender;
-(IBAction)rightSiwpeFunction:(id)sender;
- (IBAction)jumpMenuFunction:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *headingLabel;
@end
