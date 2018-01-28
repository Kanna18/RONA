//
//  ProductsListController.m
//  RONAK
//
//  Created by Gaian on 8/12/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "ProductsListController.h"
#import "Calculator.h"
#import "CategoryBased.h"
#import "StockListView.h"

@interface ProductsListController ()<GestureProtocol,UITextFieldDelegate>

@end

@implementation ProductsListController{
    
    NSMutableArray *imagesArray;
    int index, categoryIndex,modelIndex;
    
    CGFloat height;
    unsigned long Section;
    
    NSArray *filtersArr;
    
    CGRect curretDetailinfoFrame;
    UIScrollView *ZoomscrollVw;
    UIImageView *zoomimageV;
    
    NSMutableArray *showItemsOnscrnArry;
    
    Calculator *cal;
    
    NSMutableArray *categoryBasedSort;
    StockListView *stockListCountView;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do additional setup after loading the view.
    
    index=0;
    modelIndex=0;
    categoryIndex=0;
//    imagesArray=@[@"Angel1",@"Angel2",@"Angel3",@"Angel4",@"Angel5"];
    imagesArray=[[NSMutableArray alloc]init];
    UICollectionViewFlowLayout *productsViewLayout = (UICollectionViewFlowLayout*)self.productsCollectionView.collectionViewLayout;
    productsViewLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    UICollectionViewFlowLayout *customersViewLayout = (UICollectionViewFlowLayout*)self.customersCollectionView.collectionViewLayout;
    customersViewLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    customersViewLayout.minimumInteritemSpacing = 5;
    customersViewLayout.minimumLineSpacing = 0;
    _customersCollectionView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor clearColor]);
    [self defaultShapesOfComponents];
    [self getProductItemsFilter];
    [self zoomImageFunctionality];
//    _detailedImageView.image=[UIImage imageNamed:imagesArray[0]];
    
    stockListCountView=[[StockListView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    stockListCountView.hidden=YES;
    [self.productsCollectionView addSubview:stockListCountView];
    _searchField.delegate=self;

}

-(void)getProductItemsFilter{
    LoadingView* load=[[LoadingView alloc]init];
    [load loadingWithlightAlpha:_productsCollectionView with_message:@""];
    [load start];

    
    DownloadProducts *dow=[[DownloadProducts alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        ronakGlobal.filterdProductsArray=[dow pickProductsFromFilters];
        NSLog(@"%lu",(unsigned long)ronakGlobal.filterdProductsArray.count);
        if(ronakGlobal.filterdProductsArray.count>0)
        {
            CategoryBased *cat=[[CategoryBased alloc]initWithArray:ronakGlobal.filterdProductsArray];
            categoryBasedSort=[cat returnSortedItems];
            [self divideWholeitemsintoCategories];
        }
        [load stop];
    });
    
}
-(void)divideWholeitemsintoCategories
{
    ModelBased *model=categoryBasedSort[categoryIndex];
    ColorBased *col=model.ColorsArray[modelIndex];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"filters.color_Code__c" ascending:YES];
    NSArray *sort=[col.listItemsArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    showItemsOnscrnArry=(NSMutableArray*)sort;
    [self changeLablesBasedOnitemsIndex:0];
    _displayLable.text=[NSString stringWithFormat:@"%lu/%lu",(unsigned long)modelIndex+1,(unsigned long)model.ColorsArray.count];
    [ronakGlobal.selectedItemsTocartArr removeAllObjects];
    [ronakGlobal.selectedItemsTocartArr addObject:showItemsOnscrnArry[0]];
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
    
    _allColorsTopBtn.imageEdgeInsets=UIEdgeInsetsMake(10, 5, 4 , _allColorsTopBtn.frame.size.width-20);
    _allModelsTopBtn.imageEdgeInsets=UIEdgeInsetsMake(10, 5, 4 , _allColorsTopBtn.frame.size.width-20);
    
    _allColorsTopBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -50, 3,-20);
    _allModelsTopBtn.titleEdgeInsets=UIEdgeInsetsMake(0, -55, 3,-25);
    
    _pricingLabel.hidden=YES;
    _wsLabel.hidden=YES;
    [_pricingLabel setAdjustsFontSizeToFitWidth:YES];
    [_wsLabel setAdjustsFontSizeToFitWidth:YES];
    
    _pricingSwitch.onTintColor=[UIColor whiteColor];
    
    
    [_customersCollectionView setShowsHorizontalScrollIndicator:NO];

    [_searchField setPadding];
    _searchField.layer.cornerRadius=5.0f;
    
    _searchEveryWhereOptn.layer.cornerRadius=5.0f;
    
    UITapGestureRecognizer *taped=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumptoMenuVC:)];
    taped.numberOfTouchesRequired=1;
    [_ronakheadingLabel addGestureRecognizer:taped];
    
    _swipeUp.direction=UISwipeGestureRecognizerDirectionUp;
    _swipeUp.numberOfTouchesRequired=2;
    [_swipeUp addTarget:self action:@selector(swipeActions:)];
    
    _tripleSwipeUp.direction=UISwipeGestureRecognizerDirectionUp;
    _tripleSwipeUp.numberOfTouchesRequired=3;
    [_tripleSwipeUp addTarget:self action:@selector(swipeActions:)];
    
    _swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
    _swipeDown.numberOfTouchesRequired=2;
    [_swipeDown addTarget:self action:@selector(swipeActions:)];
    
    _tripleSwipeDown.direction=UISwipeGestureRecognizerDirectionDown;
    _tripleSwipeDown.numberOfTouchesRequired=3;
    [_tripleSwipeDown addTarget:self action:@selector(swipeActions:)];
    _discountLabel.adjustsFontSizeToFitWidth=YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_switchPr setOn:YES];
    });
    
    UISwipeGestureRecognizer *swipeMenu=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showSideMenuOnSwipe)];
    swipeMenu.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeMenu];
    _sideMenuButton.hidden=YES;
    
    UILongPressGestureRecognizer *btn_LongPress_gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleBtnLongPressgesture:)];
    [_switchPr addGestureRecognizer:btn_LongPress_gesture];
}

- (void)handleBtnLongPressgesture:(UILongPressGestureRecognizer *)recognizer{
    
    
    //as you hold the button this would fire
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        _pricingLabel.hidden=NO;
        _wsLabel.hidden=NO;
    }
    //as you release the button this would fire
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        _pricingLabel.hidden=YES;
        _wsLabel.hidden=YES;
    }
}

-(void)swipeActions:(UISwipeGestureRecognizer*)swipe
{
   
    _searchField.text=@"";
    if(showItemsOnscrnArry.count>0&&ronakGlobal.filterdProductsArray.count>0){
        
        _allModelsTopBtn.selected=NO;
        _allColorsTopBtn.selected=NO;
        _displayLable.hidden=NO;
        _allModelsTopBtn.enabled=YES;
        switch (swipe.numberOfTouches) {
                
            case 2:
            {
                ModelBased *model=categoryBasedSort[categoryIndex];
                
                if(swipe.direction==UISwipeGestureRecognizerDirectionUp)
                {
                    if(modelIndex<model.ColorsArray.count-1)
                    {
                        modelIndex++;
                    }
                    else
                    {
                        showMessage(@"No Models Available", self.view);
                    }
                }
                
                else if(swipe.direction==UISwipeGestureRecognizerDirectionDown)
                {
                    if(modelIndex>0)
                    {
                        modelIndex--;
                    }
                    else
                    {
                        showMessage(@"No Models Available", self.view);
                    }
                }
            }
                break;
                
                
            case 3:
                if(swipe.direction==UISwipeGestureRecognizerDirectionUp)
                {
                    if(categoryIndex<categoryBasedSort.count-1)
                    {
                        modelIndex=0;
                        categoryIndex++;
                    }
                    else
                    {
                        showMessage(@"No Products Available", self.view);
                    }
                    
                }
                else if(swipe.direction==UISwipeGestureRecognizerDirectionDown)
                {
                    if(categoryIndex>0)
                    {
                        modelIndex=0;
                        categoryIndex--;
                    }
                    else
                    {
                        showMessage(@"No Products Available", self.view);
                    }
                }
                
                break;
                
            default:
                break;
        }
        
        [self divideWholeitemsintoCategories];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of resources that can be recreated.
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
        return showItemsOnscrnArry.count;
    }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(collectionView==_customersCollectionView){
        if(ronakGlobal.selectedCustomersArray.count==1){
            CGSize mElementSize = CGSizeMake(_customersCollectionView.frame.size.width, 90.0);
            return mElementSize;
    }
    else{
        CGSize mElementSize = CGSizeMake(_customersCollectionView.frame.size.width/2, 90.0);
        return mElementSize;
        }
    }
    return CGSizeMake(120, 122);
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
        if([ronakGlobal.selectedItemsTocartArr containsObject:showItemsOnscrnArry[indexPath.row]])
        {
            cell.bordrrViewColor.backgroundColor=RGB(188, 1, 28);
        }
        else
        {
            cell.bordrrViewColor.backgroundColor=RGB(207, 207, 207);
        }
        [cell bindData:showItemsOnscrnArry[indexPath.row]];
        cell.delegate=self;
        
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
        [cell bindData:ronakGlobal.selectedCustomersArray[indexPath.row]];
        return cell;
    }
    return nil;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView==_productsCollectionView)
    {
        ItemMaster *item=showItemsOnscrnArry[indexPath.row];
        NSArray *arr=@[item];
        [self addOrRemoveItemsfromSelection:arr];
        [_customersCollectionView reloadData];
        [self changeLablesBasedOnitemsIndex:(int)indexPath.row];
        
    }
    if(collectionView == _customersCollectionView)
    {
        
    }
    
}

-(void)drawBorders:(id)element{
    
    UIView *cst=element;
    float shadowSize = 1.0f;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(cst.frame.origin.x - shadowSize / 2,
                                                                           cst.frame.origin.y - shadowSize / 2,
                                                                           cst.frame.size.width + shadowSize,
                                                                           cst.frame.size.height + shadowSize)];
////        cst.layer.borderColor=[UIColor lightGrayColor].CGColor;
////        cst.layer.borderWidth=1.0f;
//        cst.layer.shadowColor=[UIColor lightGrayColor].CGColor;
//        cst.layer.shadowOffset=CGSizeMake(2.0, 2.0);
//        cst.layer.shadowRadius=2.0f;
//        cst.layer.shadowOpacity=1.0f;
    cst.layer.masksToBounds = NO;
    cst.layer.shadowColor = [UIColor blackColor].CGColor;
    cst.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    cst.layer.shadowOpacity = 0.5f;
//    cst.layer.shadowPath = shadowPath.CGPath;

    
}
-(void)addOrRemoveItemsfromSelection:(NSArray*)arr
{
    ItemMaster *firstObj=arr[0];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ItemMaster *item=obj;
        
        if([ronakGlobal.selectedItemsTocartArr containsObject:item]){
            
            [ronakGlobal.selectedItemsTocartArr removeObject:item];
            if(ronakGlobal.selectedItemsTocartArr.count==0)
            {
                showMessage(@"Atleast One item must be selected", self.view);
                [ronakGlobal.selectedItemsTocartArr addObject:firstObj];
                return;
            }
        }
        else{
            [ronakGlobal.selectedItemsTocartArr addObject:item];
        }
    }];

    [_productsCollectionView reloadData];
}

-(void)changeLablesBasedOnitemsIndex:(int)myIndex
{
    ItemMaster *item=showItemsOnscrnArry[myIndex];
    NSArray *imgsPaths=[item.stock.imagesArr allObjects];
    NSLog(@"%@",item.filters.item_No__c);
    [imagesArray removeAllObjects];
    [imgsPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        ImagesArray *coreImg=obj;
        NSString  *path=[docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"IMAGES/%@",coreImg.imageName]];
        [imagesArray addObject:path];
    }];
    NSLog(@"%@",imagesArray);
//    NSString  *path=[[docPath stringByAppendingPathComponent:@"IMAGES/"] stringByAppendingPathComponent:imagesArray[0]];
    UIImage *image=[UIImage imageNamed:[imagesArray count]>0?imagesArray[0]:@""];
    _detailedImageView.image=image;
    _itemSizeLabel.text=item.filters.size__c;
    _selectedItemDesc.text=[NSString stringWithFormat:@"%@ %@ %@ %@",item.filters.brand__c,item.filters.product__c,item.filters.style_Code__c,item.filters.color_Code__c];
    _pricingLabel.text=[NSString stringWithFormat:@"₹%0.0f",item.filters.mRP__c];
    
    if(!(item.filters.discount__c>0))    {
        _discountVw.hidden=YES;
    }
    else{
    _discountLabel.text=[NSString stringWithFormat:@"%0.1f%%",item.filters.discount__c];
    }
    _itemSizeLabel.text=item.filters.size__c;
    _wsLabel.text=[NSString stringWithFormat:@"₹%0.0f/",item.filters.wS_Price__c];
    
    NSString *strSele=@"";
    if(_allModelsTopBtn.selected==YES){
        strSele=@"All Models";
    }
    else if (_allColorsTopBtn.selected==YES){
        strSele=@"All Colors";
    }
    else if (ronakGlobal.selectedItemsTocartArr.count>1){
        strSele=@"Multiple Colors";
    }
    else{
        strSele=item.filters.color_Code__c;
    }
    [_allColoursBtn setTitle:strSele forState:UIControlStateNormal];
    _itemModelNameLabel.text=item.filters.item_No__c;
    [_productsCollectionView reloadData];
//    ronakGlobal.item=item;
    index=0; //Count For imgages Array
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
    [self cartCount];
    [self.customersCollectionView reloadData];
    _sideView.hidden=NO;
}
- (IBAction)searchEveryWhereClick:(id)sender {
    
    if(_searchEveryWhereOptn.selected==YES)
    {
      _searchEveryWhereOptn.selected=NO;
//        [_searchEveryWhereOptn setBackgroundImage:[UIImage imageNamed:@"checkBlue"] forState:UIControlStateNormal];
    }
    else
    {
//        [_searchEveryWhereOptn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
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

#pragma mark CustomerCollectionView Delegate

-(void)customerNameDeleted
{
    [_customersCollectionView reloadData];
    [self cartCount];
}
-(void)cartCount
{
    __block unsigned long cartCount=0;
    [ronakGlobal.selectedCustomersArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CustomerDataModel *cst=obj;
        cartCount+=cst.defaultsCustomer.itemsCount.count;
        NSLog(@"%lu",cartCount);
    }];
    [_cartOption setTitle:[NSString stringWithFormat:@"%ld",cartCount] forState:UIControlStateNormal];

    
}


-(void)showSideMenuOnSwipe
{
    if(_sideMenuButton.hidden==YES){
    _sideMenuButton.hidden=NO;
    CGRect newFrame=_sideView.frame;
    CGRect mainFrame=_containerView.frame;
    newFrame.origin.x=0;
    mainFrame.origin.x=350;
    [UIView animateWithDuration:0.3 animations:^{
        _sideView.frame=newFrame;
        //        _containerView.frame=mainFrame;
        
    }];
    }
}
- (IBAction)sideMenuClick:(id)sender {
    
   
        _sideMenuButton.hidden=YES;
        CGRect newFrame=_sideView.frame;
        CGRect mainFrame=_containerView.frame;
        if(newFrame.origin.x==0)
        {
            newFrame.origin.x=-300;
            mainFrame.origin.x=0;
            [self getProductItemsFilter];
        }
        //    else
        //    {
        //        newFrame.origin.x=0;
        //        mainFrame.origin.x=350;
        //
        //    }
     dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            _sideView.frame=newFrame;
            //        _containerView.frame=mainFrame;
            
        }];
    });
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
    ZoomscrollVw.backgroundColor = [UIColor whiteColor];
    zoomimageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 700,600)];
    zoomimageV.center=ZoomscrollVw.center;
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
            else if(index==0)
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
            else if(index==imagesArray.count-1)
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

    if(showItemsOnscrnArry.count>0){
        
        _allColorsTopBtn.selected=NO;
        if(_allModelsTopBtn.selected==YES)
        {
            _allModelsTopBtn.selected=NO;
            [self divideWholeitemsintoCategories];
            
        }
        else{
            NSMutableArray *allItems=[[NSMutableArray alloc]init];
            _allModelsTopBtn.selected=YES;
            [categoryBasedSort enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray *arr=[obj valueForKeyPath:@"ColorsArray.listItemsArray"];
                [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [allItems addObjectsFromArray:obj];
                }];
            }];
            showItemsOnscrnArry=allItems;
        }
        [_productsCollectionView reloadData];
        [self changeLablesBasedOnitemsIndex:0];
    
    }
}

- (IBAction)allColorsTopClick:(id)sender {
    
    if(showItemsOnscrnArry.count>0){
        
        if(_allColorsTopBtn.selected==YES)
        {
            _allColorsTopBtn.selected=NO;
        }
        else
        {
            [ronakGlobal.selectedItemsTocartArr removeAllObjects];
            _allColorsTopBtn.selected=YES;
        }
        [self addOrRemoveItemsfromSelection:showItemsOnscrnArry];
        [self changeLablesBasedOnitemsIndex:0];
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
            
            
            cal=[[Calculator alloc]initWithFrame:CGRectMake(frame.origin.x-45,self.view.frame.size.height-330-60,212,330)];
            
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
    [_cartOption setTitle:@"0" forState:UIControlStateNormal];
    [_customersCollectionView reloadData];
}
- (IBAction)priceWithRupeeSymbolClick:(id)sender {
//    
//    SevenSwitch *seven=sender;
//    if(seven.isOn)
//    {
//        _pricingLabel.hidden=YES;
//        _wsLabel.hidden=YES;
//    }
//    else
//    {
//        _pricingLabel.hidden=NO;
//        _wsLabel.hidden=NO;
//    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqualToString:@"orderSummaryNavigate"])
    {
        BOOL cartValid = false;
        for (int i=0;i<ronakGlobal.selectedCustomersArray.count;i++){
            CustomerDataModel *cstDmo=ronakGlobal.selectedCustomersArray[i];
            if(!(cstDmo.defaultsCustomer.itemsCount.count>0)){
                cartValid = false;
                break;
            }else{
                cartValid = true;
            }
        }
        //        int CartCount=[[_cartOption currentTitle] intValue];
        //        if(CartCount>0)
        if(cartValid){
            return YES;
        }
        else{
            showMessage(@"Add items to all the Selected Customers", self.view);
            return NO;
        }
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(!stockListCountView.isHidden){
    stockListCountView.hidden=YES;
    }
}

-(void)showStockCountofProduct:(StockDetails *)st frame:(CGRect)frame
{
    CGRect fra=stockListCountView.frame;
    fra.origin.y=frame.origin.y;
    stockListCountView.frame=fra;
    AppDelegate *del=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *contextF= del.managedObjectContext;
    NSFetchRequest *fet=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([StockDetails class])];
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"codeId_s == %@",st.codeId_s];
    [fet setPredicate:pre];
    NSArray *res=[contextF executeFetchRequest:fet error:nil];
    if(res.count>0){
        [stockListCountView showStockfromStockMaster:res];
        stockListCountView.hidden=NO;
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self getpredicateforlocalorGlobalSearch:textField.text];
    [textField resignFirstResponder];
    return YES;
}
-(void)getpredicateforlocalorGlobalSearch:(NSString*)str{

    AppDelegate *del=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *filtercontextF= del.managedObjectContext;
    

    NSPredicate *p1=[NSPredicate predicateWithFormat:@"SELF.filters.brand__c LIKE[c] %@",str];
    NSPredicate *p2=[NSPredicate predicateWithFormat:@"SELF.filters.color_Code__c LIKE[c] %@",str];
    NSPredicate *p3 =[NSPredicate predicateWithFormat:@"SELF.filters.collection_Name__c LIKE[c] %@",str];
    NSPredicate *p4=[NSPredicate predicateWithFormat:@"SELF.filters.tips_Color__c LIKE[c] %@",str];
    NSPredicate *p5=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Material__c LIKE[c] %@",str];
    NSPredicate *p6=[NSPredicate predicateWithFormat:@"SELF.filters.temple_Color__c LIKE[c] %@",str];
    NSPredicate *p7=[NSPredicate predicateWithFormat:@"SELF.filters.style_Code__c LIKE[c] %@",str];
    NSPredicate *p8=[NSPredicate predicateWithFormat:@"SELF.filters.size__c LIKE[c] %@",str];
    NSPredicate *p9=[NSPredicate predicateWithFormat:@"SELF.filters.shape__c LIKE[c] %@",str];
    NSPredicate *p10=[NSPredicate predicateWithFormat:@"SELF.filters.product__c LIKE[c] %@",str];
    NSPredicate *p11=[NSPredicate predicateWithFormat:@"SELF.filters.logo_Type__c LIKE[c] %@",str];
    NSPredicate *p12=[NSPredicate predicateWithFormat:@"SELF.filters.logo_Size__c LIKE[c] %@",str];
    NSPredicate *p13=[NSPredicate predicateWithFormat:@"SELF.filters.logo_Color__c LIKE[c] %@",str];
    NSPredicate *p14=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Description__c LIKE[c] %@",str];
    NSPredicate *p15=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Color__c LIKE[c] %@",str];
    NSPredicate *p16=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Code__c LIKE[c] %@",str];
    NSPredicate *p17=[NSPredicate predicateWithFormat:@"SELF.filters.item_No__c LIKE[c] %@",str];
    NSPredicate *p18=[NSPredicate predicateWithFormat:@"SELF.filters.item_Group_Product_Family__c LIKE[c] %@",str];
    NSPredicate *p19=[NSPredicate predicateWithFormat:@"SELF.filters.item_Description__c LIKE[c] %@",str];
    NSPredicate *p20=[NSPredicate predicateWithFormat:@"SELF.filters.inactive_To__c LIKE[c] %@",str];
    NSPredicate *p21=[NSPredicate predicateWithFormat:@"SELF.filters.inactive_From__c LIKE[c] %@",str];
    NSPredicate *p22=[NSPredicate predicateWithFormat:@"SELF.filters.inactive__c LIKE[c] %@",str];
    NSPredicate *p23=[NSPredicate predicateWithFormat:@"SELF.filters.group_Name__c LIKE[c] %@",str];
    NSPredicate *p24=[NSPredicate predicateWithFormat:@"SELF.filters.group_Name__c LIKE[c] %@",str];
    NSPredicate *p25=[NSPredicate predicateWithFormat:@"SELF.filters.front_Color__c LIKE[c] %@",str];
    NSPredicate *p26=[NSPredicate predicateWithFormat:@"SELF.filters.frame_Structure__c LIKE[c] %@",str];
    NSPredicate *p27=[NSPredicate predicateWithFormat:@"SELF.filters.frame_Material__c LIKE[c] %@",str];
    NSPredicate *p28=[NSPredicate predicateWithFormat:@"SELF.filters.foreign_Name__c LIKE[c] %@",str];
    NSPredicate *p29=[NSPredicate predicateWithFormat:@"SELF.filters.flex_Temple__c LIKE[c] %@",str];
    NSPredicate *p30=[NSPredicate predicateWithFormat:@"SELF.filters.factory_Company__c LIKE[c] %@",str];
    NSPredicate *p31=[NSPredicate predicateWithFormat:@"SELF.filters.drawing_Code__c LIKE[c] %@",str];
    NSPredicate *p32=[NSPredicate predicateWithFormat:@"SELF.filters.delivery_Month__c LIKE[c] %@",str];
    NSPredicate *p33=[NSPredicate predicateWithFormat:@"SELF.filters.custom__c LIKE[c] %@",str];
    NSPredicate *p34=[NSPredicate predicateWithFormat:@"SELF.filters.color_Code__c LIKE[c] %@",str];
    NSPredicate *p35=[NSPredicate predicateWithFormat:@"SELF.filters.color_Code__c LIKE[c] %@",str];
    NSPredicate *p36=[NSPredicate predicateWithFormat:@"SELF.filters.collection__c LIKE[c] %@",str];
    NSPredicate *p37=[NSPredicate predicateWithFormat:@"SELF.filters.category__c LIKE[c] %@",str];
    NSPredicate *p38=[NSPredicate predicateWithFormat:@"SELF.filters.stock_Warehouse__c LIKE[c] %@",str];
    NSPredicate *p39=[NSPredicate predicateWithFormat:@"SELF.filters.active_To__c LIKE[c] %@",str];
    NSPredicate *p40=[NSPredicate predicateWithFormat:@"SELF.filters.active_From__c LIKE[c] %@",str];
    NSPredicate *p41=[NSPredicate predicateWithFormat:@"SELF.filters.rim__c LIKE[c] %@",str];
    NSPredicate *p42=[NSPredicate predicateWithFormat:@"SELF.filters.lens_Material__c LIKE[c] %@",str];
    NSPredicate *p43=[NSPredicate predicateWithFormat:@"SELF.filters.picture_Name__c LIKE[c] %@",str];
    NSPredicate *p44=[NSPredicate predicateWithFormat:@"SELF.stock != nil"];
    
    NSCompoundPredicate *andPre;
    if(_searchEveryWhereOptn.selected == YES){
        NSCompoundPredicate *finalPre=[NSCompoundPredicate orPredicateWithSubpredicates:@[p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p24,p25,p26,p27,p28,p29,p30,p31,p32,p33,p34,p35,p36,p37,p38,p39,p40,p41,p42,p43]];
        andPre=[NSCompoundPredicate andPredicateWithSubpredicates:@[finalPre,p44]];
    }else{
        NSPredicate *brabdP=[NSPredicate predicateWithFormat:@"SELF.filters.brand__c LIKE[c] %@",ronakGlobal.selectedFilter.brand];
        NSCompoundPredicate *finalPre=[NSCompoundPredicate orPredicateWithSubpredicates:@[p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p24,p25,p26,p27,p28,p29,p30,p31,p32,p33,p34,p35,p36,p37,p38,p39,p40,p41,p42,p43]];
        andPre=[NSCompoundPredicate andPredicateWithSubpredicates:@[finalPre,p44,brabdP]];
    }
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ItemMaster class])];
    [fetch setPredicate:andPre];
    NSArray *arr=[filtercontextF executeFetchRequest:fetch error:nil];
    NSLog(@"%@",arr);
    
    if(arr.count>0){
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"filters.color_Code__c" ascending:YES];
        NSArray *sort=[arr sortedArrayUsingDescriptors:@[sortDescriptor]];
        showItemsOnscrnArry=(NSMutableArray*)sort;
        [self changeLablesBasedOnitemsIndex:0];
//    _displayLable.text=[NSString stringWithFormat:@"%lu/%lu",(unsigned long)modelIndex+1,(unsigned long)model.ColorsArray.count];
        [ronakGlobal.selectedItemsTocartArr removeAllObjects];
        [ronakGlobal.selectedItemsTocartArr addObject:showItemsOnscrnArry[0]];
        [_productsCollectionView reloadData];
        _displayLable.hidden=YES;
        _allModelsTopBtn.enabled=NO;
    }
    else{
        showMessage(@"No Items Found", self.view);
    }
}

@end

