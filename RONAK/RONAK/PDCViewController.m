//
//  PDCViewController.m
//  RONAK
//
//  Created by Gaian on 8/16/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "PDCViewController.h"
#import "PDCCell.h"
@interface PDCViewController ()

@end

@implementation PDCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _listTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _customerNmLbl.text=_cst.Name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cst.PDC__r.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reus=@"pdcCell";
    PDCCell *cell=[tableView dequeueReusableCellWithIdentifier:reus];
    if(cell==nil)
    {
        cell=[[PDCCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reus];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell bindData:_cst.PDC__r.records[indexPath.row]];
    return cell;
}



- (IBAction)backClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)homeClick:(id)sender {
}
@end
