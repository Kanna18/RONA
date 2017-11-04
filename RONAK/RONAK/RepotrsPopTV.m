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
    
    OrderStatsResponse *respData;
    
    NSArray *tvData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    tvData=@[@"SR",@"RSM",@"HOD",@"MD",@"SAP",@"SO",@"Invoiced",@"Dispatched",@"Delivered"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)bindData:(OrderStatsResponse *)resp
{
    _titleLabel.text=resp.Customer_Name__c;

}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tvData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportsStatusCell *cell=(ReportsStatusCell*)[tableView dequeueReusableCellWithIdentifier:@"reportsStatusCell"];
    [cell bindData:respData];
    _titleLabel.text=respData.Customer_Name__c;
    cell.statusCell.text=tvData[indexPath.row];
    switch (indexPath.row) {
        case 0:
            {
                cell.dateCell.text=respData.Sale_Order_No_Created_Date__c;
            }
            break;
        case 1:
        {
            cell.dateCell.text=respData.RSM_Date__c;
        }
            break;
        case 2:
        {
            cell.dateCell.text=respData.HOD_Date__c;
        }
            break;
        case 3:
        {
        
        }
            break;
        case 4:
        {
            cell.dateCell.text=respData.SAP_Date__c;
        }
            break;
        case 5:
        {

        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
        case 8:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
