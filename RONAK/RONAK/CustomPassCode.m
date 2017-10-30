//
//  CustomPassCode.m
//  RONAK
//
//  Created by Gaian on 10/29/17.
//  Copyright © 2017 RONAKOrganizationName. All rights reserved.
//

#define characAt(c)  [NSString stringWithFormat:@"%c",[_passscode characterAtIndex:c]]

#import "CustomPassCode.h"

@interface CustomPassCode ()

@end

@implementation CustomPassCode{
    LoadingView *load;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _passscode=@"";
    [self roundRects];
    
    load=[[LoadingView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)roundRects{
    for (UIButton *btn in self.codeView.subviews)
    {
        if([btn isKindOfClass:[UIButton class]])
        {
            if(btn.tag){
                btn.layer.cornerRadius=btn.frame.size.height/2;
                [btn addTarget:self action:@selector(clickednums:) forControlEvents:UIControlEventTouchUpInside];
                
                btn.layer.borderColor=[UIColor whiteColor].CGColor;
                btn.layer.borderWidth=2.0f;
            }
        }
        [self drawBorders:btn];

    }
}
-(void)clickednums:(UIButton*)sender{
    if(_passscode.length<4){
        if(sender.tag>=100){
    _passscode=[_passscode stringByAppendingString:sender.currentTitle];
        }
    }
    
    if(_passscode.length==4){
        if(![_passscode isEqualToString:defaultGet(passcode)]){
            _passscode=@"";
            [load waringLabelText:@"Wrong Passcode" onView:self.view];
            
        }
    }
    
    _tf1.text=_passscode.length>0?characAt(0):@"";
    _tf2.text=_passscode.length>1?characAt(1):@"";
    _tf3.text=_passscode.length>2?characAt(2):@"";
    _tf4.text=_passscode.length>3?characAt(3):@"";
    
    if([_passscode isEqualToString:defaultGet(passcode)]){
        [_delegate enteredPasscode:self];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)drawBorders:(id)element{
    
    UIView *cst=element;
    float shadowSize = 1.0f;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(cst.frame.origin.x - shadowSize / 2,
                                                                           cst.frame.origin.y - shadowSize / 2,
                                                                           cst.frame.size.width + shadowSize,
                                                                           cst.frame.size.height + shadowSize)];
    ////        cst.layer.borderColor=[UIColor lightGrayColor].CGColor;
    ////        cst.layer.borderWidth=1.0f;
    //        cst.layer.shadowColor=[UIColor lightGrayColor].CGColor;
    //        cst.layer.shadowOffset=CGSizeMake(2.0, 2.0);
    //        cst.layer.shadowRadius=2.0f;
    //        cst.layer.shadowOpacity=1.0f;
    cst.layer.masksToBounds = NO;
    cst.layer.shadowColor = [UIColor blackColor].CGColor;
    cst.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    cst.layer.shadowOpacity = 0.5f;
    //    cst.layer.shadowPath = shadowPath.CGPath;
    
    
}

- (IBAction)deleteClick:(id)sender {
    
    UIButton *btn=(UIButton*)sender;
    if(_passscode.length>0)
    {
        _passscode=[_passscode substringToIndex:_passscode.length-1];
    }
    [self clickednums:btn];
}
@end
