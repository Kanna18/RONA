//
//  Discount.h
//  CalcTask
//
//  Created by Gaian on 8/28/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol DiscountResult <NSObject>

-(void)reslut:(NSString*)str;

@end


@interface Discount : UIView
- (IBAction)numBtnActn:(UIButton *)sender;
- (IBAction)okBtnActn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *myTF;
@property (nonatomic,strong)NSMutableArray *numArray;
@property id<DiscountResult> delegate;
@end
