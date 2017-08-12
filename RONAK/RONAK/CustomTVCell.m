//
//  CustomTVCell.m
//  RONAK
//
//  Created by Gaian on 8/11/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomTVCell.h"

@implementation CustomTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _optionsTableView.delegate=self;
    _optionsTableView.dataSource=self;
    _optionsTableView.separatorStyle=UITableViewCellSelectionStyleNone;
    
    _headerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _headerButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

//    [_headerButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)headerButtonFunction:(id)sender {
    
    UIButton *btn=sender;
    if(btn.selected==YES)
    {
        btn.selected=NO;
        [btn setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateNormal];
    }
    else{
        btn.selected=YES;
        [btn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
    }
    [_delegate getbuttonStatus:btn cell:self];
}



#pragma mark options TableView Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _optionsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuse=@"filterOptionCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=_optionsArray[indexPath.row];
    
    CGSize itemSize = CGSizeMake(20,20);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.imageView.layer.masksToBounds = YES;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image=[UIImage imageNamed:@"checkFilter"];
    

}
@end
