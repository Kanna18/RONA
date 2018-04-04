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
#import "CollectionPopUp.h"


@interface DefaultFiltersViewController ()

@end

@implementation DefaultFiltersViewController{
    LoadingView *load;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _leftSwipe.numberOfTouchesRequired=noOfTouches;
    _rightSwipe.numberOfTouchesRequired=noOfTouches;
    
    _leftSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    _rightSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    
    UITapGestureRecognizer *taped=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumptoMenuVC:)];
    taped.numberOfTouchesRequired=1;
    [_headingLabel addGestureRecognizer:taped];
    
    if(!(ronakGlobal.DefFiltersOne.count>0)){
        load=[[LoadingView alloc]init];
        [load loadingWithlightAlpha:self.view with_message:@"Loading Filters"];
        [load start];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filtersQueryFetchedBy) name:filtersQueryFetched object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showToastForMinMaxFailed:) name:MinMaxValidationNotification object:nil];
}
-(void)showToastForMinMaxFailed:(NSNotification*)notification{
    NSString *str = notification.object;
    showMessage(str, self.view);
}

-(void)filtersQueryFetchedBy{
    if(load){
        [load performSelectorOnMainThread:@selector(stop) withObject:nil waitUntilDone:YES];
    }
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
- (IBAction)jumptoMenuVC:(id)sender
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

- (IBAction)leftSwipeFunction:(id)sender {

    if(ronakGlobal.minMaxValidationBoolean){
        NSArray *arr=self.navigationController.viewControllers;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if([obj isKindOfClass:[ShippingAddressViewController class]])
            {
                [self.navigationController popToViewController:(ShippingAddressViewController*)obj animated:YES];
                return ;
            }
        }];
    }else{
        showMessage(@"Please check Min & Max values", self.view);
    }
}
- (IBAction)rightSwipeFunction:(id)sender {

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
     if(ronakGlobal.minMaxValidationBoolean){
         //    if(ronakGlobal.selectedFilter.brand.length>0)
         //    {
         AdvancedViewController *pro=storyBoard(@"advancedVC");
         [self.navigationController pushViewController:pro animated:YES];
         //    }
         //    else
         //    {
         //        showMessage(@"Select Brand", self.view);
         //    }
     }else{
         showMessage(@"Please check Min & Max values", self.view);
     }    
}



@end
