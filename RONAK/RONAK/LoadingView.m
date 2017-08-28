//
//  LoadingView.m
//  INCOIS
//
//  Created by Gaian on 2/2/17.
//  Copyright © 2017 Gaian. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView{
    
    CustomLabel *messageabel,*warningLabel;
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)init
{
    self=[super init];
    if(self)
    {
        
        warningLabel=[[CustomLabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/8, [[UIScreen mainScreen] bounds].size.height/2,3*[[UIScreen mainScreen] bounds].size.width/4, [[UIScreen mainScreen] bounds].size.height/15)];
        warningLabel.adjustsFontSizeToFitWidth=YES;
        warningLabel.numberOfLines=3;
        warningLabel.textColor=[[UIColor whiteColor] colorWithAlphaComponent:1.0];
        warningLabel.textAlignment=NSTextAlignmentCenter;
        warningLabel.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
        warningLabel.layer.cornerRadius=[[UIScreen mainScreen] bounds].size.height/40;
        warningLabel.clipsToBounds=YES;
        warningLabel.hidden=YES;
        
        
        messageabel=[[CustomLabel alloc]init];
        messageabel.font=[UIFont boldSystemFontOfSize:30];
        [messageabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:messageabel];
        messageabel.backgroundColor=[UIColor clearColor];
    }
    return self;
}


-(void)loadingWithlightAlpha:(UIView*)view with_message:(NSString*)text{
    
    self.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    self.color=[UIColor whiteColor];
    
    [view addSubview:self];
    messageabel.frame=CGRectMake(0, self.frame.size.height/2, 200, 50);
    messageabel.center=self.center;
    messageabel.text=text;

    
}

-(void)WithView:(UIView*)view with_message:(NSString*)text
{

    self.frame=CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    self.backgroundColor=[UIColor whiteColor];
    self.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    self.color=[UIColor blackColor];

    [view addSubview:self];
    messageabel.frame=CGRectMake(0, self.frame.size.height/2, 200, 50);
    messageabel.center=self.center;
    messageabel.text=text;
    
    
}

-(void)setMessageText:(NSString *)messageText
{
    messageabel.text=messageText;
}
-(void)start
{
    [self startAnimating];
}
-(void)stop
{
    [self stopAnimating];
}


-(void)waringLabelText:(NSString*)msg onView:(UIView*)view
{
    
    
    [view addSubview:warningLabel];
    warningLabel.hidden=NO;
    warningLabel.text=msg;
//    [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                warningLabel.hidden=YES;
        });
        
//    }];
    NSLog(@"Getting Message=%@",msg);
}

@end
