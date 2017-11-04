//
//  OrderStatusViewController.m
//  RONAK
//
//  Created by Gaian on 10/30/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "OrderStatsResponse.h"

@interface OrderStatusViewController ()

@end

@implementation OrderStatusViewController
{
    NSMutableArray *dataResp;
    UIView *overlayView;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _statusTableView.delegate=self;
    _statusTableView.dataSource=self;
    _statusTableView.layer.borderWidth=1.0f;
    _statusTableView.layer.borderColor=RGB(209, 210, 212).CGColor;
    _statusTableView.clipsToBounds=YES;
    [self getOrderStatusResponse];
    [self allocAwindowOntop];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissStatus:)];
    [self.view addGestureRecognizer:tap];
    tap.numberOfTapsRequired=2;

}
-(void)dismissStatus:(id)sender{
    
    overlayView.hidden=YES;
    
}
-(void)showStatus:(UIButton*)sender{
    overlayView.hidden=NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)allocAwindowOntop{
    
    
    overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    overlayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:overlayView];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    subView.backgroundColor = [UIColor blackColor];
    subView.alpha=0.8;
    [overlayView addSubview:subView];
    
    _reportStatus =[self.storyboard instantiateViewControllerWithIdentifier:@"reportsTV"];
    _reportStatus.view.frame=CGRectMake(0, 0, 500, 500);
    _reportStatus.view.center=subView.center;
    [self addChildViewController:_reportStatus];                 // 1
    [overlayView addSubview:_reportStatus.view];
    [_reportStatus didMoveToParentViewController:self];
    overlayView.hidden=YES;
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
            NSArray *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSError *err;
           dataResp=[OrderStatsResponse arrayOfModelsFromDictionaries:dict error:&err];
            NSLog(@"%@",dataResp);
            dispatch_async(dispatch_get_main_queue(), ^{
            [_statusTableView reloadData];
            });
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
    return dataResp.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse=@"orderStatusCustomCell";
    OrderStatusCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse];
    OrderStatsResponse *resp=dataResp[indexPath.row];
    [cell bindData:resp superViewCon:self];
    [cell.statusBtn addTarget:self action:@selector(showStatus:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
