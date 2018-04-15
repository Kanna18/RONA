//
//  RangTableViewCell.m
//  RONAK
//
//  Created by Gaian on 8/29/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#define NUMBERS_ONLY @"1234567890"


#import "RangTableViewCell.h"

@implementation RangTableViewCell

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Enter Custom Code
    
    
    self.rangeSlider.frame=CGRectMake(50, 30, rect.size.width-90, 40);
    self.rangeSlider.leftThumbImage=[UIImage imageNamed:@"pause"];
    self.rangeSlider.rightThumbImage=[UIImage imageNamed:@"pause"];
    self.rangeSlider.trackImage=[UIImage imageNamed:@"blueBG"];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSlider:) name:UITextFieldTextDidChangeNotification object:_minTf];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSlider:) name:UITextFieldTextDidChangeNotification object:_maxTF];
    self.rangeSlider = [[MARKRangeSlider alloc] init];
    [self.rangeSlider addTarget:self action:@selector(rangeSliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
        [self.rangeSlider setMinValue:0 maxValue:100];
        [self.rangeSlider setLeftValue:0 rightValue:20];
        self.rangeSlider.minimumDistance = 1;
    [self.sliderView addSubview:self.rangeSlider];
    // Configure the view for the selected state
    _minTf.delegate=self;
    _maxTF.delegate=self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rangeSliderValueDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    if(!(_minTf.text.length>0)){
        _minTf.text=@"0";
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minMaxValidation) name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)changeSlider:(id)sender
{
    [_rangeSlider setLeftValue:[_minTf.text floatValue] rightValue:[_maxTF.text floatValue]];
}

- (void)rangeSliderValueDidChange:(id)slider {
    
    if([slider isKindOfClass:[MARKRangeSlider class]])
    {
        MARKRangeSlider *sli=slider;
        NSLog(@"%0.2f - %0.2f", sli.leftValue, sli.rightValue);
        _minTf.text=[NSString stringWithFormat:@"%.0f",sli.leftValue];
        _maxTF.text=[NSString stringWithFormat:@"%.0f",sli.rightValue];
    }
    
    if([_filterType isEqualToString:kDiscount])
    {
        [ronakGlobal.selectedFilter.disCountMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.disCountMinMax setValue:_maxTF.text forKey:@"Max"];
        return;
    }
    if([_filterType isEqualToString:kWSPrice])
    {
        [ronakGlobal.selectedFilter.wsPriceMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.wsPriceMinMax setValue:_maxTF.text forKey:@"Max"];
        return;
    }
    if([_filterType isEqualToString:kMRP])
    {
        [ronakGlobal.selectedFilter.priceMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.priceMinMax setValue:_maxTF.text forKey:@"Max"];
        return;
    }
    if([_filterType isEqualToString:kStockvalue])
    {
        [ronakGlobal.selectedFilter.stockMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.stockMinMax setValue:_maxTF.text forKey:@"Max"];
        return;
    }
}
-(void)DefaultMaxMinValues
{    
    SelectedFilters *sel=ronakGlobal.selectedFilter;
    NSLog(@"%@",sel);
    _minTf.keyboardType=UIKeyboardTypePhonePad;
    _maxTF.keyboardType=UIKeyboardTypePhonePad;
    if([_filterType isEqualToString:kDiscount])
    {
//        NSNumber *maxNum=[ronakGlobal.discArr valueForKeyPath:@"@max.self"];
//        NSNumber *minNum=[ronakGlobal.discArr valueForKeyPath:@"@min.self"];
//        NSMutableDictionary *dict=ronakGlobal.selectedFilter.disCountMinMax;
//        _maxLabel.text = [[NSString stringWithFormat:@"%@ ",maxNum] stringByAppendingString:@"%"];
//        _minLabel.text = [[NSString stringWithFormat:@"%@ ",minNum] stringByAppendingString:@"%"];
//        [self.rangeSlider setMinValue:[minNum floatValue] maxValue:[maxNum floatValue]];
//        [self.rangeSlider setLeftValue:[[dict objectForKey:@"Min"] floatValue] rightValue:[[dict objectForKey:@"Max"] floatValue]];
//        self.rangeSlider.minimumDistance = 1;
        _minTf.text=ronakGlobal.selectedFilter.disCountMinMax[@"Min"];
        _maxTF.text=ronakGlobal.selectedFilter.disCountMinMax[@"Max"];
        [self.rangeSlider setLeftValue:[ronakGlobal.selectedFilter.disCountMinMax[@"Min"] floatValue] rightValue:[ronakGlobal.selectedFilter.disCountMinMax[@"Max"] floatValue]];
        
        return;
    }
    if([_filterType isEqualToString:kWSPrice])
    {
//        NSNumber *maxNum=[ronakGlobal.wsPriceArr valueForKeyPath:@"@max.self"];
//        NSNumber *minNum=[ronakGlobal.wsPriceArr valueForKeyPath:@"@min.self"];
//        NSMutableDictionary *dict=ronakGlobal.selectedFilter.wsPriceMinMax;
//        _maxLabel.text = [NSString stringWithFormat:@"%@ ₹",maxNum];
//        _minLabel.text = [NSString stringWithFormat:@"%@ ₹",minNum];
//        
//        [self.rangeSlider setMinValue:[minNum floatValue] maxValue:[maxNum floatValue]];
//        [self.rangeSlider setLeftValue:[[dict objectForKey:@"Min"] floatValue] rightValue:[[dict objectForKey:@"Max"] floatValue]];
//        self.rangeSlider.minimumDistance = 1;
        _maxTF.text = ronakGlobal.selectedFilter.wsPriceMinMax[@"Max"];
        _minTf.text = ronakGlobal.selectedFilter.wsPriceMinMax[@"Min"];
//        _minLabel.hidden=YES;
//        _maxLabel.hidden=YES;
        return;
    }
    if([_filterType isEqualToString:kMRP])
    {
//        NSNumber *maxNum=[ronakGlobal.priceArr valueForKeyPath:@"@max.self"];
//        NSNumber *minNum=[ronakGlobal.priceArr valueForKeyPath:@"@min.self"];
//         NSMutableDictionary *dict=ronakGlobal.selectedFilter.priceMinMax;
//        _maxLabel.text = [NSString stringWithFormat:@"%@ ₹",maxNum] ;
//        _minLabel.text = [NSString stringWithFormat:@"%@ ₹",minNum] ;
//        
//        [self.rangeSlider setMinValue:[minNum floatValue] maxValue:[maxNum floatValue]];
//        [self.rangeSlider setLeftValue:[[dict objectForKey:@"Min"] floatValue] rightValue:[[dict objectForKey:@"Max"] floatValue]];
//        self.rangeSlider.minimumDistance = 1;
        _maxTF.text = ronakGlobal.selectedFilter.priceMinMax[@"Max"];
        _minTf.text = ronakGlobal.selectedFilter.priceMinMax[@"Min"];
//        _minLabel.hidden=YES;
//        _maxLabel.hidden=YES;
        return;
    }
    if([_filterType isEqualToString:kStockvalue])
    {
//        NSNumber *maxNum=[ronakGlobal.stockArr valueForKeyPath:@"@max.self"];
//        NSNumber *minNum=[ronakGlobal.stockArr valueForKeyPath:@"@min.self"];
//         NSMutableDictionary *dict=ronakGlobal.selectedFilter.stockMinMax;
//        _maxLabel.text = [NSString stringWithFormat:@"%@ ",maxNum];
//        _minLabel.text = [NSString stringWithFormat:@"%@ ",minNum];
//        
//        [self.rangeSlider setMinValue:[minNum floatValue] maxValue:[maxNum floatValue]];
//        [self.rangeSlider setLeftValue:[[dict objectForKey:@"Min"] floatValue] rightValue:[[dict objectForKey:@"Max"] floatValue]];
//        self.rangeSlider.minimumDistance = 1;
       _maxTF.text = ronakGlobal.selectedFilter.stockMinMax[@"Max"];
        _minTf.text = ronakGlobal.selectedFilter.stockMinMax[@"Min"];
//        _minLabel.hidden=YES;
//        _maxLabel.hidden=YES;
        return;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if([_filterType isEqual: kDiscount]){
        return (newLength <= 2)&&([string isEqualToString:filtered]);
    }else{
        return [string isEqualToString:filtered];
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    if([_filterType isEqualToString:kStockvalue])
//    {
//        return [self discountTFValidations];
//    }
//    if(textField==_maxTF)
//    {
//        if(_maxTF.text.integerValue>_minTf.text.integerValue){
//                return YES;
//            }else{
//                NSString *str=@"Max value must be greater than Min Value";
//                [[NSNotificationCenter defaultCenter] postNotificationName:MinMaxValidationNotification object:str];
//                return NO;
//            }
//        }
//    if(textField==_minTf)
//    {
//        if((_minTf.text.integerValue<_maxTF.text.integerValue)||_maxTF.text.length==0){
//            return YES;
//        }else{
//            NSString *str=@"Min value must be less than Max Value";
//            [[NSNotificationCenter defaultCenter] postNotificationName:MinMaxValidationNotification     object:str];
//            return NO;
//        }
//    else{
        return YES;
//    }
}

-(BOOL)discountTFValidations{
    int minStr= [_minTf.text intValue];
    int maxStr= [_maxTF.text intValue];    
    BOOL greater = (maxStr>minStr)||(maxStr==0&&minStr==0)||(minStr==0&&maxStr>0)||(minStr>0&&maxStr==0);
    if(!greater){
        NSString *str=@"Max value must be greater than Min Value";
        [[NSNotificationCenter defaultCenter] postNotificationName:MinMaxValidationNotification object:str];
    }
    return greater;
}

-(void)minMaxValidation{
    
    if([_filterType isEqual: kStockvalue]){
     
        if([self discountTFValidations]){
            ronakGlobal.minMaxValidationBoolean=YES;
        }else{
            ronakGlobal.minMaxValidationBoolean=NO;
        }
        return;
    }
    if(_maxTF.text.integerValue<=_minTf.text.integerValue){
        ronakGlobal.minMaxValidationBoolean=NO;
    }else{
        ronakGlobal.minMaxValidationBoolean=YES;
    }

}

@end
