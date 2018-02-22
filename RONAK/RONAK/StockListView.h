//
//  StockListView.h
//  RONAK
//
//  Created by Gaian on 1/17/18.
//  Copyright © 2018 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockListView : UIView
-(instancetype)initWithFrame:(CGRect)frame;
-(void)showStockfromStockMaster:(NSArray*)st;
@property (strong, nonatomic) IBOutlet UILabel *itemName;
@end
