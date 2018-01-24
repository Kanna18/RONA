//
//  OrderCell.m
//  RONAK
//
//  Created by Gaian on 8/25/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import "OrderCell.h"



@implementation OrderCell{
    
     enum {
        Increment = 100,
        Decrement = 101,
    } TagValues;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    [self defaultStyles];
}
-(void)defaultStyles
{
    [self drawBorders:_incrementPro];
    [self drawBorders:_decrementPro];
    _brandLabel.font=sfFont(12);
    _decrementPro.titleLabel.textAlignment=UIControlContentVerticalAlignmentTop;
    
    _incrementPro.tag=Increment;
    _decrementPro.tag=Decrement;
    _brandLabel.font=sfFont(15);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteProduct:(id)sender {
    
    if([_cstData.defaultsCustomer.itemsCount containsObject:_item]){
        
        [_cstData.defaultsCustomer.itemsCount removeObject:_item];
    }
    
    [_delegate quantityChangedforCustomer:_cstButtomCustomer];

    
}
- (IBAction)qtyFunction:(id)sender {
    
    UIButton *but=sender;
    int qty=[_qtyLabel.text intValue];
    switch (but.tag)
    {
        case Increment:
        {
            if(qty>=0)
            {
                [_cstData.defaultsCustomer.itemsCount addObject:_item];
                qty++;
            }
        }
            break;
        case Decrement:
        {
            if(!(qty<=1)){
                
                 [_cstData.defaultsCustomer.itemsCount removeObjectAtIndex:[_cstData.defaultsCustomer.itemsCount indexOfObject:_item]];

                qty--;
            }
        }
            break;
        default:
            break;
    }
    _qtyLabel.text=[NSString stringWithFormat:@"%d",qty];
    
    [_delegate quantityChangedforCustomer:_cstButtomCustomer];
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
-(void)bindData:(ItemMaster *)item withCount:(int)Count customerData:(CustomerDataModel*)cst forCustome:(CustomButton *)btn
{
    _item=item;
    _cstData=cst;
    _count=Count;
    _cstButtomCustomer=btn;
    
    _qtyLabel.text=[NSString stringWithFormat:@"%d",Count];
    _brandLabel.text=item.filters.brand__c;
    _descriptionLabel.text=[NSString stringWithFormat:@"%@ %@ %@ %@",item.filters.brand__c,item.filters.product__c,item.filters.style_Code__c,item.filters.color_Code__c];
    _priceLabel.text=[NSString stringWithFormat:@"%0.1f",item.filters.wS_Price__c];
    _discountLabel.text=[NSString stringWithFormat:@"%0.1f",_item.filters.discount__c];
    _totalLabel.text=[NSString stringWithFormat:@"%0.1f",(item.filters.wS_Price__c*Count)];
    
    NSMutableArray *imagesArray=[[NSMutableArray alloc]init];
    NSArray *imgsPaths=[_item.stock.imagesArr allObjects];
    [imgsPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ImagesArray *coreImg=obj;
        NSString  *path=[docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"IMAGES/%@",coreImg.imageName]];
        [imagesArray addObject:path];
    }];
    NSLog(@"%@",imagesArray);
    //    NSString  *path=[[docPath stringByAppendingPathComponent:@"IMAGES/"] stringByAppendingPathComponent:imagesArray[0]];
    UIImage *image=[UIImage imageNamed:[imagesArray count]>0?imagesArray[0]:@""];
    image=[self imageWithImage:image convertToSize:CGSizeMake(120, 85)];
    _productImage.image=image;
    
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
@end
