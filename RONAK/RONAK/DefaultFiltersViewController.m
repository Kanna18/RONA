//
//  DefaultFiltersViewController.m
//  RONAK
//
//  Created by Gaian on 9/1/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "DefaultFiltersViewController.h"
#import "ShippingAddressViewController.h"
#import "ProductsListController.h"
#import "AdvancedViewController.h"

@interface DefaultFiltersViewController ()

@end

@implementation DefaultFiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _leftSwipe.numberOfTouchesRequired=noOfTouches;
    _rightSwipe.numberOfTouchesRequired=noOfTouches;
    
    _leftSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    _rightSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
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
- (IBAction)jumptoMenuVC:(id)sender
{
    
    NSArray *arr=self.navigationController.viewControllers;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[MenuViewController class]])
        {
            [self.navigationController popToViewController:(MenuViewController*)obj animated:YES];
            return ;
        }
    }];
}

- (IBAction)leftSwipeFunction:(id)sender {

    NSArray *arr=self.navigationController.viewControllers;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[ShippingAddressViewController class]])
        {
            [self.navigationController popToViewController:(ShippingAddressViewController*)obj animated:YES];
            return ;
        }
    }];
}
- (IBAction)rightSwipeFunction:(id)sender {

    ProductsListController *pro=storyBoard(@"productsVC");
    [self.navigationController pushViewController:pro animated:YES];
}
- (IBAction)jumpMenuFunction:(id)sender
{
    
    NSArray *arr=self.navigationController.viewControllers;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[MenuViewController class]])
        {
            [self.navigationController popToViewController:(MenuViewController*)obj animated:YES];
            return ;
        }
    }];
}
- (IBAction)advancedFiltersFunction:(id)sender
{
    AdvancedViewController *pro=storyBoard(@"advancedVC");
    [self.navigationController pushViewController:pro animated:YES];

}



@end
