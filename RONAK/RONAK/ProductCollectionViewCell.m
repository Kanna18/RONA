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
}
-(void)bindData:(ItemMaster*)item{
    
    NSArray *imgsPaths=[item.stock.imagesArr allObjects];
    NSMutableArray *imagesArray=[[NSMutableArray alloc]init];
    [imgsPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ImagesArray *coreImg=obj;
        NSString  *path=[docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"IMAGES/%@",coreImg.imageName]];
        [imagesArray addObject:path];
    }];
    //    NSString  *path=[[docPath stringByAppendingPathComponent:@"IMAGES/"] stringByAppendingPathComponent:imagesArray[0]];
    UIImage *image=[UIImage imageNamed:[imagesArray count]>0?imagesArray[0]:@""];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        image=[self imageWithImage:image convertToSize:CGSizeMake(120, 85)];
//        dispatch_sync(dispatch_get_main_queue(), ^(void) {
           _thubImage.image=image;
            _item=item;
            _codeName.text=item.filters.color_Code__c;
//        });
//    });
//    if([item.filters.stock__c intValue]>50)
//    {
//        _codeName.textColor=[UIColor blackColor];
//    }
//    else{
//        _codeName.textColor=RGB(213,201,101);
////    }
}
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

@end
