//
//  UnzipViewController.m
//  GaianOtt_Framework
//
//  Created by gaian on 28/09/16.
//  Copyright © 2016 gaian. All rights reserved.
//

#import "UnzipViewController.h"
#import "Reachability.h"
#import "ZipArchive.h"



const NSUInteger NUM_FILES = 1;

@interface UnzipViewController ()<NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property NSString *cachePathE,*unZipPath,*urlPathString;

@end

@implementation UnzipViewController{
    
    NSFileManager *fileManagerE;
    NSURLSessionDownloadTask *downloadTask;
    NSURLSession *session;
    NSURLRequest *request;
    NSArray* _files;
    NSString *internetStatus;
    NSData *pauseData;
}

+ (void)presentResourcesViewController:(UIViewController *)viewController withTitle:(NSString *)title URL:(NSURL *)url completion:(void(^)())completion
{
    [viewController presentViewController:[[UnzipViewController alloc]initWithURL:url] animated:YES completion:completion];
}
- (instancetype)initWithURL:(NSURL *)url
{
    self = [self initWithNibName:@"UnzipViewController" bundle:[NSBundle bundleForClass:[self class]]];
    if (self) {
        self.urlPathString =[NSString stringWithFormat:@"%@",url];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    /*Progress Bar*/
    self.label.text=@"Checking for Internet Connection...";
    self.label.adjustsFontSizeToFitWidth=YES;
    self.progressBar.center=self.view.center;
    [self.progressBar setProgress:0 animated:NO];

    
    /*declaring Cache Path and Filemanager Path*/
    _cachePathE=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:@"resources.zip"];
    _unZipPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@""];
    fileManagerE=[NSFileManager defaultManager];
    [self downloadingResourcesFunction];
}

-(void)downloadingResourcesFunction
{
    session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    request=[NSURLRequest requestWithURL:[NSURL URLWithString:_urlPathString]];
    if(pauseData==nil)
    {
    downloadTask=[session downloadTaskWithRequest:request];
    [downloadTask resume];
    }
    else
    {
        downloadTask= [session downloadTaskWithResumeData:pauseData];
        [downloadTask resume];
    }

}

#pragma mark Calling - Download Session Delegates

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    [self.progressBar setProgress:(float)totalBytesWritten/totalBytesExpectedToWrite animated:YES];
    self.label.text=[NSString stringWithFormat:@"Downloading..%0.0f%%",((float)totalBytesWritten/totalBytesExpectedToWrite)*100];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    NSError *error;
    [fileManagerE moveItemAtPath:[location path]  toPath:_cachePathE error:&error];
    self.label.text=[NSString stringWithFormat:@"Downloaded.. 100%%"];
    NSLog(@"Extrating Files");
    [self extractZipFolder];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    internetStatus=[error valueForKeyPath:@"_userInfo.NSLocalizedDescription"];
    pauseData=[error valueForKeyPath:@"_userInfo.NSURLSessionDownloadTaskResumeData"];
    if(error){
    [self alerViewControllerwithMessage:internetStatus];
    }
}

                /*Alert View Controller*/
-(void)alerViewControllerwithMessage:(NSString*)message
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *retry=[UIAlertAction actionWithTitle:@"retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self downloadingResourcesFunction];
    }];
    [alert addAction:ok];
    [alert addAction:retry];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)extractZipFolder
{
    self.label.text=[NSString stringWithFormat:@"Installing..."];
    // unzip normal zip
    NSUInteger count = 0;
    NSFileManager* fm = [NSFileManager defaultManager];
    
    if(!([fm fileExistsAtPath:[docPath stringByAppendingPathComponent:@"IMAGES"]]))
    {
        [fm createDirectoryAtPath:[docPath stringByAppendingPathComponent:@"IMAGES"] withIntermediateDirectories:NO attributes:nil error:nil];
    }

    ZipArchive* zip = [[ZipArchive alloc] init];
    [zip UnzipOpenFile:_cachePathE];
    
    NSArray* contents = [zip getZipFileContents];
    if(contents && contents.count == _files.count)
        NSLog(@"zip files has right number of contents");
    
    [zip UnzipFileTo:[docPath stringByAppendingPathComponent:@"IMAGES"] overWrite:YES];
    
    NSDirectoryEnumerator* dirEnum = [fm enumeratorAtPath:_unZipPath];
    NSString* file;
    NSError* error = nil;
    
    while ((file = [dirEnum nextObject])) {
        count += 1;
        NSString* fullPath = [_unZipPath stringByAppendingPathComponent:file];
        NSDictionary* attrs = [fm attributesOfItemAtPath:fullPath error:&error];
        if([attrs fileSize] > 0)
            NSLog(@"file is not zero length");
    }
    if(count == NUM_FILES)
        NSLog (@"files extracted successfully");
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if([fm fileExistsAtPath:[cachePath stringByAppendingString:@"resources.zip"]])
    {
        [fm removeItemAtPath:[cachePath stringByAppendingString:@"resources.zip"] error:nil];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:unzipedItemsSuccess object:nil];
}
@end
