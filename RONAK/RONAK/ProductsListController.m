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

@implementation ProductsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *productsViewLayout = (UICollectionViewFlowLayout*)self.productsCollectionView.collectionViewLayout;
    productsViewLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    UICollectionViewFlowLayout *customersViewLayout = (UICollectionViewFlowLayout*)self.customersCollectionView.collectionViewLayout;
    customersViewLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    customersViewLayout.minimumInteritemSpacing = 0;
    customersViewLayout.minimumLineSpacing = 0;

    [self defaultShapesOfComponents];
}

-(void)defaultShapesOfComponents
{
    [self drawBorders:_pSymbol];
    [self drawBorders:_saleBtn];
    [self drawBorders:_allColoursBtn];
    
    _searchEveryWhereOptn.layer.cornerRadius=10;
    _searchEveryWhereOptn.clipsToBounds=YES;
    _discountLbl.font=sfFont(42);
    
    _discountVw.layer.borderWidth=2.0;
    _discountVw.layer.borderColor=[UIColor blackColor].CGColor;
    
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
        return 14;
    }
    if(collectionView==self.productsCollectionView)
    {
        return 12;
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
        return cell;
    }
    if(collectionView==self.customersCollectionView)
    {
        CustomerViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"customerViewCellReuse" forIndexPath:indexPath];
        if(cell==nil)
        {
            cell=[[CustomerViewCell alloc]init];
        }
        cell.layer.borderWidth=1.0f;
        cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
        return cell;
    }
    return nil;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)searchEveryWhereClick:(id)sender {
}
@end
