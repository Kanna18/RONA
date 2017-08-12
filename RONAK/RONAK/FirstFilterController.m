//
//  FirstFilterController.m
//  RONAK
//
//  Created by Gaian on 8/11/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "FirstFilterController.h"

@interface FirstFilterController ()

@end

@implementation FirstFilterController
{
    CGFloat height;
    unsigned long Section;
    
    NSArray *filtersArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _filterTable.delegate=self;
    _filterTable.dataSource=self;
    _filterTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    height=50;
    filtersArr=@[@{  @"heading":@"Brand",
                     @"options":@[@"IDEE",
                            @"IMAGE",
                            @"POLICE",
                            @"GUESS",
                            @"CHOPARD",
                            @"FILA",
                            @"FLAIR",
                            @"DUNHILL",
                            @"CAROLINA",
                            @"HERRERA",
                            @"LANVIN",
                            @"ESPEE",
                              @"UCB"]},
                 @{  @"heading":@"Categories",
                     @"options":@[@"Frames",
                                 @"Sunglasses",
                                 @"Cases",
                                 @"Cleaning Cloth",
                                 @"POP",
                                   @"Spares"]},
                 @{ @"heading":@"Collection",
                    @"options":@[@"Jul-17",
                                 @"Apr-17",
                                 @"Jan-17",
                                 @"Oct-17",
                                   @"Jul-17"]}];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         [_filterTable reloadData];
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
-(void)getbuttonStatus:(UIButton *)sender cell:(UITableViewCell *)cell
{
    if(sender.selected==YES){
        height=356;
    }
    else{
        height=61;
    }
    Section=sender.tag;
    
    [_filterTable reloadData];
//    [UIView transitionWithView: _filterTable
//                      duration: 0.35f
//                       options: UIViewAnimationOptionTransitionCrossDissolve
//                    animations: ^(void)
//    {
//        [_filterTable reloadData];
//    }
//                    completion: nil];
//    [_filterTable reloadData];
//    NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:self.filterTable]);
//    NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
//    [self.filterTable reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
//    [_filterTable reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];

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
