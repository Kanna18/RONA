//
//  HeaderReusableView.m
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "HeaderReusableView.h"

@implementation HeaderReusableView
-(void)awakeFromNib
{
    self.layer.cornerRadius=5.0f;
    self.clipsToBounds=YES;
}

@end
