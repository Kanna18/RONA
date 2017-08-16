//
//  PDCCell.h
//  RONAK
//
//  Created by Gaian on 8/16/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDCCell : UITableViewCell
@property (strong, nonatomic) IBOutlet CustomLabel *chequeDate;
@property (strong, nonatomic) IBOutlet CustomLabel *chequeNo;
@property (strong, nonatomic) IBOutlet CustomLabel *drawOn;
@property (strong, nonatomic) IBOutlet CustomLabel *amount;
@property (strong, nonatomic) IBOutlet CustomLabel *cheQueType;

@property PDCRecodrs *record;

-(void)bindData:(PDCRecodrs*)rec;
@end
