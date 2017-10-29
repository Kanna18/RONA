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

@implementation CustomPassCode


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _passscode=@"";
    [self roundRects];
    
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
            }
        }
    }
}
-(void)clickednums:(UIButton*)sender{
    if(_passscode.length<4){
        if(sender.tag>=100){
    _passscode=[_passscode stringByAppendingString:sender.currentTitle];
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

- (IBAction)deleteClick:(id)sender {
    
    UIButton *btn=(UIButton*)sender;
    if(_passscode.length>0)
    {
        _passscode=[_passscode substringToIndex:_passscode.length-1];
    }
    [self clickednums:btn];
}
@end
