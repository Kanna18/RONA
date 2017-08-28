//
//  OrderSummaryVC.h
//  RONAK
//
//  Created by Gaian on 8/25/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCell.h"
#import "PlaceOrder.h"


@interface OrderSummaryVC : UIViewController<UITableViewDelegate,UITableViewDataSource,DiscountResult,ReloadInstruction>

@property (strong, nonatomic) IBOutlet UITableView *summaryTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView_Cmlist;

@property CustomerDataModel *cstdDataModel;
@property CustomButton *presentCustomerBtn;

@property (strong, nonatomic) IBOutlet UIButton *discountBtn;
@property (strong, nonatomic) IBOutlet UIButton *calculator;
@property (strong, nonatomic) IBOutlet UIButton *futureDelivery;

@property NSCountedSet *itemsCount;
@property NSSet *items;
@property NSArray *itemsArray;

- (IBAction)calculatorClick:(id)sender;
- (IBAction)discountClick:(id)sender;
- (IBAction)jumptoMenuVC:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *futureDateLabl;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *customerNameLabel;

- (IBAction)futureDeliveryCLick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *placeOrderBtn;
- (IBAction)placeOrderClick:(id)sender;


@end
