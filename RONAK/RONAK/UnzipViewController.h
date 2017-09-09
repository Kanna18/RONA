//
//  UnzipViewController.h
//  GaianOtt_Framework
//
//  Created by gaian on 28/09/16.
//  Copyright © 2016 gaian. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface UnzipViewController : UIViewController

+ (void)presentResourcesViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url completion:(void(^)())completion;
- (id)initWithURL:(NSURL *)url;



@end
