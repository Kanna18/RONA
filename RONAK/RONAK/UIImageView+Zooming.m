//
//  UIImageView+Zooming.m
//  RONAK
//
//  Created by Gaian on 8/28/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "UIImageView+Zooming.h"

@implementation UIImageView (Zooming)

@dynamic doubleTap;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
}
-(void)tappedtwice:(id)sender
{
    CGRect frame=[[UIScreen mainScreen]bounds];
    [UIView animateWithDuration:0.2 animations:^{
        self.frame=frame;
    }];
}
-(void)setDoubleTap:(BOOL)doubleTap
{
    if(doubleTap==YES)
    {
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedtwice:)];
        tap.numberOfTapsRequired=2;
        [self addGestureRecognizer:tap];
    }
}
@end
