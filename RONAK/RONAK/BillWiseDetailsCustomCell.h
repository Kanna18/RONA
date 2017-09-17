//
//  BillWiseDetailsCustomCell.h
//  TableTask1
//
//  Created by TTPLCOMAC1 on 12/09/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillWiseDetailsCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *docDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *docNumLbl;
@property (strong, nonatomic) IBOutlet UILabel *brandNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *docTotalLbl;
@property (strong, nonatomic) IBOutlet UILabel *balDueLbl;
@property (strong, nonatomic) IBOutlet UILabel *daysPastLbl;
@property (strong, nonatomic) IBOutlet UILabel *remarksLbl;

@end
