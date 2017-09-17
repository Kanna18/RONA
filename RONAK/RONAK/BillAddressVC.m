//
//  ViewController.m
//  TableTask1
//
//  Created by TTPLCOMAC1 on 12/09/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import "BillAddressVC.h"
#import "BillWiseDetailsCustomCell.h"
#import "ShippingAddressViewController.h"

@interface BillAddressVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *billWiseDetailsTblVW;

@end

@implementation BillAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIden = @"Cell";
    BillWiseDetailsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BillWiseDetailsCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //[cell.recipeCelliPadFavBtn addTarget:self action:@selector(favBtnActniPad:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(IBAction)hitHomeButton:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
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

@end
