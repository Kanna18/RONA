//
//  Discount.m
//  CalcTask
//
//  Created by Gaian on 8/28/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import "Discount.h"

@implementation Discount

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self=[[NSBundle mainBundle] loadNibNamed:@"Discount" owner:self options:nil][0];
        frame.size.width=160;
        frame.size.height=286;
        self.frame=frame;
        self.numArray = [[NSMutableArray alloc]init];
        

    }
    return self;
}


- (IBAction)numBtnActn:(UIButton *)sender {
    
    NSLog(@"text is %@",sender.titleLabel.text);
    
    NSString *numStr = sender.titleLabel.text;
    
    [self.numArray addObject:numStr];
    
    [self strMethod:self.numArray];
    
}

-(void)strMethod:(NSMutableArray *)array{
    
    NSString * result = [array componentsJoinedByString:@""];
    
    NSLog(@"str %@",result);
    
    self.myTF.text = result;
    
    
}

- (IBAction)okBtnActn:(id)sender {
    
    [_delegate reslut:self.myTF.text];
    self.myTF.text = @"";
    [self removeFromSuperview];
    
}



@end
