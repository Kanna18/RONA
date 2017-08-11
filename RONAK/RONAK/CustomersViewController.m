//
//  CustomersViewController.m
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomersViewController.h"

static NSString *reuse=@"reuseCustomerCell";

@interface CustomersViewController ()

@end

@implementation CustomersViewController{
    
    NSArray *alphabets;
    ServerAPIManager *serverAPI;
    NSMutableArray *customersList, *cvDataSectionArr,*cvAlphabetSectionArr,*selectedCustomerList;
    LoadingView *load;
    RESTCalls *rest;
    CGFloat scr_width,scr_height;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    load=[[LoadingView alloc]init];
    rest=[[RESTCalls alloc]init];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionHeadersPinToVisibleBounds=YES;
    collectionViewLayout.minimumInteritemSpacing = 0;
    collectionViewLayout.minimumLineSpacing = 0;

    
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    alphabets=@[@"A",@"B",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",];
    
    [self defaultComponentsStyle];
    
    serverAPI=[ServerAPIManager sharedinstance];
    customersList=[[NSMutableArray alloc]init];
    selectedCustomerList=[[NSMutableArray alloc]init];
    
    [load loadingWithlightAlpha:self.view with_message:@"Loading customers"];
    [load start];
    
//    if([fileManager fileExistsAtPath:[docPath stringByAppendingPathComponent:customersFilePath]]){
//        [self getListofAllCustomers:[rest readJsonDataFromFileinNSD:customersFilePath]];
//        NSLog(@"%@",[docPath stringByAppendingPathComponent:customersFilePath]);
//    }
//    else{
    [self restServiceForCustomerList];
//    }
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    scr_width=_collectionView.frame.size.width;
    scr_height=_collectionView.frame.size.height;
    
}
/*-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

}*/
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    scr_height=_collectionView.frame.size.height;
    scr_width=_collectionView.frame.size.width;
     [_collectionView reloadData];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(void)sortCustomersintoSections{
    
    cvDataSectionArr=[[NSMutableArray alloc]init];
    cvAlphabetSectionArr=[[NSMutableArray alloc]init];
    for (NSString *ele in alphabets)
    {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.Name BEGINSWITH[c] %@",ele];
        NSArray *arr=[customersList filteredArrayUsingPredicate:predicate];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES];
        NSArray *sortedArr=[arr sortedArrayUsingDescriptors:@[sortDescriptor]];

        if(sortedArr.count>0)
        {
            [cvDataSectionArr addObject:sortedArr];
            [cvAlphabetSectionArr addObject:ele];
        }
    }
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Server Calls


-(void)restServiceForCustomerList
{
    NSDictionary *headers=@{@"content-type":@"application/x-www-form-urlencoded (OR) application/json",
                            @"authorization":[NSString stringWithFormat:@"Bearer %@",defaultGet(kaccess_token)]};
    [serverAPI  processRequest:rest_customersList_B params:@{@"brand":@"Fila"} requestType:@"GET" cusHeaders:headers successBlock:^(id responseObj) {
        
        
        NSString *dictstr=[NSJSONSerialization JSONObjectWithData:responseObj options: NSJSONReadingAllowFragments error:nil];
        NSData *jsonData=[dictstr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *cerr;
        [rest writeJsonDatatoFile:jsonData toPathExtension:customersFilePath error:cerr];
        [self getListofAllCustomers:jsonData];
        
        
    } andErrorBlock:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [load stop];
            [load waringLabelText:@"Error Loading" onView:self.view];
            
        });
        
    }];
}
-(void)getListofAllCustomers:(NSData*)cList
{
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:cList options:0 error:nil];
    NSError *err;
    customersList=[CustomerDataModel arrayOfModelsFromDictionaries:arr error:&err];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self sortCustomersintoSections];
        [load stop];
    });
}

#pragma mark componentsShapes

-(void)defaultComponentsStyle
{
    [_searchTextField setPadding];
    [_searchTextField setRightPadding];
 
    // the space between the image and text
    CGFloat width = _appointmentsBtn.frame.size.width;
    CGFloat height = _appointmentsBtn.frame.size.height;
    
    // lower the text and push it left so it appears centered
    //  below the image
    _appointmentsBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    _appointmentsBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // increase the content height to avoid clipping
}


#pragma mark Collection View Delegates
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return cvAlphabetSectionArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    NSArray *arr=[cvDataSectionArr objectAtIndex:section];
    return arr.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{

    CustomerCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuse forIndexPath:indexPath];
    [cell bindData:cvDataSectionArr[indexPath.section][indexPath.row]];
    [cell loadSelectedCustomerFromArrat:selectedCustomerList];
    if(indexPath.row%2==0)
    {
        cell.trailingContraint.constant=scr_width/20.0;
        cell.leadingConstraint.constant=scr_width/20.0;
        
        cell.borderTrailing.constant=0.0;
        cell.borderLeading.constant=scr_width/20.0;
    }
    else if(indexPath.row%2!=0)
    {
        cell.trailingContraint.constant=scr_width/20.0;
        cell.leadingConstraint.constant=scr_width/20.0;
        cell.borderTrailing.constant=scr_width/20.0;
        cell.borderLeading.constant=0.0;
    }
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomerCell *cell=(CustomerCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell saveSelectedCustomertoArray:selectedCustomerList];
    [self.collectionView reloadData];
    [self showSelectedCustmrsInScrlView];
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.alphabetCell.text=cvAlphabetSectionArr[indexPath.section];
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize mElementSize = CGSizeMake(scr_width/2,135.0);
    return mElementSize;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size
          withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
         [self.collectionView.collectionViewLayout invalidateLayout];
     }
                                 completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
     {
     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menubuttonClick:(id)sender {
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addCustomer:(id)sender {
}

- (IBAction)appointments:(id)sender {
}

- (IBAction)gemMarketing:(id)sender {
}


-(void)showSelectedCustmrsInScrlView{
    
    for (CustomLabel *lbl in _scrollView_selCustmr.subviews){
        [lbl removeFromSuperview];
    }
    
    int X=scr_width/20,Y=0;
    CustomLabel *lbl;
    for (int i=0; i<selectedCustomerList.count; i++)
    {
        CustomerDataModel *cst=selectedCustomerList[i];
        lbl=[[CustomLabel alloc]init];
        [_scrollView_selCustmr addSubview:lbl];
        lbl.text=[cst.Name stringByAppendingString:@","];
        lbl.frame=CGRectMake(X, Y, lbl.intrinsicContentSize.width, 30);
        [lbl setAdjustsFontSizeToFitWidth:YES];
        X+=lbl.intrinsicContentSize.width;
    }
    _scrollView_selCustmr.contentSize=CGSizeMake(X+lbl.intrinsicContentSize.width, 0);    
}


@end
