//
//  IPInsetLabel.m
//  RONAK
//
//  Created by Gaian on 2/6/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import "IPInsetLabel.h"

@implementation IPInsetLabel
@synthesize insets;


- (void)drawTextInRect:(CGRect)uiLabelRect {
    UIEdgeInsets myLabelInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [super drawTextInRect:UIEdgeInsetsInsetRect(uiLabelRect, myLabelInsets)];
}

- (void)resizeHeightToFitText
{
    CGRect frame = [self bounds];
    CGFloat textWidth = frame.size.width - (self.insets.left + self.insets.right);
    
    CGSize newSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(textWidth, 1000000) lineBreakMode:self.lineBreakMode];
    frame.size.height = newSize.height + self.insets.top + self.insets.bottom;
    self.frame = frame;
}
@end
