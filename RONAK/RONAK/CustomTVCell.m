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
    _optionsTableView.scrollEnabled=NO;
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
    [self.optionsTableView reloadData];
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
    cell.textLabel.text=_optionsArray.count>0&&_optionsArray.count>indexPath.row?_optionsArray[indexPath.row]:@"";
    [self filterSelectionBasedonType:cell];
    
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
    [tableView reloadData];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if([_filterType isEqualToString:kBrand])
    {
        ronakGlobal.selectedFilter.brand=cell.textLabel.text;
    }
    if([_filterType isEqualToString:kCategories])
    {
        if([ronakGlobal.selectedFilter.categories containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.categories removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.categories addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kCollection])
    {
        if([ronakGlobal.selectedFilter.collection containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.collection removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.collection addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kStockWareHouse])
    {
        ronakGlobal.selectedFilter.warehouseType=@"Stock";
        [ronakGlobal.selectedFilter.sampleHouseFilter removeAllObjects];
        if([ronakGlobal.selectedFilter.stockHouseFilter containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.stockHouseFilter removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.stockHouseFilter addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kSampleWareHouse])
    {
        ronakGlobal.selectedFilter.warehouseType=@"Sample";
        [ronakGlobal.selectedFilter.stockHouseFilter removeAllObjects];
        if([ronakGlobal.selectedFilter.sampleHouseFilter containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.sampleHouseFilter removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.sampleHouseFilter addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kLensDescription])
    {
        if([ronakGlobal.selectedFilter.lensDescription containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.lensDescription removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.lensDescription addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kShape])
    {
        if([ronakGlobal.selectedFilter.shape containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.shape removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.shape addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kFrameMaterial])
    {
        if([ronakGlobal.selectedFilter.frameMaterial containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.frameMaterial removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.frameMaterial addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kTempleMaterial])
    {
        if([ronakGlobal.selectedFilter.templeMaterial containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.templeMaterial removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.templeMaterial addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kTempleColour])
    {
        if([ronakGlobal.selectedFilter.templeColor containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.templeColor removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.templeColor addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kTipColor])
    {
        if([ronakGlobal.selectedFilter.tipsColor containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.tipsColor removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.tipsColor addObject:cell.textLabel.text];
        }
    }
    if([_filterType isEqualToString:kSize])
    {
        if([ronakGlobal.selectedFilter.size containsObject:cell.textLabel.text])
        {
            [ronakGlobal.selectedFilter.size removeObject:cell.textLabel.text];
        }
        else
        {
            [ronakGlobal.selectedFilter.size addObject:cell.textLabel.text];
        }
    }
    [tableView reloadData];
}

-(void)filterSelectionBasedonType:(UITableViewCell*)cell{
    if([_filterType isEqualToString:kBrand])
    {
        NSString *str=ronakGlobal.selectedFilter.brand;
        if([cell.textLabel.text isEqualToString:str])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }
    if([_filterType isEqualToString:kCategories])
    {
        if([ronakGlobal.selectedFilter.categories containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
        
    }
    if([_filterType isEqualToString:kCollection])
    {
        if([ronakGlobal.selectedFilter.collection containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }
    if([_filterType isEqualToString:kStockWareHouse])
    {
        if([ronakGlobal.selectedFilter.stockHouseFilter containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }
    if([_filterType isEqualToString:kSampleWareHouse])
    {
        if([ronakGlobal.selectedFilter.sampleHouseFilter containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }
    if([_filterType isEqualToString:kLensDescription])
    {
        if([ronakGlobal.selectedFilter.lensDescription containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }
    if([_filterType isEqualToString:kShape])
    {
        if([ronakGlobal.selectedFilter.shape containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }
    if([_filterType isEqualToString:kFrameMaterial])
    {
        if([ronakGlobal.selectedFilter.frameMaterial containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }
    if([_filterType isEqualToString:kTempleMaterial])
    {
        if([ronakGlobal.selectedFilter.templeMaterial containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }
    if([_filterType isEqualToString:kTempleColour])
    {
        if([ronakGlobal.selectedFilter.templeColor containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }
    if([_filterType isEqualToString:kTipColor])
    {
        if([ronakGlobal.selectedFilter.tipsColor containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=nil;
        }
    }
    if([_filterType isEqualToString:kSize])
    {
        if([ronakGlobal.selectedFilter.size containsObject:cell.textLabel.text])
        {
            cell.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"checkBlue"]];
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"uncheckFilter"];
        }
    }

}
@end
