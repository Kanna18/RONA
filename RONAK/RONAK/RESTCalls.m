//
//  RESTCalls.m
//  INCOIS
//
//  Created by Gaian on 2/6/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import "RESTCalls.h"


@implementation RESTCalls
{
    NSArray *jsonArray;
    NSDictionary *jsonDictionary;
}

-(id)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}

-(void)restCallurl:(NSString*)url parametersDict:(NSDictionary*)dict headers:(NSDictionary*)headersDict
{
   url=[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"testersUrl"],url];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest=4;
    NSURLSession *session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    if(headersDict)
    {
        for (NSString *header in headersDict.allKeys)
        {
            [request setValue:[headersDict valueForKey:header] forHTTPHeaderField:header];
        }
    }
    if(dict)
    {
        NSString *post=@"";
        for (NSString *key in dict.allKeys)
        {
            post=[post stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,    [dict valueForKey:key]]];
        }
        post=[post substringToIndex:post.length-1];
        NSLog(@"string'%@'",post);
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded"  forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    }
    
 NSURLSessionTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if(!error)
        {
            jsonDictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Server is connecting");
            
        }
     [_delegate jsonResponseWithError:data jsonDictionary:jsonDictionary error:error];
    }];
    [dataTask resume];
}

-(void)restCallurlforPUTMethod:(NSString*)url parametersDict:(NSDictionary*)dict headers:(NSDictionary*)headersDict
{
//    url=[NSString stringWithFormat:@"%@%@",hostPath,url];
    url=[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"testersUrl"],url];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    NSURLSessionConfiguration *sessionConfig=[NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest=10;
    NSURLSession *session=[NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    if(headersDict)
    {
        for (NSString *header in headersDict.allKeys)
        {
            [request setValue:[headersDict valueForKey:header] forHTTPHeaderField:header];
        }
    }
    if(dict)
    {
        NSString *post=@"";
        for (NSString *key in dict.allKeys)
        {
            post=[post stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,    [dict valueForKey:key]]];
        }
        post=[post substringToIndex:post.length-1];
        NSLog(@"string'%@'",post);
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        [request setHTTPMethod:@"PUT"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded"  forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    }
    
    NSURLSessionTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(!error)
        {
            jsonDictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Server is connecting");
            
        }
        [_delegate jsonResponseWithError:data jsonDictionary:jsonDictionary error:error];
    }];
    [dataTask resume];
}




-(NSString*)downloadkmlfileFromPath:(NSString*)path withFileExtension:(NSString*)extension
{
    if(path!=nil)
 {
    NSURL  *url = [NSURL URLWithString:path];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    NSString *destPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:extension];
    if(urlData){
    [urlData writeToFile:destPath atomically:YES];
    NSLog(@"kml downloaded to path-->%@",destPath);
    }
    else{
            NSLog(@"kml not Found-->%@",destPath);
    }
     return destPath;
  }
    return nil;
}

-(void)writeJsonDatatoFile:(NSData*)jsonData toPathExtension:(NSString*)path error:(NSError*)error
{
    NSError *errorWriting;
    
    NSString *dest=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0] stringByAppendingPathComponent:path];
        
        [jsonData writeToFile:dest atomically:YES];
    
    NSLog(@"writing '%@' JsonData to file path -%@--Error-%@",path,dest,errorWriting);
}


-(NSData*)readJsonDataFromFileinNSD:(NSString*)fileName
{
    NSString *source=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0] stringByAppendingPathComponent:fileName];
    NSError *error;
    NSData *data=[NSData dataWithContentsOfFile:source options:kNilOptions error:&error];
    return data;
}

-(NSDictionary*)readJsonDataFromFile:(NSString*)fileName
{
    NSString *source=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0] stringByAppendingPathComponent:fileName];
    NSError *error;
    NSError *error1;
    NSData *data=[NSData dataWithContentsOfFile:source options:kNilOptions error:&error1];
    
    NSLog(@"Reading -%@",error1);
    
    NSString *iso = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:dutf8 options:NSJSONReadingMutableContainers error:&error];
    
    NSLog(@"json Data From File--%@-%@",fileName,error);
    return dataDict;
}
-(NSString*)getaFileFromDocumentsDirectoryofName:(NSString*)fileName
{
    NSString *source=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0] stringByAppendingPathComponent:fileName];
    if([[NSFileManager defaultManager] fileExistsAtPath:source])
    {
        NSLog(@"%@ file is available",source);
        return source;
    }
    else{
        NSLog(@"%@ file is not available",source);
        
    }
    
    return nil;
}

-(void)uploadImagetoServer:(NSString*)image serverUrl:(NSString*)url parametersDict:(NSDictionary*)dict headers:(NSDictionary*)headersDict
{
    
//    url=[NSString stringWithFormat:@"%@%@",hostPath,url];
    url=[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"testersUrl"],url];
    NSMutableURLRequest *request;
    if([[image pathExtension]isEqualToString:@"jpeg"])
    {
        request= [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:@{@"file":@"File"} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:image] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
        } error:nil];
    }
    if([[image pathExtension]isEqualToString:@"MOV"]||[[image pathExtension]isEqualToString:@"mp4"])
    {
        request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:@{@"file":@"File"} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:image] name:@"file" fileName:@"filename.MOV" mimeType:@"image/jpeg/MOV" error:nil];
        } error:nil];
    
    }
    if([[image pathExtension]isEqualToString:@"wav"]||[[image pathExtension]isEqualToString:@"mp3"]||[[image pathExtension]isEqualToString:@"WAV"])
    {
        request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:@{@"file":@"File"} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:image] name:@"file" fileName:@"filename.mp3" mimeType:@"image/jpeg/mp3" error:nil];
        } error:nil];
    }
    [request setValue:@"1485153968695" forHTTPHeaderField:@"APP_ID"];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;


    /*For AFN 2.5.4*/
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                      [_delegate jsonResponseWithError:nil jsonDictionary:responseObject error:error];
                  }];

    /*For AFN 3.0*/
//    uploadTask = [manager
//                  uploadTaskWithStreamedRequest:request
//                  progress:^(NSProgress * _Nonnull uploadProgress) {
//                      
//                      
//
//                  }
//                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                      if (error) {
//                          NSLog(@"Error: %@", error);
//                      } else {
//                          NSLog(@"%@ %@", response, responseObject);
//                      }
//                      [_delegate jsonResponseWithError:nil jsonDictionary:responseObject error:error];
//                  }];
    
    [uploadTask resume];
    
}
-(NSString*)convertHtmlStringtoPlainText:(NSString*)htmlStr
{
    NSAttributedString *converter=[[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    NSLog(@"Html String Sending Title:%@",[converter string]);
    
    return [converter string];
}

@end
