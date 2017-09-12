//
//  PassCodeViewController.m
//  RONAK
//
//  Created by Gaian on 9/12/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "PassCodeViewController.h"
#import "SignInViewController.h"

@interface PassCodeViewController ()<TOPasscodeViewControllerDelegate>

@end

@implementation PassCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    TOPasscodeViewController *passcodeViewController = [[TOPasscodeViewController alloc] initWithStyle:TOPasscodeViewStyleTranslucentDark passcodeType:TOPasscodeTypeFourDigits];
    passcodeViewController.delegate = self;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}
- (void)didTapCancelInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)passcodeViewController:(TOPasscodeViewController *)passcodeViewController isCorrectCode:(NSString *)code
{
    return [code isEqualToString:@"1234"];
    
}
- (void)didInputCorrectPasscodeInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    SignInViewController *sv=[self.storyboard instantiateViewControllerWithIdentifier:@"signInVC"];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:sv];
    [passcodeViewController presentViewController:nav animated:YES completion:nil];
}

@end
