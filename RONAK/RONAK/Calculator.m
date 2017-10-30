//
//  Calculator.m
//  CalcTask
//
//  Created by Gaian on 8/28/17.
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

    }
    return self;
}


- (IBAction)button1:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@1",self.displayTF.text];
    
}

- (IBAction)button2:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@2",self.displayTF.text];
    
}

- (IBAction)button4:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@4",self.displayTF.text];
    
}

- (IBAction)button5:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@5",self.displayTF.text];
    
}

- (IBAction)button6:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@6",self.displayTF.text];
    
}

- (IBAction)button7:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@7",self.displayTF.text];
    
}

- (IBAction)button9:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@9",self.displayTF.text];
    
}

- (IBAction)button0:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@0",self.displayTF.text];
    
}

- (IBAction)clearDisplay:(id)sender {
    self.displayTF.text = @"";
    
}

- (IBAction)multiplyButton:(id)sender {
    operation = Multiply;
    storage = self.displayTF.text;
    self.displayTF.text=@"";
}

- (IBAction)minusButton:(id)sender {
    operation = Minus;
    storage = self.displayTF.text;
    self.displayTF.text=@"";
}

- (IBAction)plusButton:(id)sender {
    
    operation = Plus;
    storage = self.displayTF.text;
    self.displayTF.text=@"";
}

- (IBAction)equalsButton:(id)sender {
    
    NSString *val = self.displayTF.text;
    switch(operation) {
        case Plus :
            self.displayTF.text= [NSString stringWithFormat:@"%f",[val floatValue]+[storage floatValue]];
            break;
        case Minus:
            self.displayTF.text= [NSString stringWithFormat:@"%f",[storage floatValue]-[val floatValue]];
            break;
        case Divide:
            self.displayTF.text= [NSString stringWithFormat:@"%f",[storage floatValue]/[val floatValue]];
            break;
        case Multiply:
            self.displayTF.text= [NSString stringWithFormat:@"%f",[val floatValue]*[storage floatValue]];
            break;
    }
    
}

- (IBAction)divideButton:(id)sender {
    operation = Divide;
    storage = self.displayTF.text;
    self.displayTF.text=@"";
}

- (IBAction)button8:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@8",self.displayTF.text];
    
}

- (IBAction)button3:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@3",self.displayTF.text];
    
}

- (IBAction)buttondot:(id)sender {
    
    self.displayTF.text=[NSString stringWithFormat:@"%@.",self.displayTF.text];
}


@end
