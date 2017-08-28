//
//  CustomSwitch.m
//  RONAK
//
//  Created by Gaian on 8/27/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomSwitch.h"

@implementation CustomSwitch

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    UISwipeGestureRecognizer *leftSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipe];
    UISwipeGestureRecognizer *rightSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipe];
    
    [self addTarget:self action:@selector(controlTouched:forEvent:) forControlEvents:UIControlEventAllTouchEvents] ;

    UITouch *detectTouch=[[UITouch alloc]init];
    [detectTouch locationInView:self];

    
}
- (void)controlTouched:(UIControl *)sender forEvent:(UIEvent*)event
{
    UITouch *touch = [[event allTouches] anyObject] ;
    BOOL tag ;
    if ( touch == nil ) tag = NO ;
    else
    {
        UITouchPhase phase = [touch phase] ;
        tag = (phase != UITouchPhaseEnded && phase != UITouchPhaseCancelled) ;
    }
    [sender setTag:tag] ;
}

-(void)leftSwipe:(id)sender
{
    [self setOn:NO animated:YES];
}
-(void)rightSwipe:(id)sender
{
    [self setOn:YES animated:YES];
}
@end
