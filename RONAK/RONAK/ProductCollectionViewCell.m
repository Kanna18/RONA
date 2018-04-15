//
//  ProductCollectionViewCell.m
//  RONAK
//
//  Created by Gaian on 8/13/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductCollectionViewCell.h"

@implementation ProductCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UILongPressGestureRecognizer *longgest=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showStockCount)];
    longgest.minimumPressDuration=1;
    [self addGestureRecognizer:longgest];
    self.clipsToBounds=NO;
}
-(void)bindData:(ItemMaster*)item{
    
    NSArray *imgsPaths=[item.stock.imagesArr allObjects];
    NSMutableArray *imagesArray=[[NSMutableArray alloc]init];
    [imgsPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ImagesArray *coreImg=obj;
        NSString  *path=[docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"IMAGES/%@",coreImg.imageName]];
        [imagesArray addObject:path];
    }];
    
    [imagesArray sortUsingSelector:@selector(caseInsensitiveCompare:)];
    //    NSString  *path=[[docPath stringByAppendingPathComponent:@"IMAGES/"] stringByAppendingPathComponent:imagesArray[0]];
    UIImage *image=[UIImage imageNamed:[imagesArray count]>0?imagesArray[0]:@""];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        image=[self imageWithImage:image convertToSize:CGSizeMake(120, 85)];
//        dispatch_sync(dispatch_get_main_queue(), ^(void) {
           _thubImage.image=image;
            _item=item;
            _codeName.text=item.filters.color_Code__c;
    [self getStockColorCount:item.filters.item_No__c];
}
-(void)getStockColorCount:(NSString*)itemCode{
    
    AppDelegate *del=(AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *countContext= del.managedObjectContext;
    
    NSMutableArray *wreHseArr=[[NSMutableArray alloc]init];
    for (NSString *wreHse in ronakGlobal.selectedFilter.warehouseFilter) {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"warehouse_Name_s LIKE %@",wreHse];
        [wreHseArr addObject:predicate];
    }
    NSPredicate *itmCode=[NSPredicate predicateWithFormat:@"item_Code_s LIKE %@",itemCode];
    NSCompoundPredicate *cmpPre=[NSCompoundPredicate orPredicateWithSubpredicates:wreHseArr];
    NSCompoundPredicate *fPred=[NSCompoundPredicate andPredicateWithSubpredicates:@[itmCode,cmpPre]];
    NSFetchRequest *fet=[[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([StockDetails class])];
    [fet setPredicate:fPred];
    NSArray *arr=[countContext executeFetchRequest:fet error:nil];
    NSMutableArray *stockCnt=[[NSMutableArray alloc]initWithArray:[arr valueForKeyPath:@"stock__s"]];
    NSMutableArray *poCnt=[[NSMutableArray alloc]initWithArray:[arr valueForKeyPath:@"ordered_Quantity_s"]];
    int stockCount =[stockCnt countOfAllIndexes];;    
    int poCount=[poCnt countOfAllIndexes];
    if(stockCount>0){
        _codeName.textColor=[UIColor blackColor];
    }else if (poCount>0){
        _codeName.textColor=RGB(247,201,46);//Dark Yellow
    }else{
        _codeName.textColor=[UIColor redColor];
    }
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

-(void)showStockCount{
    
    [_delegate showStockCountofProduct:_item superView:self];
    
}

@end
