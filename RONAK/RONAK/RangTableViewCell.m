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
    
    
    self.rangeSlider.frame=CGRectMake(50, 30, rect.size.width-90, 40);

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSlider:) name:UITextFieldTextDidChangeNotification object:_minTf];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSlider:) name:UITextFieldTextDidChangeNotification object:_maxTF];
    self.rangeSlider = [[MARKRangeSlider alloc] init];
    [self.rangeSlider addTarget:self action:@selector(rangeSliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    //    [self.rangeSlider setMinValue:1 maxValue:100];
    //    [self.rangeSlider setLeftValue:1 rightValue:20];
    //    self.rangeSlider.minimumDistance = 1;
    [self.sliderView addSubview:self.rangeSlider];
    // Configure the view for the selected state
    _minTf.delegate=self;
    _maxTF.delegate=self;
}
-(void)changeSlider:(id)sender
{
    [_rangeSlider setLeftValue:[_minTf.text floatValue] rightValue:[_maxTF.text floatValue]];
}

- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider {
    
    NSLog(@"%0.2f - %0.2f", slider.leftValue, slider.rightValue);
    _minTf.text=[NSString stringWithFormat:@"%.0f",slider.leftValue];
    _maxTF.text=[NSString stringWithFormat:@"%.0f",slider.rightValue];
    
    if([_filterType isEqualToString:kDiscount])
    {
        [ronakGlobal.selectedFilter.disCountMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.disCountMinMax setValue:_maxTF.text forKey:@"Max"];
    }
    if([_filterType isEqualToString:kWSPrice])
    {
        [ronakGlobal.selectedFilter.wsPriceMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.wsPriceMinMax setValue:_maxTF.text forKey:@"Max"];
    }
    if([_filterType isEqualToString:kMRP])
    {
        [ronakGlobal.selectedFilter.priceMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.priceMinMax setValue:_maxTF.text forKey:@"Max"];
    }
    if([_filterType isEqualToString:kStockvalue])
    {
        [ronakGlobal.selectedFilter.stockMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.stockMinMax setValue:_maxTF.text forKey:@"Max"];
    }
}


-(void)DefaultMaxMinValues
{

    if([_filterType isEqualToString:kDiscount])
    {
        NSNumber *maxNum=[ronakGlobal.discArr valueForKeyPath:@"@max.self"];
        NSNumber *minNum=[ronakGlobal.discArr valueForKeyPath:@"@min.self"];
        NSMutableDictionary *dict=ronakGlobal.selectedFilter.disCountMinMax;
        _maxLabel.text = [[NSString stringWithFormat:@"%@ ",maxNum] stringByAppendingString:@"%"];
        _minLabel.text = [[NSString stringWithFormat:@"%@ ",minNum] stringByAppendingString:@"%"];
        [self.rangeSlider setMinValue:[minNum floatValue] maxValue:[maxNum floatValue]];
        [self.rangeSlider setLeftValue:[[dict objectForKey:@"Min"] floatValue] rightValue:[[dict objectForKey:@"Max"] floatValue]];
        self.rangeSlider.minimumDistance = 1;
    
    }
    if([_filterType isEqualToString:kWSPrice])
    {
        NSNumber *maxNum=[ronakGlobal.wsPriceArr valueForKeyPath:@"@max.self"];
        NSNumber *minNum=[ronakGlobal.wsPriceArr valueForKeyPath:@"@min.self"];
        NSMutableDictionary *dict=ronakGlobal.selectedFilter.wsPriceMinMax;
        _maxLabel.text = [NSString stringWithFormat:@"%@ ₹",maxNum];
        _minLabel.text = [NSString stringWithFormat:@"%@ ₹",minNum];
        
        [self.rangeSlider setMinValue:[minNum floatValue] maxValue:[maxNum floatValue]];
        [self.rangeSlider setLeftValue:[[dict objectForKey:@"Min"] floatValue] rightValue:[[dict objectForKey:@"Max"] floatValue]];
        self.rangeSlider.minimumDistance = 1;
    }
    if([_filterType isEqualToString:kMRP])
    {
        NSNumber *maxNum=[ronakGlobal.priceArr valueForKeyPath:@"@max.self"];
        NSNumber *minNum=[ronakGlobal.priceArr valueForKeyPath:@"@min.self"];
         NSMutableDictionary *dict=ronakGlobal.selectedFilter.priceMinMax;
        _maxLabel.text = [NSString stringWithFormat:@"%@ ₹",maxNum] ;
        _minLabel.text = [NSString stringWithFormat:@"%@ ₹",minNum] ;
        
        [self.rangeSlider setMinValue:[minNum floatValue] maxValue:[maxNum floatValue]];
        [self.rangeSlider setLeftValue:[[dict objectForKey:@"Min"] floatValue] rightValue:[[dict objectForKey:@"Max"] floatValue]];
        self.rangeSlider.minimumDistance = 1;
    }
    if([_filterType isEqualToString:kStockvalue])
    {
        NSNumber *maxNum=[ronakGlobal.stockArr valueForKeyPath:@"@max.self"];
        NSNumber *minNum=[ronakGlobal.stockArr valueForKeyPath:@"@min.self"];
         NSMutableDictionary *dict=ronakGlobal.selectedFilter.stockMinMax;
        _maxLabel.text = [NSString stringWithFormat:@"%@ ",maxNum];
        _minLabel.text = [NSString stringWithFormat:@"%@ ",minNum];
        
        [self.rangeSlider setMinValue:[minNum floatValue] maxValue:[maxNum floatValue]];
        [self.rangeSlider setLeftValue:[[dict objectForKey:@"Min"] floatValue] rightValue:[[dict objectForKey:@"Max"] floatValue]];
        self.rangeSlider.minimumDistance = 1;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
