//
//  YMCollectionIndexView.h
//  RONAK
//
//  Created by Gaian on 7/15/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMCollectionIndexView : UIControl

- (id) initWithFrame:(CGRect)frame indexTitles:(NSArray *)indexTitles;

// Model
@property (strong, nonatomic) NSArray *indexTitles; // NSString
@property (readonly, nonatomic) NSUInteger currentIndex;
- (NSString *)currentIndexTitle;

@end
