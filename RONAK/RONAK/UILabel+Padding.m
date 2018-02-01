//
//  UILabel+Padding.m
//  RONAK
//
//  Created by Gaian on 10/4/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "UILabel+Padding.h"

@implementation UILabel (Padding)

- (void)labelleftPadding{
    
    NSString *txt=self.text;
//    txt=[txt stringByAppendingString:[NSString stringWithFormat:@"\t"]];
    self.text=txt;
}

@end
