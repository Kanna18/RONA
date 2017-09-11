//
//  ProductsListController.m
//  RONAK
//
//  Created by Gaian on 8/12/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ProductsListController.h"
#import "Calculator.h"

@interface ProductsListController ()

@end

@implementation ProductsListController{
    
    NSArray *imagesArray;
    int index;
    
    CGFloat height;
    unsigned long Section;
    
    NSArray *filtersArr;
    
    CGRect curretDetailinfoFrame;
    UIScrollView *ZoomscrollVw;
    UIImageView *zoomimageV;
    
    NSArray *showItemsOnscrnArry;
    
    Calculator *cal;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    index=0;
//    imagesArray=@[@"Angel1",@"Angel2",@"Angel3",@"Angel4",@"Angel5"];
    UICollectionViewFlowLayout *productsViewLayout = (UICollectionViewFlowLayout*)self.productsCollectionView.collectionViewLayout;
    productsViewLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    UICollectionViewFlowLayout *customersViewLayout = (UICollectionViewFlowLayout*)self.customersCollectionView.collectionViewLayout;
    customersViewLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    customersViewLayout.minimumInteritemSpacing = 0;
    customersViewLayout.minimumLineSpacing = 0;

    [self defaultShapesOfComponents];
    [self getProductItemsFilter];
    [self zoomImageFunctionality];
    
}

-(void)getProductItemsFilter{
    LoadingView* load=[[LoadingView alloc]init];
    [load loadingWithlightAlpha:_productsCollectionView with_message:@""];
    [load start];

    
    DownloadProducts *dow=[[DownloadProducts alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        ronakGlobal.filterdProductsArray=[dow pickProductsFromFilters];
        [_productsCollectionView reloadData];
        if(ronakGlobal.filterdProductsArray.count>0)
            [self changeLablesBasedOnitemsIndex:0];
        [load stop];
    });
}

-(void)divideWholeitemsintoCategories
{
    
}

-(void)defaultShapesOfComponents
{
    [self drawBorders:_pSymbol];
    [self drawBorders:_saleBtn];
    [self drawBorders:_allColoursBtn];
    
    _searchEveryWhereOptn.layer.cornerRadius=10;
    _searchEveryWhereOptn.clipsToBounds=YES;
    _discountVw.layer.borderWidth=2.0;
    _discountVw.layer.borderColor=RGB(69, 69, 69).CGColor;
    
    _sideMenuButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _sideMenuButton.layer.borderWidth=1.0f;
    _sideMenuButton.layer.shadowColor=[UIColor lightGrayColor].CGColor;
    _sideMenuButton.layer.shadowOffset=CGSizeMake(2.0, 2.0);
    _sideMenuButton.layer.shadowRadius=2.0f;
    _sideMenuButton.layer.shadowOpacity=2.0f;
    
    
    
    
    _allColorsTopBtn.imageEdgeInsets=UIEdgeInsetsMake(4, 0, 4 , _allColorsTopBtn.frame.size.width-20);
    _allModelsTopBtn.imageEdgeInsets=UIEdgeInsetsMake(4, 0, 4 , _allColorsTopBtn.frame.size.width-20);
    
    _allColorsTopBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -50, 0,-20);
    _allModelsTopBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -50, 0,-20);
    
    
    _pricingLabel.hidden=YES;
    _wsLabel.hidden=YES;
    [_pricingLabel setAdjustsFontSizeToFitWidth:YES];
    [_wsLabel setAdjustsFontSizeToFitWidth:YES];
    
    _pricingSwitch.onTintColor=[UIColor whiteColor];
    
    _cartOption.imageEdgeInsets=UIEdgeInsetsMake(0, 30, 0, 30);
    _cartOption.layer.borderWidth=1.0f;
    _cartOption.layer.borderColor=GrayLight.CGColor;
    _cartOption.layer.cornerRadius=5.0f;
    _cartOption.clipsToBounds=YES;
    
    _sortOption.imageEdgeInsets=UIEdgeInsetsMake(0, 30, 0, 30);
    _sortOption.layer.borderWidth=1.0f;
    _sortOption.layer.borderColor=GrayLight.CGColor;
    _sortOption.layer.cornerRadius=5.0f;
    _sortOption.clipsToBounds=YES;
    
    [_customersCollectionView setShowsHorizontalScrollIndicator:NO];

    [_searchField setPadding];
    _searchField.layer.cornerRadius=5.0f;
    
    _searchEveryWhereOptn.layer.cornerRadius=5.0f;
    
    UITapGestureRecognizer *taped=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumptoMenuVC:)];
    taped.numberOfTouchesRequired=1;
    [_ronakheadingLabel addGestureRecognizer:taped];
    
    _discountLabel.adjustsFontSizeToFitWidth=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Collection View Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    if(collectionView==self.customersCollectionView)
    {
        return ronakGlobal.selectedCustomersArray.count;
    }
    if(collectionView==self.productsCollectionView)
    {
        return ronakGlobal.filterdProductsArray.count;
    }
    return 0;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if(collectionView==self.productsCollectionView)
    {
        ProductCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"productCVCell" forIndexPath:indexPath];
        if(cell==nil)
        {
            cell=[[ProductCollectionViewCell alloc]init];
        }
        if([ronakGlobal.item isEqual:ronakGlobal.filterdProductsArray[indexPath.row]])
        {
            cell.bordrrViewColor.backgroundColor=RGB(188, 1, 28);
        }
        else
        {
            cell.bordrrViewColor.backgroundColor=RGB(207, 207, 207);
        }
        [cell bindData:ronakGlobal.filterdProductsArray[indexPath.row]];
        return cell;
    }
    if(collectionView==self.customersCollectionView)
    {
        CustomerViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"customerViewCellReuse" forIndexPath:indexPath];
        if(cell==nil)
        {
            cell=[[CustomerViewCell alloc]init];
        }
        cell.delegate=self;
        cell.layer.borderWidth=1.0f;
        [cell bindData:ronakGlobal.selectedCustomersArray[indexPath.row]];
        cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
        return cell;
    }
    return nil;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView==_productsCollectionView)
    {
        [self changeLablesBasedOnitemsIndex:(int)indexPath.row];
        [collectionView reloadData];
        [_customersCollectionView reloadData];
        
        ItemMaster *item=ronakGlobal.filterdProductsArray[indexPath.row];
        Filters *fil=item.filters;
        NSLog(@"%@",fil);
    }
    if(collectionView == _customersCollectionView)
    {
        
    }
}

-(void)drawBorders:(id)element{
    
    if([element isKindOfClass:[CustomButton class]]||[element isKindOfClass:[UIButton class]])
    {
        CustomButton *cst=element;
        cst.layer.borderColor=[UIColor lightGrayColor].CGColor;
        cst.layer.borderWidth=1.0f;
        cst.layer.shadowColor=[UIColor lightGrayColor].CGColor;
        cst.layer.shadowOffset=CGSizeMake(1.0, 1.0);
        cst.layer.shadowRadius=1.0f;
        cst.layer.shadowOpacity=1.0f;
    }
}

-(void)changeLablesBasedOnitemsIndex:(int)myIndex
{
    
    ItemMaster *item=ronakGlobal.filterdProductsArray[myIndex];
//    imagesArray=@[item.filters.picture_Name__c];
    NSString  *path=[[docPath stringByAppendingPathComponent:@"IMAGES/ITEM IMAGES"] stringByAppendingPathComponent:item.filters.picture_Name__c];
    UIImage *image=[UIImage imageNamed:path];
    _detailedImageView.image=image;
    _itemSizeLabel.text=item.filters.size__c;
    _selectedItemDesc.text=item.filters.item_Description__c;
    _pricingLabel.text=[@"MRP:₹" stringByAppendingString:item.filters.mRP__c];
    _discountLabel.text=[item.filters.discount__c stringByAppendingString:@"%"];
    _itemSizeLabel.text=item.filters.size__c;
    _wsLabel.text=[[@"WS:₹" stringByAppendingString:item.filters.wS_Price__c] stringByAppendingString:@"/"];
    [_allColoursBtn setTitle:item.filters.color_Code__c forState:UIControlStateNormal];
    _itemModelNameLabel.text=item.filters.group_Name__c;
    
    ronakGlobal.item=item;
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillDisappear:(BOOL)animated
{
    _sideView.hidden=YES;
    [super viewWillDisappear:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    _sideView.hidden=NO;
}
- (IBAction)searchEveryWhereClick:(id)sender {
    
    if(_searchEveryWhereOptn.selected==YES)
    {
      _searchEveryWhereOptn.selected=NO;
        [_searchEveryWhereOptn setBackgroundImage:[UIImage imageNamed:@"checkBlue"] forState:UIControlStateNormal];
    }
    else
    {
        [_searchEveryWhereOptn setBackgroundImage:nil forState:UIControlStateNormal];
        _searchEveryWhereOptn.selected=YES;
    }
}
- (IBAction)dismissViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)listImagesArray:(id)sender
{
    if(!(imagesArray.count<=0))
    {
        UIButton *but=sender;
        switch (but.tag) {
            case 100:
                if(!(index<=0))
                {
                    index--;
                    
                }
                if(index==0)
                {
                    index=(int)imagesArray.count-1;
                }
                break;
                
            case 200:
                if(index<imagesArray.count-1)
                {
                    index++;
                }
                if(index==imagesArray.count-1)
                {
                    index=0;
                }
                break;
                
            default:
                break;
        }
        _detailedImageView.image=[UIImage imageNamed:imagesArray[index]];
    }
    
}
-(void)customerNameDeleted
{
    [_customersCollectionView reloadData];
}



- (IBAction)sideMenuClick:(id)sender {
    
    CGRect newFrame=_sideView.frame;
    CGRect mainFrame=_containerView.frame;
    if(newFrame.origin.x==0)
    {
        newFrame.origin.x=-300;
        mainFrame.origin.x=0;
        [self getProductItemsFilter];
    }
    else
    {
        newFrame.origin.x=0;
        mainFrame.origin.x=350;
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _sideView.frame=newFrame;
//        _containerView.frame=mainFrame;
       
    }];
}



- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
//- (IBAction)jumptoMenuVC:(id)sender
//{
//    MenuViewController *men=[self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
//    [self.navigationController popToViewController:men animated:YES];
//}


- (IBAction)priceSwitchChanged:(id)sender {

    _pricingSwitch=sender;
    if(_pricingSwitch.isOn)
    {
        _pricingLabel.hidden=YES;
        _wsLabel.hidden=YES;
    }
    else
    {
        _pricingLabel.hidden=NO;
        _wsLabel.hidden=NO;
    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        _pricingLabel.hidden=YES;
//        _wsLabel.hidden=YES;
//    });

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

-(void)zoomImageFunctionality
{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedImage:)];
    tap.numberOfTapsRequired=2;
    [_detailedImageView addGestureRecognizer:tap];
}
-(void)tappedImage:(id)sender
{
    ZoomscrollVw = [[UIScrollView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2, 0, 0)];
    ZoomscrollVw.backgroundColor = [UIColor blackColor];
    zoomimageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    zoomimageV.backgroundColor=[UIColor whiteColor];
    zoomimageV.contentMode=UIViewContentModeScaleAspectFit;
    [ZoomscrollVw addSubview:zoomimageV];
    zoomimageV.image=_detailedImageView.image;
    zoomimageV.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedScrollView:)];
    tap.numberOfTapsRequired=2;
    [ZoomscrollVw addGestureRecognizer:tap];
    
    
    
    if(_detailedImageView.highlighted==YES){
        
        _detailedImageView.highlighted=NO;
        [ZoomscrollVw removeFromSuperview];
        
    }
    else{
        _detailedImageView.highlighted=YES;
        [self.view.window addSubview:ZoomscrollVw];
        [UIView animateWithDuration:0.4 animations:^{
            ZoomscrollVw.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }];
     }
    UISwipeGestureRecognizer *swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showNextImageonZoom:)];
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [zoomimageV addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRgt=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showNextImageonZoom:)];
    swipeRgt.direction=UISwipeGestureRecognizerDirectionRight;
    [zoomimageV addGestureRecognizer:swipeRgt];
}
-(void)showNextImageonZoom:(UISwipeGestureRecognizer*)sender
{
    if(!(imagesArray.count<=0))
    {
        
        if(sender.direction==UISwipeGestureRecognizerDirectionLeft)
        {
            if(!(index<=0))
            {
                index--;
                
            }
            if(index==0)
            {
                index=(int)imagesArray.count-1;
            }
        }
        
        if(sender.direction==UISwipeGestureRecognizerDirectionRight)
        {
            if(index<imagesArray.count-1)
            {
                index++;
            }
            if(index==imagesArray.count-1)
            {
                index=0;
            }
        }
        zoomimageV.image=[UIImage imageNamed:imagesArray[index]];
    }
    
}
-(void)tappedScrollView:(id)sender
{
    [ZoomscrollVw removeFromSuperview];
}
- (IBAction)allmodelTopClick:(id)sender {
    
    if(_allModelsTopBtn.selected==YES)
    {
        _allModelsTopBtn.selected=NO;
        [_allModelsTopBtn setImage:[UIImage imageNamed:@"grayBackground"] forState:UIControlStateNormal];
    }
    else
    {
        _allModelsTopBtn.selected=YES;
        [_allModelsTopBtn setImage:[UIImage imageNamed:@"checkBlue"] forState:UIControlStateNormal];
    }
}

- (IBAction)allColorsTopClick:(id)sender {
    
    if(_allColorsTopBtn.selected==YES)
    {
        _allColorsTopBtn.selected=NO;
        [_allColorsTopBtn setImage:[UIImage imageNamed:@"grayBackground"] forState:UIControlStateNormal];
    }
    else
    {
        _allColorsTopBtn.selected=YES;
        [_allColorsTopBtn setImage:[UIImage imageNamed:@"checkBlue"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)cancelOrderClick:(id)sender {
    
    _cancelOrderBtn.selected=_cancelOrderBtn.selected?NO:YES;
    if(ronakGlobal.showClearOptionInCustomerCell)
    {
        ronakGlobal.showClearOptionInCustomerCell=NO;
    }
    else
    {
        ronakGlobal.showClearOptionInCustomerCell=YES;
    }
    [_customersCollectionView reloadData];
}

- (IBAction)calculatorClick:(id)sender {
    
        if(_calculatorBtn.selected==NO)
        {
            CGRect frame= _calculatorBtn.frame;
            //cal=[[Calculator alloc]initWithFrame:CGRectMake(frame.origin.x-40,self.view.frame.size.height-350-70,350,350)];
            
            
            cal=[[Calculator alloc]initWithFrame:CGRectMake(frame.origin.x-45,self.view.frame.size.height-330-70,212,330)];
            
            _calculatorBtn.selected=YES;
            [self.view addSubview:cal];
        }
        else
        {
            [cal removeFromSuperview];
            _calculatorBtn.selected=NO;
        }
}
- (IBAction)clearCartClick:(id)sender {
    
        [ronakGlobal.selectedCustomersArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CustomerDataModel *cst=obj;
            [cst.defaultsCustomer.itemsCount removeAllObjects];
        }];    
    [_customersCollectionView reloadData];
}
@end

