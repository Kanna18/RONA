//
//  ViewController.m
//  ExpandableTableView
//
//  Created by milan on 05/05/16.
//  Copyright © 2016 apps. All rights reserved.
//

#import "DefaultFilter1.h"

#import "ViewControllerCell.h"
#import "RangTableViewCell.h"
#import "ViewControllerCellHeader.h"

#include <stdlib.h>



@interface DefaultFilter1 ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tblView;
    NSMutableArray *arrSelectedSectionIndex;
    BOOL isMultipleExpansionAllowed;
    CGFloat customHeight;
    NSArray *arr;
}
@end

@implementation DefaultFilter1

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set isMultipleExpansionAllowed = true is multiple expanded sections to be allowed at a time. Default is NO.
    isMultipleExpansionAllowed = YES;
    
    
    arrSelectedSectionIndex = [[NSMutableArray alloc] init];
    
    if (!isMultipleExpansionAllowed) {
        [arrSelectedSectionIndex addObject:[NSNumber numberWithInt:(int)arr.count+2]];
    }
    
    
    arr=ronakGlobal.DefFiltersOne;
    
    
    
    [tblView registerNib:[UINib nibWithNibName:@"RangTableViewCell" bundle:nil] forCellReuseIdentifier:@"RangeCell"];
    tblView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    customHeight=44;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - TableView methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        return [arr[section][@"options"] count];
    }else{
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        ViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCell"];
        if (cell ==nil)
        {
            [tblView registerClass:[ViewControllerCell class] forCellReuseIdentifier:@"ViewControllerCell"];
            cell = [tblView dequeueReusableCellWithIdentifier:@"ViewControllerCell"];
        }
        cell.lblName.text=arr[indexPath.section][@"options"][indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        switch (indexPath.section) {
            case 0:
                cell.imageNew.image=[ronakGlobal.selectedFilter.brand isEqualToString:cell.lblName.text]?[UIImage imageNamed:@"checkBlue"]:[UIImage imageNamed:@"uncheckFilter"];
                break;
            case 1:
                cell.imageNew.image=[ronakGlobal.selectedFilter.categories containsObject:cell.lblName.text]?[UIImage imageNamed:@"checkBlue"]:[UIImage imageNamed:@"uncheckFilter"];
                break;
            case 2:
                cell.imageNew.image=[ronakGlobal.selectedFilter.collection containsObject:cell.lblName.text]?[UIImage imageNamed:@"checkBlue"]:[UIImage imageNamed:@"uncheckFilter"];
                break;
            default:
                break;
        }
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1)
    {
        return customHeight;
    }
    else
    {
        return  44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ViewControllerCellHeader *headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];
    
    if (headerView ==nil)
    {
        [tblView registerClass:[ViewControllerCellHeader class] forCellReuseIdentifier:@"ViewControllerCellHeader"];
        
        headerView = [tableView dequeueReusableCellWithIdentifier:@"ViewControllerCellHeader"];
    }
    
    headerView.lbTitle.text=arr[section][@"heading"];
    
    if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:section]])
    {
        headerView.btnShowHide.selected = YES;
    }
    
    [[headerView btnShowHide] setTag:section];
    
    [[headerView btnShowHide] addTarget:self action:@selector(btnTapShowHideSection:) forControlEvents:UIControlEventTouchUpInside];
    
    return headerView.contentView;
}

-(IBAction)btnTapShowHideSection:(UIButton*)sender
{
    if (!sender.selected)
    {
        if (!isMultipleExpansionAllowed) {
            [arrSelectedSectionIndex replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:sender.tag]];
        }else {
            [arrSelectedSectionIndex addObject:[NSNumber numberWithInteger:sender.tag]];
        }
        customHeight=150;
        sender.selected = YES;
    }else{
        sender.selected = NO;
        
        if ([arrSelectedSectionIndex containsObject:[NSNumber numberWithInteger:sender.tag]])
        {
            [arrSelectedSectionIndex removeObject:[NSNumber numberWithInteger:sender.tag]];
        }
        customHeight=44;
    }
    
    if (!isMultipleExpansionAllowed) {
        [tblView reloadData];
    }else {
        [tblView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewControllerCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    NSString *text=cell.lblName.text;
    NSMutableArray *globalArr;
    switch (indexPath.section) {
        case 0:
            ronakGlobal.selectedFilter.brand=text;
            break;
        case 1:
            globalArr=ronakGlobal.selectedFilter.categories;
            [globalArr containsObject:text]?[globalArr removeObject:text]:[globalArr addObject:text];
            break;
        case 2:
            globalArr=ronakGlobal.selectedFilter.collection;
            [globalArr containsObject:text]?[globalArr removeObject:text]:[globalArr addObject:text];
            break;
        default:
            break;
    }
    [tableView reloadData];
}


#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
