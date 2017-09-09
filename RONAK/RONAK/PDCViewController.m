//
//  PDCViewController.m
//  RONAK
//
//  Created by Gaian on 8/16/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "PDCViewController.h"
#import "PDCCell.h"
@interface PDCViewController ()<UITextFieldDelegate>

@end

@implementation PDCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",docPath);
    // Do any additional setup after loading the view.
    _listTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _customerNmLbl.text=_cst.Name;
    _customerNmLbl.font=[UIFont boldSystemFontOfSize:25];
    _swipeGest.numberOfTouchesRequired=noOfTouches;
    _swipeGest.direction=UISwipeGestureRecognizerDirectionRight;
    _filterView.hidden=YES;
    
    _fromDateTf.delegate=self;
    _toDateTF.delegate=self;
    _chequeNo.delegate=self;
    _chequeTypeTF.delegate=self;
    
    UITapGestureRecognizer *tapTwice=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showFilter:)];
    tapTwice.numberOfTapsRequired=2;
    [self.view addGestureRecognizer:tapTwice];
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
//    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.toDateTF setInputView:datePicker];
    [self.fromDateTf setInputView:datePicker];

//    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];

}

-(void)showFilter:(id)sender
{
    if(_filterView.hidden==YES)
    {
        _filterView.hidden=NO;
    }
    else
    {
        _filterView.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == _fromDateTf)
    {
        [self updateTextField:textField];
    }
    if(textField == _toDateTF)
    {
        [self updateTextField:textField];
    }
}

-(void)updateTextField:(UITextField*)sender
{
    
//    UIDatePicker *picker = (UIDatePicker*)sender.inputView;
//    
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd MMM EEE"];
//    NSDate *date  = [dateFormatter dateFromString:picker.date];
//    sender.text = [NSString stringWithFormat:@"%@",[dateFormatter dateFromString:picker.date]];
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
- (IBAction)jumptoMenuVC:(id)sender
{
    
    NSArray *arr=self.navigationController.viewControllers;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[MenuViewController class]])
        {
            [self.navigationController popToViewController:(MenuViewController*)obj animated:YES];
            return ;
        }
    }];
}


@end
