//
//  AdvancedSecondFilter.m
//  RONAK
//
//  Created by Gaian on 8/25/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "AdvancedSecondFilter.h"

@interface AdvancedSecondFilter ()

@end

@implementation AdvancedSecondFilter{
    CGFloat height;
    unsigned long Section;
    
    NSArray *filtersArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    LoadingView* load=[[LoadingView alloc]init];
    [load loadingWithlightAlpha:_filterTable with_message:@""];
    [load start];
    
    DownloadProducts *dw=[[DownloadProducts alloc]init];
    
    
    _filterTable.delegate=self;
    _filterTable.dataSource=self;
    _filterTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    

    height=61;
    dispatch_async(dispatch_get_main_queue(), ^{
    filtersArr=@[@{  @"heading":kSize,
                     @"options":[dw getFilterFor:@"size__c"]},
                 @{  @"heading":kFrontColor,
                     @"options":[dw getFilterFor:@"front_Color__c"]},
                 @{ @"heading":kLensColor,
                    @"options":[dw getFilterFor:@"lens_Color__c"]}];        
        [_filterTable reloadData];
        [load stop];
    });
    
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
    cell.filterType=[filtersArr[indexPath.section] valueForKey:@"heading"];
    cell.headerButton.tag=indexPath.section;
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
        height=cell.optionsArray.count*44+140;
    }
    else{
        height=61;
    }
    Section=sender.tag;
    [self.filterTable endUpdates];
    
    
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
