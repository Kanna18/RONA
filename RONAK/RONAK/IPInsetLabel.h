//
//  IPInsetLabel.h
//  RONAK
//
//  Created by Gaian on 2/6/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import "CustomLabel.h"

@interface IPInsetLabel : CustomLabel
@property (nonatomic, assign) UIEdgeInsets insets;
- (void)resizeHeightToFitText;
@end
