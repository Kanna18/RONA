 //
//  CustomersViewController.m
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "CustomersViewController.h"

static NSString *reuse=@"reuseCustomerCell";


@interface CustomersViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation CustomersViewController{
    
    NSArray *alphabets;
    ServerAPIManager *serverAPI;
    NSMutableArray *customersList, *cvDataSectionArr,*cvAlphabetSectionArr;
    LoadingView *load;
    RESTCalls *rest;
    CGFloat scr_width,scr_height;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    
    load=[[LoadingView alloc]init];
    rest=[[RESTCalls alloc]init];
        
    _searchTextField.delegate=self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchEnabled) name:UITextFieldTextDidChangeNotification object:nil];
        
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionHeadersPinToVisibleBounds=YES;
    collectionViewLayout.minimumInteritemSpacing = 0;
    collectionViewLayout.minimumLineSpacing = 0;
    
    

    
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    alphabets=@[@"A",@"B",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
    [self defaultComponentsStyle];
    
    serverAPI=[ServerAPIManager sharedinstance];
    customersList=[[NSMutableArray alloc]init];
    [load loadingWithlightAlpha:self.view with_message:@"Loading customers"];
    [load start];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Customers" ofType:@"json"];
  
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if([fileManager fileExistsAtPath:[docPath stringByAppendingPathComponent:customersFilePath]]){
                [self getListofAllCustomers:[rest readJsonDataFromFileinNSD:customersFilePath]];
            }
            else{
                [self restServiceForCustomerList];
            }
        });
    _swipe.numberOfTouchesRequired=noOfTouches;
    _swipe.direction=UISwipeGestureRecognizerDirectionLeft;
    _swipeHome.numberOfTouchesRequired=noOfTouches;
    _swipeHome.direction=UISwipeGestureRecognizerDirectionRight;
    
    _searchTextField.font=gothMedium(23);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    scr_width=_collectionView.frame.size.width;
    scr_height=_collectionView.frame.size.height;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [_collectionView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:UITextFieldTextDidChangeNotification];
}

#pragma mark TextField Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    _searchTextField.placeholder=@"";
//    [UIView animateWithDuration:0.5 animations:^{
//    [textField setLeftpasswordPadding];
//    }];
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
//    _searchTextField.placeholder=@"Search";
//    [UIView animateWithDuration:0.5 animations:^{
//    [textField middlePadding];
//    }];
    return YES;
}

-(void)searchEnabled{
    NSLog(@"SearchField Text->%@",_searchTextField.text);
    [self sortCustomersintoSectionsandSearchFunctionality:_searchTextField.text];
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

-(void)sortCustomersintoSectionsandSearchFunctionality:(NSString*)searchStr
{
    cvDataSectionArr=[[NSMutableArray alloc]init];
    cvAlphabetSectionArr=[[NSMutableArray alloc]init];
    if(!(searchStr.length>0))
    {
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
    }
    else if(searchStr)
    {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF.Name BEGINSWITH[c] %@",searchStr,searchStr];
        NSArray *arr=[customersList filteredArrayUsingPredicate:predicate];
        [cvDataSectionArr addObject:arr];
        [cvAlphabetSectionArr addObject:@""];
    }
    [self.collectionView reloadData];
    [self alphabetsScrollIndex];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


-(void)restServiceForCustomerList
{
    
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"authorization": [@"Bearer " stringByAppendingString:defaultGet(kaccess_token)]};
    NSDictionary *parameters = @{ @"userName": defaultGet(savedUserEmail)};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:rest_customersList_B]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingAllowFragments error:nil];
                                          NSData *jsonData=[NSJSONSerialization dataWithJSONObject:arr options:0 error:nil];
                                          NSError *cerr;
                                          [rest writeJsonDatatoFile:jsonData toPathExtension:customersFilePath error:cerr];
                                          [self getListofAllCustomers:jsonData];
                                          
                                      }];
    
    [dataTask resume];
    
    
}



#pragma mark Server Calls

-(void)getListofAllCustomers:(NSData*)cList
{
    NSArray *arr=[NSJSONSerialization JSONObjectWithData:cList options:0 error:nil];
    NSError *err;
    customersList=[CustomerDataModel arrayOfModelsFromDictionaries:arr error:&err];
    [self sortCustomersintoSectionsandSearchFunctionality:nil];
    [load stop];
}

#pragma mark componentsShapes

-(void)defaultComponentsStyle
{
    [_searchTextField setPadding];
    _scrollView_selCustmr.layer.cornerRadius=5.0f;
    _collectionView.showsVerticalScrollIndicator=NO;
//    [_searchTextField middlePadding];
    _searchTextField.delegate=self;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backButton:)];
    tap.numberOfTouchesRequired=1;
    [_headingLabel addGestureRecognizer:tap];
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
    [cell loadSelectedCustomerFromArrat:selectedCustomersList];
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
    [cell saveSelectedCustomertoArray:selectedCustomersList];
    [self.collectionView reloadData];
    [self showSelectedCustmrsInScrlView];

    if(_searchTextField.text.length>0)
    {
     _searchTextField.text=@"";
        [self sortCustomersintoSectionsandSearchFunctionality:_searchTextField.text];
        [self.view endEditing:YES];
    }

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
    
    CGSize mElementSize = CGSizeMake(scr_width/2,100.0);
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


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender
{
    if([identifier isEqualToString:@"customerDetailsSegue"])
    {
        if(!([selectedCustomersList count]>0))
        {
            [load waringLabelText:@"Select Atleast One Customer" onView:self.view];
            return NO;
        }
        else{
            return YES;
        }
    }
    
    return NO;
}
- (IBAction)menubuttonClick:(id)sender {
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)jumptoMenuVC:(id)sender
{
    MenuViewController *men=[self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    [self.navigationController popToViewController:men animated:YES];
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
    
    int X=92,Y=5;
    CustomLabel *lbl;
    for (int i=0; i<selectedCustomersList.count; i++)
    {
        CustomerDataModel *cst=selectedCustomersList[i];
        lbl=[[CustomLabel alloc]init];
        lbl.font=gothMedium(10);
        lbl.textColor=RGB(45, 45, 45);
        [_scrollView_selCustmr addSubview:lbl];
        lbl.text=[cst.Name stringByAppendingString:@", "];
        lbl.frame=CGRectMake(X, Y, lbl.intrinsicContentSize.width, 30);
        [lbl setAdjustsFontSizeToFitWidth:YES];
        X+=lbl.intrinsicContentSize.width;
    }
    _scrollView_selCustmr.contentSize=CGSizeMake(X+lbl.intrinsicContentSize.width, 0);    
}
-(void)alphabetsScrollIndex
{
    int Xa=0, Ya=0;
    CGFloat height=_aplhabetsIndexScroll.frame.size.height;
    for (int i=0; i<cvAlphabetSectionArr.count; i++)
    {
        CustomButton *letter=[CustomButton buttonWithType:UIButtonTypeCustom];
        letter.frame=CGRectMake(Xa, Ya, 40, height/cvAlphabetSectionArr.count);
        [letter setTitle:cvAlphabetSectionArr[i] forState:UIControlStateNormal];
        [letter setBackgroundColor:[UIColor clearColor]];
        [letter setTitleColor:BlueClr forState:UIControlStateNormal];
        Ya+=height/cvAlphabetSectionArr.count;
        letter.titleLabel.font=gothMedium(9);
        [_aplhabetsIndexScroll addSubview:letter];
        letter.tag=i+100;
        [letter addTarget:self action:@selector(clickedOnAlphabet:) forControlEvents:UIControlEventTouchUpInside];
    }
}


-(void)clickedOnAlphabet:(CustomButton*)sender
{
    if(_searchTextField.text.length>0)
    {
        _searchTextField.text=@"";
        [self sortCustomersintoSectionsandSearchFunctionality:_searchTextField.text];
        [self.view endEditing:YES];
    }
    
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:0 inSection:sender.tag-100];
        [self.collectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionTop animated:YES];

}
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    NSLog(@"--->velocity-%@, offset-%@",NSStringFromCGPoint(velocity),NSStringFromCGPoint(*targetContentOffset));
//    [_collectionView setContentOffset:CGPointMake(0, 1000) animated:YES];
//}
-(IBAction)pushtoNextVC:(id)sender
{
    if(ronakGlobal.selectedCustomersArray.count>0)
    {
        ShippingAddressViewController *shv=storyBoard(@"shippingVC");
        [self.navigationController pushViewController:shv animated:YES];
    }
    else
    {
        showMessage(@"Select Atleast One Customer", self.view);
    }
}
@end
