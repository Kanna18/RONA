//
//  AdvancedViewController.m
//  RONAK
//
//  Created by Gaian on 9/1/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "AdvancedViewController.h"
#import "DefaultFiltersViewController.h"
#import "ProductsListController.h"


@interface AdvancedViewController ()

@end

@implementation AdvancedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _leftSwipe.numberOfTouchesRequired=noOfTouches;
    _leftSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    
    _rightSwipe.numberOfTouchesRequired=noOfTouches;
    _rightSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    
    UITapGestureRecognizer *taped=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpMenuFunction:)];
    taped.numberOfTouchesRequired=1;
    [_headingLabel addGestureRecognizer:taped];
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
-(IBAction)leftSiwpeFunction:(id)sender
{
    NSArray *arr=self.navigationController.viewControllers;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[DefaultFiltersViewController class]])
        {
            [self.navigationController popToViewController:(DefaultFiltersViewController*)obj animated:YES];
            return ;
        }
    }];
    
}
-(IBAction)rightSiwpeFunction:(id)sender
{

    if(ronakGlobal.selectedFilter.brand.length>0)
    {
        ProductsListController *pro=storyBoard(@"productsVC");
        [self.navigationController pushViewController:pro animated:YES];
    }
    else
    {
        showMessage(@"Select Brand", self.view);
    }
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


@end
