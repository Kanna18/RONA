//
//  RepotrsPopTV.m
//  RONAK
//
//  Created by Gaian on 11/4/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "RepotrsPopTV.h"
#import "ReportsStatusCell.h"
@interface RepotrsPopTV ()

@end


@implementation RepotrsPopTV{
    
    OrderStatusCustomResponse *respData;
    
    NSMutableArray *tvData;
    NSMutableDictionary *dict;
    NSMutableArray *daysCount;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    tvData=[[NSMutableArray alloc]init];
    dict=[[NSMutableDictionary alloc]init];
    daysCount=[[NSMutableArray alloc]init];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)bindData:(OrderStatusCustomResponse *)resp
{
    
    [tvData removeAllObjects];
    _titleLabel.text=resp.Customer_Name__c;
    respData=resp;
    
    
    if(respData.CreatedDate)
    {
        [dict setValue:[respData.CreatedDate substringToIndex:10] forKey:@"SR"];
        [tvData addObject:@"SR"];
    }
    if(respData.RSM_Date__c)
    {
        [dict setValue:respData.RSM_Date__c forKey:@"RSM"];
        [tvData addObject:@"RSM"];
    }
    if(respData.HOD_Date__c)
    {
        [dict setValue:respData.HOD_Date__c forKey:@"HOD"];
        [tvData addObject:@"HOD"];
    }
    if(respData.MD_Date__c)
    {
        [dict setValue:respData.MD_Date__c forKey:@"MD"];
        [tvData addObject:@"MD"];
    }
    if(respData.SAP_Date__c)
    {
        [dict setValue:respData.SAP_Date__c forKey:@"SAP"];
        [tvData addObject:@"SAP"];
    }
    if(respData.Sale_Order_Date__c)
    {
        [dict setValue:respData.Sale_Order_Date__c forKey:@"SO"];
        [tvData addObject:@"SO"];
    }
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tvData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportsStatusCell *cell=(ReportsStatusCell*)[tableView dequeueReusableCellWithIdentifier:@"reportsStatusCell"];
    [cell bindData:respData];
    _titleLabel.text=respData.Customer_Name__c;
    cell.statusCell.text=tvData[indexPath.row];
    cell.dateCell.text=[dict valueForKey:tvData[indexPath.row]];
    if(indexPath.row==0){
        cell.daysLbl.text=@"1";
    }
    else{
    cell.daysLbl.text=[self compareTwoDatesandReturnDays:[dict valueForKey:tvData[indexPath.row-1]] Dt2:[dict valueForKey:tvData[indexPath.row]]];
    }
    return cell;
}

-(NSString*)compareTwoDatesandReturnDays:(NSString*)datStr1 Dt2:(NSString*)datStr2
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [f dateFromString:datStr1];
    NSDate *date2 = [f dateFromString:datStr2];
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    int numberOfDays = secondsBetween / 86400;
    NSString *daysStr=[NSString stringWithFormat:@"%d",numberOfDays];
    return daysStr;
}

@end
