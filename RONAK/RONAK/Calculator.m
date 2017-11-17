//
//  Calc.m
//  CalTsk
//
//  Created by TTPLCOMAC1 on 13/11/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Calculator class]) owner:self options:nil][0];
        frame.size.width=212;
        frame.size.height=330;
        self.frame=frame;
        self.dataArray = [[NSMutableArray alloc]init];

        
    }
    return self;
}


- (IBAction)clearButton:(id)sender {
    
    self.dotDetect = NO;
    self.dataArray = [[NSMutableArray alloc]init];
    self.displayTF.text = @"0";
    self.equalsStr = @"";
    [self.clearButton setTitle:@"AC" forState:UIControlStateNormal];
    signDetect = NO;
}

- (IBAction)numBtnActn:(UIButton*)sender {
    if ([self.displayTF.text isEqualToString:@"0"]) {
        self.dataArray = [[NSMutableArray alloc]init];
        self.displayTF.text = @"";
        self.equalsStr = @"";
    }
    
    [self.clearButton setTitle:@"C" forState:UIControlStateNormal];
    NSLog(@"title %@",sender.currentTitle);
    
    
    
    NSString *str = sender.titleLabel.text;
    if ([str isEqualToString:@"."]) {
        self.dotDetect = YES;
    }
    if ([self.dataArray containsObject:@"."] && [str isEqualToString:@"."]) {
    }else{
        if (signDetect == YES) {
            signDetect = NO;
            [self.dataArray addObject:@"-"];
        }
        [self.dataArray addObject:str];
        NSLog(@"data array %@",self.dataArray);
        NSString *joinedString = [self.dataArray componentsJoinedByString:@""];
        self.displayTF.text=joinedString;
    }

}

- (IBAction)modBtnActn:(id)sender {
    float val = [self.displayTF.text floatValue];
    float calcVal = val/100;
    //    if (self.dotDetect == YES) {
    //        self.displayTF.text= [NSString stringWithFormat:@"%.1f",calcVal];
    //    }
    //    else{
    self.displayTF.text= [NSString stringWithFormat:@"%.2f",calcVal];
    storage = self.displayTF.text;
    //self.displayTF.text=@"";
    self.equalsStr = self.displayTF.text;
    NSLog(@"eql %@",self.equalsStr);
    self.dotDetect = YES;
    //}

}

- (IBAction)plsMnsBtnActn:(id)sender {
    NSString *strSign = self.displayTF.text;
    
    if([strSign hasPrefix:@"-"]) {
        signDetect = NO;
        strSign = [strSign stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
    }else{
        signDetect = YES;
        strSign = [NSString stringWithFormat:@"-%@",strSign];
    }
    
    //storage = strSign;
    self.equalsStr = strSign;
    self.displayTF.text= strSign;
    
    if (self.minBool == YES) {
        self.minBool = NO;
        self.equalsStr = @"";
    }
    

}

- (IBAction)plusButton:(id)sender {
    self.dataArray = [[NSMutableArray alloc]init];
    operation = Plus;
    storage = self.displayTF.text;
    self.displayTF.text=@"";
    signDetect = NO;
    self.equalsStr = @"";
}

- (IBAction)minusButton:(id)sender {
    self.minBool = YES;
    self.dataArray = [[NSMutableArray alloc]init];
    operation = Minus;
    storage = self.displayTF.text;
    self.displayTF.text=@"";
    signDetect = NO;
    self.equalsStr = @"";

}

- (IBAction)multiplyButton:(id)sender {
    self.dataArray = [[NSMutableArray alloc]init];
    operation = Multiply;
    storage = self.displayTF.text;
    self.displayTF.text=@"";
    self.equalsStr = @"";
    signDetect = NO;

}

- (IBAction)divideButton:(id)sender {
    self.dataArray = [[NSMutableArray alloc]init];
    operation = Divide;
    storage = self.displayTF.text;
    self.displayTF.text=@"";
    signDetect = NO;
    self.equalsStr = @"";

}

- (IBAction)equalsButton:(id)sender {
    NSString *val = self.displayTF.text;
    if ([val isEqualToString:@"0"]) {
        self.dotDetect = NO;
    }
    if ([self.equalsStr isEqualToString:@"-"]) {
        self.equalsStr = @"";
        self.equalsStr = storage;
    }
    
    switch(operation) {
        case Plus :
            if (self.equalsStr.length) {
                if (self.dotDetect == YES) {
                    self.displayTF.text= [NSString stringWithFormat:@"%.2f",[self.equalsStr floatValue]+[val floatValue]];
                }else{
                    self.displayTF.text= [NSString stringWithFormat:@"%.f",[self.equalsStr floatValue]+[val floatValue]];
                }
            }else{
                if (self.dotDetect == YES) {
                    self.displayTF.text= [NSString stringWithFormat:@"%.2f",[storage floatValue]+[val floatValue]];
                }else{
                    self.displayTF.text= [NSString stringWithFormat:@"%.f",[storage floatValue]+[val floatValue]];
                }
            }
            break;
        case Minus:
            if (self.equalsStr.length) {
                //                if ([val containsString:@"-"]) {
                //                    val = [val stringByReplacingOccurrencesOfString:@"-" withString:@""];
                //                }
                if (self.dotDetect == YES) {
                    self.displayTF.text= [NSString stringWithFormat:@"%.2f",[self.equalsStr floatValue]-[val floatValue]];
                }else{
                    self.displayTF.text= [NSString stringWithFormat:@"%.f",[self.equalsStr floatValue]-[val floatValue]];
                }
            }else{
                if (self.dotDetect == YES) {
                    self.displayTF.text= [NSString stringWithFormat:@"%.2f",[storage floatValue]-[val floatValue]];
                }else{
                    self.displayTF.text= [NSString stringWithFormat:@"%.f",[storage floatValue]-[val floatValue]];
                }
            }
            break;
        case Divide:
            if (self.equalsStr.length) {
                if (self.dotDetect == YES) {
                    self.displayTF.text= [NSString stringWithFormat:@"%.2f",[self.equalsStr floatValue]/[val floatValue]];
                }else{
                    self.displayTF.text= [NSString stringWithFormat:@"%.f",[self.equalsStr floatValue]/[val floatValue]];
                }
            }else{
                if (self.dotDetect == YES) {
                    self.displayTF.text= [NSString stringWithFormat:@"%.2f",[storage floatValue]/[val floatValue]];
                    
                }else{
                    self.displayTF.text= [NSString stringWithFormat:@"%.f",[storage floatValue]/[val floatValue]];
                }
            }
            break;
        case Multiply:
            if (self.equalsStr.length) {
                if (self.dotDetect == YES) {
                    self.displayTF.text= [NSString stringWithFormat:@"%.2f",[self.equalsStr floatValue]*[val floatValue]];
                }else{
                    self.displayTF.text= [NSString stringWithFormat:@"%.f",[self.equalsStr floatValue]*[val floatValue]];
                }
            }else{
                if (self.dotDetect == YES) {
                    self.displayTF.text= [NSString stringWithFormat:@"%.2f",[storage floatValue]*[val floatValue]];
                }else{
                    self.displayTF.text= [NSString stringWithFormat:@"%.f",[storage floatValue]*[val floatValue]];
                }
            }
            break;
    }
    self.equalsStr = self.displayTF.text;
    NSLog(@"eql %@",self.equalsStr);

}
@end
