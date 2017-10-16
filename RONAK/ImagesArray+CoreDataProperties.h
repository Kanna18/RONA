//
//  ImagesArray+CoreDataProperties.h
//  RONAK
//
//  Created by Gaian on 10/16/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//
//

#import "ImagesArray+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ImagesArray (CoreDataProperties)

+ (NSFetchRequest<ImagesArray *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *imageName;
@property (nullable, nonatomic, copy) NSString *imageUrlPath;
@property (nullable, nonatomic, copy) NSString *localPath;
@property (nullable, nonatomic, retain) StockDetails *stock;

@end

NS_ASSUME_NONNULL_END
