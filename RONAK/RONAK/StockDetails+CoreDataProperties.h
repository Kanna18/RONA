//
//  StockDetails+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 11/2/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//
//

#import "StockDetails+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StockDetails (CoreDataProperties)

+ (NSFetchRequest<StockDetails *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *brand_s;
@property (nullable, nonatomic, copy) NSString *codeId_s;
@property (nullable, nonatomic, copy) NSString *item_Code_s;
@property (nullable, nonatomic, copy) NSString *ordered_Quantity_s;
@property (nullable, nonatomic, copy) NSString *product__s;
@property (nonatomic) int16_t stock__s;
@property (nullable, nonatomic, copy) NSString *warehouse_Name_s;
@property (nullable, nonatomic, copy) NSString *warehouse_s;
@property (nullable, nonatomic, retain) Att *attrib;
@property (nullable, nonatomic, retain) NSSet<ImagesArray *> *imagesArr;
@property (nullable, nonatomic, retain) ItemMaster *itemMaster;

@end

@interface StockDetails (CoreDataGeneratedAccessors)

- (void)addImagesArrObject:(ImagesArray *)value;
- (void)removeImagesArrObject:(ImagesArray *)value;
- (void)addImagesArr:(NSSet<ImagesArray *> *)values;
- (void)removeImagesArr:(NSSet<ImagesArray *> *)values;

@end

NS_ASSUME_NONNULL_END
