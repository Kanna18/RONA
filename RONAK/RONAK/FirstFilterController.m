//
//  FirstFilterController.m
//  RONAK
//
//  Created by Gaian on 8/11/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "FirstFilterController.h"
#import "RangTableViewCell.h"

@interface FirstFilterController ()

@end

@implementation FirstFilterController
{
    CGFloat height;
    unsigned long Section;
    
    NSArray *filtersArr;
    LoadingView *load;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _filterTable.delegate=self;
    _filterTable.dataSource=self;
    _filterTable.separatorStyle=UITableViewCellSeparatorStyleNone;

    
    filtersArr=ronakGlobal.DefFiltersOne;
    height=61;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TV Delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return filtersArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString *reuse=@"testCell";
        CustomTVCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse];
        cell.delegate=self;
        if(cell==nil)
        {
            cell=  [[CustomTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        }
        cell.headerButton.tag=indexPath.section;
        cell.filterType=[filtersArr[indexPath.section] valueForKey:@"heading"];
        [cell.headerButton setTitle:[filtersArr[indexPath.section] valueForKey:@"heading"] forState:UIControlStateNormal];
        cell.optionsArray=[filtersArr[indexPath.section] valueForKey:@"options"];
        if(Section!=indexPath.section){//except the selected cell remaining need to close
            cell.headerButton.selected=NO;
            [cell.headerButton setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateNormal];
        }
        [cell layoutSubviews];
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(Section==indexPath.section)
    {
    return height;
    }
    else{
        return 61;
    }
}
-(void)getbuttonStatus:(UIButton *)sender cell:(CustomTVCell *)cell
{
    [_filterTable reloadData];
    [self.filterTable beginUpdates];
    if(sender.selected==YES){
        height=cell.optionsArray.count>0?cell.optionsArray.count*44+140:200;
    }
    else{
        height=61;
    }
    Section=sender.tag;
    [self.filterTable endUpdates];

}

//- (nullable NSString *)accessibilityScrollStatusForScrollView:(UIScrollView *)scrollView
//{
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
