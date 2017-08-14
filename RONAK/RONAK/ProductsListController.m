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
    
    for (CustomButton *cst in self.view.subviews)
    {
        if([cst isKindOfClass:[CustomButton class]])
        {
            [self drawBorders:cst];
        }
    }
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
    return 10;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if(collectionView==self.productsCollectionView)
    {
        ProductCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"productCVCell" forIndexPath:indexPath];
        return cell;
    }
    if(collectionView==self.customersCollectionView)
    {
        CustomerViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"customerViewCellReuse" forIndexPath:indexPath];
        
        cell.layer.borderWidth=1.0f;
        cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
        return cell;
    }
    return nil;
    
}
-(void)drawBorders:(id)element{
    if([element isKindOfClass:[CustomButton class]])
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

@end
