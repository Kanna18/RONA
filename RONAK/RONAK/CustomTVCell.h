//
//  CustomTVCell.h
//  RONAK
//
//  Created by Gaian on 8/11/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//


@protocol HideUnhideStatus <NSObject>

-(void)getbuttonStatus:(UIButton*)sender cell:(UITableViewCell*)cell;

@end

#import <UIKit/UIKit.h>

@interface CustomTVCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property id<HideUnhideStatus> delegate;

- (IBAction)headerButtonFunction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *headerButton;
@property (strong, nonatomic) IBOutlet UITableView *optionsTableView;
@property NSArray *optionsArray;
@end
