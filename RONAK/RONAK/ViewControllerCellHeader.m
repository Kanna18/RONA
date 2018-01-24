//
//  ViewControllerCellHeader.m
//  ExpandableTableView
//
//  Created by milan on 05/05/16.
//  Copyright © 2016 apps. All rights reserved.
//

#import "ViewControllerCellHeader.h"

@implementation ViewControllerCellHeader

@synthesize btnShowHide, lbTitle;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [_headerButton setContentMode:UIViewContentModeRedraw];
    
    _headerButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0,30);
//    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    _searchField.hidden=YES;
    
}

@end
