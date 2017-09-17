//
//  Draft3.m
//  CustomAlert
//
//  Created by TTPLCOMAC1 on 28/08/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import "CollectionPopUp.h"

@implementation CollectionPopUp

-(instancetype)initWithFrame:(CGRect)frame witTitle:(NSString*)title withSuperView:(OrderSummaryVC*)supVw
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self=[[NSBundle mainBundle]loadNibNamed:@"CollectionPopUp" owner:self options:nil][0];
        _osVC=supVw;
        _titleLabel.text=title;
    }
    
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self=[[NSBundle mainBundle]loadNibNamed:@"CollectionPopUp" owner:self options:nil][0];
    }
    
    
    return self;
}

-(IBAction)noClick:(id)sender
{
    [self removeFromSuperview];
    if(_osVC){
    _osVC.draftBtn.selected=NO;
    _osVC.deliveryBtn.selected=NO;
    }
}
-(IBAction)yesClick:(id)sender
{
    [self removeFromSuperview];
    if(_osVC){
    _osVC.draftBtn.selected=NO;
    _osVC.deliveryBtn.selected=NO;
    }
}
@end
