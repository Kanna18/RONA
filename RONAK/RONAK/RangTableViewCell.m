//
//  RangTableViewCell.m
//  RONAK
//
//  Created by Gaian on 8/29/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "RangTableViewCell.h"

@implementation RangTableViewCell

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Enter Custom Code
    self.rangeSlider = [[MARKRangeSlider alloc] initWithFrame:CGRectMake(70, 30, rect.size.width-70, 40)];
    [self.rangeSlider addTarget:self action:@selector(rangeSliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.rangeSlider setMinValue:1 maxValue:100];
    [self.rangeSlider setLeftValue:1 rightValue:20];
    self.rangeSlider.minimumDistance = 20;
    [self.sliderView addSubview:self.rangeSlider];
    // Configure the view for the selected state
    
    _minTf.delegate=self;
    _maxTF.delegate=self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSlider:) name:UITextFieldTextDidChangeNotification object:_minTf];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSlider:) name:UITextFieldTextDidChangeNotification object:_maxTF];
}
-(void)changeSlider:(id)sender
{
    [_rangeSlider setLeftValue:[_minTf.text floatValue] rightValue:[_maxTF.text floatValue]];
}

- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider {
    NSLog(@"%0.2f - %0.2f", slider.leftValue, slider.rightValue);
    _minTf.text=[NSString stringWithFormat:@"%.0f",slider.leftValue];
    _maxTF.text=[NSString stringWithFormat:@"%.0f",slider.rightValue];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
