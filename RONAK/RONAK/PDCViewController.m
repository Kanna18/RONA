//
//  PDCViewController.m
//  RONAK
//
//  Created by Gaian on 8/16/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "PDCViewController.h"
#import "PDCCell.h"
#import "DefaultFiltersViewController.h"



@interface PDCViewController ()<UITextFieldDelegate>

@end

@implementation PDCViewController{
    
    NSArray *tvArray;
}

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
    datePicker.datePickerMode=UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
//    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.toDateTF setInputView:datePicker];
    [self.fromDateTf setInputView:datePicker];

//    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];

    NSSortDescriptor *sort=[[NSSortDescriptor alloc]initWithKey:@"Receipt_Date__c" ascending:YES];
    tvArray=[_cst.PDC__r.records sortedArrayUsingDescriptors:@[sort]];
    [_listTableView reloadData];
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
        if(_fromDateTf.text.length>0&&_toDateTF.text.length>0)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(Receipt_Date__c >= %@) AND (Receipt_Date__c <= %@)", _fromDateTf.text, _toDateTF.text];
            tvArray=[_cst.PDC__r.records filteredArrayUsingPredicate:predicate];
            NSSortDescriptor *sort=[[NSSortDescriptor alloc]initWithKey:@"Receipt_Date__c" ascending:YES];
            tvArray=[tvArray sortedArrayUsingDescriptors:@[sort]];
            [_listTableView reloadData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self addDoneButtontoKeyboard:textField];
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
    UIDatePicker *picker = (UIDatePicker*)sender.inputView;
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [DateFormatter stringFromDate:picker.date];
    sender.text = [NSString stringWithFormat:@"%@",dateString];
}
-(void)addDoneButtontoKeyboard:(UITextField*)textField
{
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton,doneBarButton];
    textField.inputAccessoryView = keyboardToolbar;
}
-(void)yourTextViewDoneButtonPressed
{
    [self.view endEditing:YES];
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
    
    return tvArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reus=@"pdcCell";
    PDCCell *cell=[tableView dequeueReusableCellWithIdentifier:reus];
    if(cell==nil)
    {
        cell=[[PDCCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reus];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell bindData:tvArray[indexPath.row]];
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
- (IBAction)chequeNoClick:(id)sender {
    NSSortDescriptor *sortDescriptor;
    UIButton *but=sender;
    if(but.selected==YES)
    {
        but.selected=NO;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Cheque_No__c" ascending:NO];
    }
    else
    {
        but.selected=YES;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Cheque_No__c" ascending:YES];
    }
    tvArray = [tvArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    [_listTableView reloadData];
}
- (IBAction)drawOnClick:(id)sender {
    NSSortDescriptor *sortDescriptor;
    UIButton *but=sender;
    if(but.selected==YES)
    {
        but.selected=NO;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Customer_Bank__c" ascending:NO];
    }
    else
    {
        but.selected=YES;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Customer_Bank__c" ascending:YES];
    }
    tvArray = [tvArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    [_listTableView reloadData];
}
- (IBAction)amountClick:(id)sender {
    NSSortDescriptor *sortDescriptor;
    UIButton *but=sender;
    if(but.selected==YES)
    {
        but.selected=NO;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Amount__c" ascending:NO];
    }
    else
    {
        but.selected=YES;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Amount__c" ascending:YES];
    }
    tvArray = [tvArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    [_listTableView reloadData];
}
- (IBAction)chequeTypeClick:(id)sender {
    NSSortDescriptor *sortDescriptor;
    UIButton *but=sender;
    if(but.selected==YES)
    {
        but.selected=NO;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"attributes.type" ascending:NO];
    }
    else
    {
        but.selected=YES;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"attributes.type" ascending:YES];
    }
    tvArray = [tvArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    [_listTableView reloadData];
}
- (IBAction)pushSwipe:(id)sender {
    
    DefaultFiltersViewController *dvc=storyBoard(@"defaultVC");
    [self.navigationController pushViewController:dvc animated:YES];
}



@end
