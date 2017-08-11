//
//  UITextField+Padding.m
//  INCOIS
//
//  Created by Gaian on 7/6/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import "UITextField+Padding.h"

@implementation UITextField (Padding)

-(void)setPadding{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchIcon"]];
    img.frame=CGRectMake(10, 5, 20, 20);
    [paddingView addSubview:img];
}
-(void)setRightPadding{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.rightView = paddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clearIcon"]];
    img.frame=CGRectMake(0, 5, 20, 20);
    [paddingView addSubview:img];
}



-(BOOL)hasValidEmail
{
    //TODO: Change the regular expression as desired
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", regExPattern];
    return [emailTest evaluateWithObject:self.text];
    
    
//    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
//    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
//    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
//    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:checkString];

}

-(BOOL)hasValidPhoneNumber
{
    //TODO: Change the regular expression as desired
    NSString *regExPattern = @"[0-9]{10}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExPattern];
    return [test evaluateWithObject:self.text];
}

-(BOOL)hasValidText
{
    return self.text.length!=0 && [self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!=0;
}

-(BOOL)hasValidPassword
{
    return [self hasCapitalAndSmallLetters] && [self hasDigit] && [self hasSpecialCharacter] && [self hasMinLength];
}

-(BOOL)hasCapitalAndSmallLetters
{
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:RegexHasCapitalAndSmallLetters options:0 error:nil];
    NSRange range = NSMakeRange(0, [self.text length]);
    return [regex numberOfMatchesInString:self.text options:0 range:range] > 0;
}

-(BOOL)hasDigit
{
    return [self.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound;
}

-(BOOL)hasSpecialCharacter
{
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:RegexHasSpecialCharacter options:0 error:nil];
    NSRange range = NSMakeRange(0, [self.text length]);
    return [regex numberOfMatchesInString:self.text options:0 range:range] > 0;
}

-(BOOL)hasMinLength
{
    return self.text.length>=MinPasswordLength;
}


@end
