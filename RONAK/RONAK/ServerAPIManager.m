//
//  ServerAPIManager.m
//  Tripanzee
//
//  Created by Chandrika on 01/10/14.
//  Copyright (c) 2014 Raju Solutions. All rights reserved.
//

#import "ServerAPIManager.h"
#import "AFHTTPSessionManager.h"

enum HTTPMethod {
    HTTPGet = 1729,
    HTTPPost,
    HTTPPut,
    HTTPDelete
};

@implementation ServerAPIManager



+ (instancetype)sharedinstance {
    static dispatch_once_t once;
    static ServerAPIManager *serverAPI = nil;
    dispatch_once(&once,^{
        serverAPI = [[ServerAPIManager alloc] init];
        
    });
    return serverAPI;
}


-(void)processRequest:(NSString*)path params:(id)params requestType:(NSString *)type cusHeaders:(NSDictionary*)headersDict successBlock:(NetworkManagerCompletionBlock)reqSuccessDic andErrorBlock:(NetworkManagerFailureBlock)reqErrorDic
{
    
      AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]];
    manager.securityPolicy= [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manager.securityPolicy.allowInvalidCertificates=YES;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if(headersDict){
        
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [policy setValidatesDomainName:NO];
        [policy setAllowInvalidCertificates:NO];
        manager.securityPolicy = policy;

        for (NSString *key in headersDict.allKeys)
        {
            [manager.requestSerializer setValue:headersDict[key] forHTTPHeaderField:key];
        }
        
    }
    
    if ([type isEqualToString:@"POST"]) {
        
        [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self completedWithResponse:(NSHTTPURLResponse *)task.response error:nil data:responseObject withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self completedWithResponse:(NSHTTPURLResponse *)task.response error:error data:nil withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
            
        }];

    }
    else if ([type isEqualToString:@"GET"])
    {

        [manager GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self completedWithResponse:(NSHTTPURLResponse *)task.response error:nil data:responseObject withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [self completedWithResponse:(NSHTTPURLResponse *)task.response error:error data:nil withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        }];
    }
    else if ([type isEqualToString:@"PUT"])
    {
        [manager PUT:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
             [self completedWithResponse:(NSHTTPURLResponse *)task.response error:nil data:responseObject withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self completedWithResponse:(NSHTTPURLResponse *)task.response error:error data:nil withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        }];
    }
    else
    {
    
        
        [manager DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [self completedWithResponse:(NSHTTPURLResponse *)task.response error:nil data:responseObject withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
             [self completedWithResponse:(NSHTTPURLResponse *)task.response error:error data:nil withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        }];
    }
    manager=nil;
}

-(void)getAuthTokenPath:(NSString*)url bodyString:(NSString*)body SuccessBlock:(NetworkManagerCompletionBlock)reqSuccessDic andErrorBlock:(NetworkManagerFailureBlock)reqErrorDic
{
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [urlRequest setHTTPMethod:@"POST"];
    
    //Apply the data to the body
    [urlRequest setHTTPBody:data];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(id  _Nullable data, NSURLResponse *response, NSError *error)
    {
        
        [self completedWithResponse:(NSHTTPURLResponse *)response error:nil data:data withSuccessBlock:reqSuccessDic ErrorBlock:reqErrorDic];
        
    }];
    [dataTask resume];
}






 
 - (void)completedWithResponse:(NSHTTPURLResponse *)response error:(NSError *)error data:(NSDictionary *)returnDict withSuccessBlock:(NetworkManagerCompletionBlock)completeSuccessBlock ErrorBlock:(NetworkManagerFailureBlock)completeErrorBlock
{
     if (response.statusCode == 200)
    {
        completeSuccessBlock(returnDict);
    }
    else
    {
        completeErrorBlock(error);
    }
}




 

@end
