//
//  RangTableViewCell.m
//  RONAK
//
//  Created by Gaian on 8/29/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "RangTableViewCell.h"

@implementation RangTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rangeSlider = [[MARKRangeSlider alloc] init];
    self.rangeSlider.hidden=YES;
    [self.rangeSlider addTarget:self
                         action:@selector(rangeSliderValueDidChange:)
               forControlEvents:UIControlEventValueChanged];
    [self.rangeSlider setMinValue:1 maxValue:100];
    [self.rangeSlider setLeftValue:1 rightValue:20];
    self.rangeSlider.minimumDistance = 20;
    [self.contentView addSubview:self.rangeSlider];
    self.rangeSlider.leftThumbView.backgroundColor=GrayLight;
    self.rangeSlider.rightThumbView.backgroundColor=GrayLight;
    // Configure the view for the selected state
    
    _minTf.delegate=self;
    _maxTF.delegate=self;
    
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


- (IBAction)headerbuttonClick:(id)sender {
    
    UIButton *btn=sender;
    self.rangeSlider.frame=CGRectMake(50, 80, btn.frame.size.width-50, 60);
    if(btn.selected==YES)
    {
        btn.selected=NO;
        [btn setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateNormal];
        
        [UIView transitionWithView:self.contentView duration:0.8 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
            _rangeSlider.hidden=YES;
        } completion:nil];
        
        
    }
    else{
        btn.selected=YES;
        [btn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
        [UIView transitionWithView:self.contentView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
            _rangeSlider.hidden=NO;
        } completion:nil];
    }
    [_delegate getStatus:sender cell:self];
}
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}


-(void)bindDatatoGetFrame
{
    _headerButton.imageEdgeInsets=UIEdgeInsetsMake(0, _headerButton.frame.size.width/3, 0, 0);
}
@end
