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

@interface OrderSummaryVC : UIViewController<UITableViewDelegate,UITableViewDataSource,DiscountResult,ReloadInstruction,MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *bottomBarView;

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


- (IBAction)jumptoMenuVC:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *futureDateLabl;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet CustomLabel *customerNameLabel;



@property (strong, nonatomic) IBOutlet UIButton *placeOrderBtn;

- (IBAction)calculatorClick:(id)sender;
- (IBAction)discountClick:(id)sender;
- (IBAction)placeOrderClick:(id)sender;
- (IBAction)futureDeliveryCLick:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *totalAmount;
@property (strong, nonatomic) IBOutlet UILabel *frameGST;
@property (strong, nonatomic) IBOutlet UILabel *sunGST;
@property (strong, nonatomic) IBOutlet UILabel *roundOffLbl;
@property (strong, nonatomic) IBOutlet UILabel *netAmount;
@property (strong, nonatomic) IBOutlet UILabel *remarksLabel;

@property (strong, nonatomic) IBOutlet UIButton *remarksBtn;
-(IBAction)remarksClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *roiplBtn;
- (IBAction)roiplClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *dynamicScrollViewContentView;

@property (strong, nonatomic) IBOutlet UILabel *ropilLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cntnViewconstraint;

@property (strong, nonatomic) IBOutlet UIButton *draftBtn;
- (IBAction)draftClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *deliveryBtn;
- (IBAction)deliveryClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *cancelOrderBtn;
- (IBAction)cancelOrderClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewDynamic;
@property (strong, nonatomic) IBOutlet UIView *bottomViewonScroll;

-(IBAction)swipeToBookAnotheOrder:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *headingLabel;
@property (strong, nonatomic) IBOutlet UILabel *gstFRValueLbl;

@property (strong, nonatomic) IBOutlet UILabel *gstSGValueLbl;
@property (strong, nonatomic) IBOutlet UIView *bottomCalculationsView;
- (IBAction)dowloadPDF:(id)sender;
- (IBAction)sendEmailClick:(id)sender;
-(void)deleteDraft;
@end
