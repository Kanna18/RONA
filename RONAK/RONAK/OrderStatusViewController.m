//
//  OrderStatusViewController.m
//  RONAK
//
//  Created by Gaian on 10/30/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "OrderStatusViewController.h"

@interface OrderStatusViewController ()

@end

@implementation OrderStatusViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _statusTableView.delegate=self;
    _statusTableView.dataSource=self;
    
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


-(void)getOrderStatusResponse{
    
    NSDictionary *headers = @{ @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)],
                               @"content-type": @"application/json",
                               };
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_OrderStatus_b]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) 
    {
        if(data){
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Dictionary--%@",dict);
        }
                                                   
    }];
    [dataTask resume];
   
}
#pragma mark - TablviewDelegates -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse=@"orderStatusCustomCell";
    OrderStatusCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (IBAction)homeClick:(id)sender {
    
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
