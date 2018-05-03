//
//  RangTableViewCell.m
//  RONAK
//
//  Created by Gaian on 8/29/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#define NUMBERS_ONLY @"1234567890"


#import "RangTableViewCell.h"

@implementation RangTableViewCell{
    
    BOOL stockFilterBool, mrpFilterBool, wsFilterBool, discountFilterBool;
}

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeSlider:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rangeSliderValueDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    self.rangeSlider = [[MARKRangeSlider alloc] init];
    [self.rangeSlider addTarget:self action:@selector(rangeSliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
        [self.rangeSlider setMinValue:0 maxValue:100];
        [self.rangeSlider setLeftValue:0 rightValue:20];
        self.rangeSlider.minimumDistance = 1;
    [self.sliderView addSubview:self.rangeSlider];
    // Configure the view for the selected state
    _minTf.delegate=self;
    _maxTF.delegate=self;
    if(!(_minTf.text.length>0)){
        _minTf.text=@"0";
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minMaxValidation) name:UITextFieldTextDidChangeNotification object:nil];
    
    [self performSelector:@selector(assignTextFieldTagsBasedonFilterType) withObject:nil afterDelay:0.1];
}

-(void)assignTextFieldTagsBasedonFilterType{
    
    if([_filterType isEqualToString:kDiscount]){
        _minTf.tag = discount_minTfTag;
        _maxTF.tag = discount_maxTfTag;
    }if ([_filterType isEqualToString:kWSPrice]){
        _minTf.tag = ws_minTfTag;
        _maxTF.tag = ws_maxTfTag;
    }if ([_filterType isEqualToString:kMRP]){
        _minTf.tag = mrp_minTfTag;
        _maxTF.tag = mrp_maxTfTag;
    }if ([_filterType isEqualToString:kStockvalue]){
        _minTf.tag = stock_minTfTag;
        _maxTF.tag = stock_maxTfTag;
    }
}


-(void)changeSlider:(id)sender{
    [_rangeSlider setLeftValue:[_minTf.text floatValue] rightValue:[_maxTF.text floatValue]];
}

- (void)rangeSliderValueDidChange:(id)slider{

    if([slider isKindOfClass:[MARKRangeSlider class]])
    {
        MARKRangeSlider *sli=slider;
        NSLog(@"%0.2f - %0.2f", sli.leftValue, sli.rightValue);
        _minTf.text=[NSString stringWithFormat:@"%.0f",sli.leftValue];
        _maxTF.text=[NSString stringWithFormat:@"%.0f",sli.rightValue];
        
        stockFilterBool=NO;
        mrpFilterBool=NO;
        wsFilterBool=YES;
        discountFilterBool=YES;
    }
    
    if([_filterType isEqualToString:kDiscount]&&discountFilterBool)
    {
        [ronakGlobal.selectedFilter.disCountMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.disCountMinMax setValue:_maxTF.text forKey:@"Max"];
        return;
    }
    if([_filterType isEqualToString:kWSPrice]&&wsFilterBool)
    {
        [ronakGlobal.selectedFilter.wsPriceMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.wsPriceMinMax setValue:_maxTF.text forKey:@"Max"];
        return;
    }
    if([_filterType isEqualToString:kMRP]&&mrpFilterBool)
    {
        [ronakGlobal.selectedFilter.priceMinMax setValue:_minTf.text forKey:@"Min"];
        [ronakGlobal.selectedFilter.priceMinMax setValue:_maxTF.text forKey:@"Max"];
        return;
    }
    if([_filterType isEqualToString:kStockvalue]&&stockFilterBool)
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
        _minTf.text=ronakGlobal.selectedFilter.disCountMinMax[@"Min"];
        _maxTF.text=ronakGlobal.selectedFilter.disCountMinMax[@"Max"];
        [self.rangeSlider setLeftValue:[ronakGlobal.selectedFilter.disCountMinMax[@"Min"] floatValue] rightValue:[ronakGlobal.selectedFilter.disCountMinMax[@"Max"] floatValue]];
        
        return;
    }
    if([_filterType isEqualToString:kWSPrice])
    {
        _maxTF.text = ronakGlobal.selectedFilter.wsPriceMinMax[@"Max"];
        _minTf.text = ronakGlobal.selectedFilter.wsPriceMinMax[@"Min"];
        return;
    }
    if([_filterType isEqualToString:kMRP])
    {
        _maxTF.text = ronakGlobal.selectedFilter.priceMinMax[@"Max"];
        _minTf.text = ronakGlobal.selectedFilter.priceMinMax[@"Min"];
        return;
    }
    if([_filterType isEqualToString:kStockvalue])
    {
        _maxTF.text = ronakGlobal.selectedFilter.stockMinMax[@"Max"];
        _minTf.text = ronakGlobal.selectedFilter.stockMinMax[@"Min"];
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

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField.tag==stock_maxTfTag||textField.tag==stock_minTfTag){
        stockFilterBool=YES;
        mrpFilterBool=NO;
        wsFilterBool=NO;
        discountFilterBool=NO;
        return YES;
    }if(textField.tag==discount_maxTfTag||textField.tag==discount_minTfTag){
        stockFilterBool=NO;
        mrpFilterBool=NO;
        wsFilterBool=NO;
        discountFilterBool=YES;
        return YES;
    }if(textField.tag==ws_maxTfTag||textField.tag==ws_minTfTag){
        stockFilterBool=NO;
        mrpFilterBool=NO;
        wsFilterBool=YES;
        discountFilterBool=NO;
        return YES;
    }if(textField.tag==mrp_maxTfTag||textField.tag==mrp_minTfTag){
        stockFilterBool=NO;
        mrpFilterBool=YES;
        wsFilterBool=NO;
        discountFilterBool=NO;
        return YES;
    }
    return YES;
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
    if([_filterType isEqual: kMRP]||[_filterType isEqual: kDiscount]||[_filterType isEqual: kWSPrice]){
    if(_maxTF.text.integerValue<_minTf.text.integerValue){
        ronakGlobal.minMaxValidationBoolean=NO;
    }else{
        ronakGlobal.minMaxValidationBoolean=YES;
    }
    }

}

@end
