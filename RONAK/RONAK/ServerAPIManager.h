//
//  ServerAPIManager.h
//  Tripanzee
//
//  Created by Chandrika on 01/10/14.
//  Copyright (c) 2014 Raju Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^NetworkManagerCompletionBlock)(id responseObj);
typedef void ( ^NetworkManagerFailureBlock)(NSError *error);


@interface ServerAPIManager : NSObject{
 }

@property (nonatomic, copy) NetworkManagerCompletionBlock completionBlock;
@property (nonatomic, copy) NetworkManagerFailureBlock failureBlock;

+ (instancetype)sharedinstance;
-(void)processRequest:(NSString*)path params:(id)params requestType:(NSString *)type cusHeaders:(NSDictionary*)headersDict successBlock:(NetworkManagerCompletionBlock)reqSuccessDic andErrorBlock:(NetworkManagerFailureBlock)reqErrorDic;
-(void)getAuthTokenPath:(NSString*)url bodyString:(NSString*)body SuccessBlock:(NetworkManagerCompletionBlock)reqSuccessDic andErrorBlock:(NetworkManagerFailureBlock)reqErrorDic;
 @end
