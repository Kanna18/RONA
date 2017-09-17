//
//  RemarksView.m
//  RONAK
//
//  Created by Gaian on 9/17/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "RemarksView.h"

@implementation RemarksView
    
CGFloat _currentKeyboardHeight = 0.0f;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString*)str withSuperView:(OrderSummaryVC*)superVC
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([RemarksView class]) owner:self options:nil][0];
        frame.size.height=200;
        self.frame=frame;
        _titleLabel.text=str;
        _superView=superVC;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat deltaHeight = kbSize.height - _currentKeyboardHeight;
    // Write code to adjust views accordingly using deltaHeight
    _currentKeyboardHeight = kbSize.height;
    
    CGRect frame=self.frame;
    frame.origin.y=[[UIScreen mainScreen]bounds].size.height-kbSize.height-200;
    self.frame=frame;
}
- (void)keyboardWillHide:(NSNotification*)notification
{
    [self removeFromSuperview];
    [_textView endEditing:YES];
    [self removeObservers];
    
    if([_titleLabel.text isEqualToString:@"CUSTOMER REMARKS"]){
        _superView.remarksBtn.selected=NO;
    }
    if([_titleLabel.text isEqualToString:@"ROIPL REMARKS"]){
        _superView.roiplBtn.selected=NO;
    }
    
}
-(void)removeObservers{
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];

}


- (IBAction)cancelClick:(id)sender {
    
    [self keyboardWillHide:nil];
}

- (IBAction)checkClick:(id)sender {
    
    if([_titleLabel.text isEqualToString:@"CUSTOMER REMARKS"]){
        _superView.remarksLabel.text=_textView.text;
    }
    if([_titleLabel.text isEqualToString:@"ROIPL REMARKS"]){
        _superView.ropilLabel.text=_textView.text;
    }
    [self keyboardWillHide:nil];
}
@end
