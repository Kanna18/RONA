//
//  RemarksView.h
//  RONAK
//
//  Created by Gaian on 9/17/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "OrderSummaryVC.h"

@interface RemarksView : UIView

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString*)str withSuperView:(OrderSummaryVC*)superVC;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property OrderSummaryVC *superView;
- (IBAction)cancelClick:(id)sender;
- (IBAction)checkClick:(id)sender;


@end
