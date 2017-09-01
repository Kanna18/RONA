//
//  ProductsListController.m
//  RONAK
//
//  Created by Gaian on 8/12/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ProductsListController.h"

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    index=0;
    imagesArray=@[@"Angel1",@"Angel2",@"Angel3",@"Angel4",@"Angel5",@"Angel6"];
    UICollectionViewFlowLayout *productsViewLayout = (UICollectionViewFlowLayout*)self.productsCollectionView.collectionViewLayout;
    productsViewLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    UICollectionViewFlowLayout *customersViewLayout = (UICollectionViewFlowLayout*)self.customersCollectionView.collectionViewLayout;
    customersViewLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    customersViewLayout.minimumInteritemSpacing = 0;
    customersViewLayout.minimumLineSpacing = 0;

    [self defaultShapesOfComponents];
    _detailedImageView.image=[UIImage imageNamed:imagesArray[index]];
    
    [self getProductItemsFilter];
    
    _filterTable.delegate=self;
    _filterTable.dataSource=self;

    _filterTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
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
-(void)viewWillAppear:(BOOL)animated
{
    NSMutableArray *allFil=[[NSMutableArray alloc]init];
    [ronakGlobal.advancedFilters1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [allFil addObject:obj];
        
    }];
    [ronakGlobal.advancedFilters2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [allFil addObject:obj];
    }];
    filtersArr=allFil;
   _filterTable.hidden=NO;
    [super viewWillAppear:YES];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [_filterTable reloadData];
}

-(void)defaultShapesOfComponents
{
    [self drawBorders:_pSymbol];
    [self drawBorders:_saleBtn];
    [self drawBorders:_allColoursBtn];
    
    _searchEveryWhereOptn.layer.cornerRadius=10;
    _searchEveryWhereOptn.clipsToBounds=YES;
    _discountLabel.font=sfFont(42);
    _discountVw.layer.borderWidth=2.0;
    _discountVw.layer.borderColor=[UIColor blackColor].CGColor;
    
    _sideMenuButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _sideMenuButton.layer.borderWidth=1.0f;
    _sideMenuButton.layer.shadowColor=[UIColor lightGrayColor].CGColor;
    _sideMenuButton.layer.shadowOffset=CGSizeMake(2.0, 2.0);
    _sideMenuButton.layer.shadowRadius=2.0f;
    _sideMenuButton.layer.shadowOpacity=2.0f;
    
    
    _filterTable.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _filterTable.layer.borderWidth=1.0f;
    _filterTable.layer.shadowColor=[UIColor lightGrayColor].CGColor;
    _filterTable.layer.shadowOffset=CGSizeMake(2.0, 2.0);
    _filterTable.layer.shadowRadius=5.0f;
    _filterTable.layer.shadowOpacity=1.0f;
    
    _pricingLabel.hidden=YES;
    _wsLabel.hidden=YES;
    
    _pricingSwitch.onTintColor=[UIColor whiteColor];

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
            cell.bordrrViewColor.backgroundColor=RedClr;
        }
        else
        {
            cell.bordrrViewColor.backgroundColor=GrayLight;
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
    _itemSizeLabel.text=item.filters.size__c;
    _selectedItemDesc.text=item.filters.item_Description__c;
    _pricingLabel.text=[@"MRP:₹" stringByAppendingString:item.filters.mRP__c];
    _discountLabel.text=[item.filters.discount__c stringByAppendingString:@"%"];
    _itemSizeLabel.text=item.filters.size__c;
    _wsLabel.text=[@"WS:₹" stringByAppendingString:item.filters.wS_Price__c];
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
    [super viewWillDisappear:YES];
    _filterTable.hidden=YES;
}
- (IBAction)searchEveryWhereClick:(id)sender {
}
- (IBAction)dismissViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)listImagesArray:(id)sender
{
    UIButton *but=sender;
    switch (but.tag) {
        case 100:
            if(!(index<=0))
            index--;
            break;
            
        case 200:
            if(index<imagesArray.count-1)
            index++;
            break;
            
        default:
            break;
    }
    _detailedImageView.image=[UIImage imageNamed:imagesArray[index]];
}
-(void)customerNameDeleted
{
    [_customersCollectionView reloadData];
}



- (IBAction)sideMenuClick:(id)sender {
    
    CGRect newFrame=_sideView.frame;
    CGRect mainFrame=_containerView.frame;
    [_filterTable reloadData];
    if(newFrame.origin.x==0)
    {
        newFrame.origin.x=-300;
        mainFrame.origin.x=0;
        [_sideMenuButton setSelected:NO];

    }
    else
    {
        newFrame.origin.x=0;
        mainFrame.origin.x=350;
        [_sideMenuButton setSelected:YES];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _sideView.frame=newFrame;
//        _containerView.frame=mainFrame;
       
    }];
}


- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)jumptoMenuVC:(id)sender
{
    MenuViewController *men=[self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    [self.navigationController popToViewController:men animated:YES];
}



- (IBAction)priceSwitchChanged:(id)sender {

    _pricingSwitch=sender;
    if(_pricingSwitch.isOn)
    {
        _pricingLabel.hidden=YES;
        _wsLabel.hidden=NO;
    }
    else
    {
        _pricingLabel.hidden=NO;
        _wsLabel.hidden=YES;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _pricingLabel.hidden=YES;
        _wsLabel.hidden=YES;
    });

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
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [ZoomscrollVw addSubview:imageV];
    imageV.image=_detailedImageView.image;
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
}
-(void)tappedScrollView:(id)sender
{
    [ZoomscrollVw removeFromSuperview];
}
@end

