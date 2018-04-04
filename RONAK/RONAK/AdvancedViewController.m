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
#import "CollectionPopUp.h"



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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showToastForMinMaxFailed:) name:MinMaxValidationNotification object:nil];
}

-(void)showToastForMinMaxFailed:(NSNotification*)notification{
    NSString *str = notification.object;
    showMessage(str, self.view);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MinMaxValidationNotification object:nil];
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
    if(ronakGlobal.minMaxValidationBoolean){
        NSArray *arr=self.navigationController.viewControllers;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([obj isKindOfClass:[DefaultFiltersViewController class]])
            {
                [self.navigationController popToViewController:(DefaultFiltersViewController*)obj animated:YES];
                return ;
            }
        }];
    }else{
        showMessage(@"Please check Min & Max values", self.view);
    }
}
-(IBAction)rightSiwpeFunction:(id)sender
{
    if(ronakGlobal.minMaxValidationBoolean){
        if(!(ronakGlobal.selectedFilter.brand.length>0))
        {
            showMessage(@"Select Brand", self.view);
        }
        else if(!(ronakGlobal.selectedFilter.categories.count>0))
        {
            showMessage(@"Select Category", self.view);
        }
        else if (!(ronakGlobal.selectedFilter.collection.count>0))
        {
            CollectionPopUp *colP=[[CollectionPopUp alloc]initWithFrame:CGRectMake(0, 0, 100, 200)];
            colP.center=self.view.center;
            [colP.yesBtn addTarget:self action:@selector(moveToOrderBooking) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:colP];
        }
        else
        {
            ProductsListController *pro=storyBoard(@"productsVC");
            [self.navigationController pushViewController:pro animated:YES];
        }
    }else{
        showMessage(@"Please check Min & Max values", self.view);
    }
}
-(void)moveToOrderBooking
{
    if(ronakGlobal.minMaxValidationBoolean){
        ProductsListController *pro=storyBoard(@"productsVC");
        [self.navigationController pushViewController:pro animated:YES];
    }else{
        showMessage(@"Please check Min & Max values", self.view);
    }
}
- (IBAction)jumpMenuFunction:(id)sender
{
    if(ronakGlobal.minMaxValidationBoolean){
        NSArray *arr=self.navigationController.viewControllers;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([obj isKindOfClass:[MenuViewController class]])
            {
                [self.navigationController popToViewController:(MenuViewController*)obj animated:YES];
                return ;
            }
        }];
    }else{
        showMessage(@"Please check Min & Max values", self.view);
    }
}


@end
