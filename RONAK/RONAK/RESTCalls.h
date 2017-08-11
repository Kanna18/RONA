//
//  RESTCalls.h
//  INCOIS
//
//  Created by Gaian on 2/6/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"


@protocol JSONResponse <NSObject>
@required
-(void)jsonResponseWithError:(NSData*)jsonRespData jsonDictionary:(NSDictionary*)jsonRespDict error:(NSError*)error;
@end

@interface RESTCalls : NSObject<NSURLSessionDelegate,NSURLSessionTaskDelegate,NSURLSessionDataDelegate>

-(void)restCallurl:(NSString*)url parametersDict:(NSDictionary*)dict headers:(NSDictionary*)headersDict;

-(void)restCallurlforPUTMethod:(NSString*)url parametersDict:(NSDictionary*)dict headers:(NSDictionary*)headersDict;

-(NSString*)downloadkmlfileFromPath:(NSString*)path withFileExtension:(NSString*)extension;
-(NSDictionary*)readJsonDataFromFile:(NSString*)fileName;
-(NSString*)getaFileFromDocumentsDirectoryofName:(NSString*)fileName;
-(void)writeJsonDatatoFile:(NSData*)jsonData toPathExtension:(NSString*)path error:(NSError*)error;
-(void)uploadImagetoServer:(NSString*)image serverUrl:(NSString*)url parametersDict:(NSDictionary*)dict headers:(NSDictionary*)headersDict;
-(NSString*)convertHtmlStringtoPlainText:(NSString*)htmlStr;
-(NSData*)readJsonDataFromFileinNSD:(NSString*)fileName;
@property id <JSONResponse>delegate;

@end
