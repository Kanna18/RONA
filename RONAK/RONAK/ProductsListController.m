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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LoadingView* load=[[LoadingView alloc]init];
    [load loadingWithlightAlpha:_productsCollectionView with_message:@""];
    [load start];
    
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
    _detailedImageView.doubleTap=YES;
    
    DownloadProducts *dow=[[DownloadProducts alloc]init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        ronakGlobal.filterdProductsArray=[dow pickProductsFromFilters];
            [_productsCollectionView reloadData];
        if(ronakGlobal.filterdProductsArray.count>0)
            [self changeLablesBasedOnitemsIndex:0];
        
        [load stop];
    });
    
    _filterTable.delegate=self;
    _filterTable.dataSource=self;

    
    
    _filterTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    LoadingView* load2=[[LoadingView alloc]init];
    [load2 loadingWithlightAlpha:_filterTable with_message:@""];
    [load2 start];
    
    DownloadProducts *dw=[[DownloadProducts alloc]init];
    height=61;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    filtersArr=@[@{ @"heading":kLensDescription,
                    @"options":[dw getFilterFor:@"lens_Description__c"]},
                 @{ @"heading":kWSPrice,
                    @"options":[dw getFilterFor:@"wS_Price__c"]},
                 @{ @"heading":kShape,
                    @"options":[dw getFilterFor:@"shape__c"]},
                 @{ @"heading":kFrameMaterial,
                    @"options":[dw getFilterFor:@"frame_Material__c"]},
                 @{ @"heading":kTempleMaterial,
                    @"options":[dw getFilterFor:@"temple_Material__c"]},
                 @{ @"heading":kTempleColour,
                    @"options":[dw getFilterFor:@"temple_Color__c"]},
                 @{ @"heading":kSize,
                    @"options":[dw getFilterFor:@"size__c"]},
                 @{ @"heading":kFrontColor,
                    @"options":[dw getFilterFor:@"front_Color__c"]},
                 @{ @"heading":kLensColor,
                    @"options":[dw getFilterFor:@"lens_Color__c"]}
                 ];
        [_filterTable reloadData];
        [load2 stop];
    });
        
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
    _itemModelNameLabel.text=item.filters.style_Code__c;
    _selectedItemDesc.text=item.filters.item_Description__c;
    _pricingLabel.text=item.filters.mRP__c;
    _discountLabel.text=[item.filters.discount__c stringByAppendingString:@"%"];
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

#pragma mark TV Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return filtersArr.count;;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuse=@"testCell";
    CustomTVCell *cell=[tableView dequeueReusableCellWithIdentifier:reuse];
    cell.delegate=self;
    if(cell==nil)
    {
        cell=  [[CustomTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.headerButton.tag=indexPath.section;
    cell.filterType=[filtersArr[indexPath.section] valueForKey:@"heading"];
    [cell.headerButton setTitle:[filtersArr[indexPath.section] valueForKey:@"heading"] forState:UIControlStateNormal];
    cell.optionsArray=[filtersArr[indexPath.section] valueForKey:@"options"];
    if(Section!=indexPath.section){//except the selected cell remaining need to close
        cell.headerButton.selected=NO;
        [cell.headerButton setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateNormal];
    }
    [cell layoutSubviews];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(Section==indexPath.section)
    {
        return height;
    }
    else{
        return 61;
    }
}
-(void)getbuttonStatus:(UIButton *)sender cell:(CustomTVCell *)cell
{
    [_filterTable reloadData];
    [self.filterTable beginUpdates];
    if(sender.selected==YES){
        height=cell.optionsArray.count*44+140;
    }
    else{
        height=61;
    }
    Section=sender.tag;
    [self.filterTable endUpdates];
    
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)jumptoMenuVC:(id)sender
{
    MenuViewController *men=[self.storyboard instantiateViewControllerWithIdentifier:@"menuVC"];
    [self.navigationController popToViewController:men animated:YES];
}



@end
