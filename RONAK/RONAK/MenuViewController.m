//
//  MenuViewController.m
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self defaultComponentsStyle];
  
}
-(void)viewWillAppear:(BOOL)animate
{
    [super viewWillAppear:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    for (CustomButton *cst in self.view.subviews)
    {
        if([cst isKindOfClass:[CustomButton class]])
        {
            cst.frame=CGRectMake(100, 100, 30, 30);
        }
    }
    [UIView commitAnimations];
}

-(void)defaultComponentsStyle
{
    [_activity setBackgroundImage:[UIImage imageNamed:@"BtnHilighted"] forState:UIControlStateHighlighted];
    [_bookOrder setBackgroundImage:[UIImage imageNamed:@"BtnHilighted"] forState:UIControlStateHighlighted];
    [_reports setBackgroundImage:[UIImage imageNamed:@"BtnHilighted"] forState:UIControlStateHighlighted];
    [_logout setBackgroundImage:[UIImage imageNamed:@"BtnHilighted"] forState:UIControlStateHighlighted];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)bookOrder_click:(id)sender {
}

- (IBAction)reports_click:(id)sender {
}

- (IBAction)activity_click:(id)sender {
}

- (IBAction)logout_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
