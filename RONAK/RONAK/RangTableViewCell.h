//
//  RangTableViewCell.h
//  RONAK
//
//  Created by Gaian on 8/29/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterRange <NSObject>

-(void)getStatus:(UIButton*)sender cell:(UITableViewCell*)cell;

@end

@interface RangTableViewCell : UITableViewCell<UITextFieldDelegate>
@property MARKRangeSlider *rangeSlider;
@property (strong, nonatomic) IBOutlet UITextField *minTf;
@property (strong, nonatomic) IBOutlet UITextField *maxTF;

@property NSString *filterType;
@property id<FilterRange>delegate;
@property (strong, nonatomic) IBOutlet UIView *sliderView;

-(void)bindDatatoGetFrame;
@end
