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
        self.displayTF.delegate=self;
        _plusOrMinusButton.selected=YES;
        
    }
    return self;
}


- (IBAction)button1:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@1",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
}

- (IBAction)button2:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@2",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
}

- (IBAction)button3:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@3",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
    
}

- (IBAction)button4:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@4",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
}

- (IBAction)button5:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@5",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
}

- (IBAction)button6:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@6",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
}

- (IBAction)button7:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@7",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
}

- (IBAction)button8:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@8",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
}

- (IBAction)button9:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@9",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
}

- (IBAction)button0:(id)sender {
    if(operation){
        self.displayTF.text=@"";
    }
    self.displayTF.text=[NSString stringWithFormat:@"%@0",self.displayTF.text];
    [_clearButton setTitle:@"C" forState:UIControlStateNormal];
}

- (IBAction)clearDisplay:(id)sender {
    self.displayTF.text = @"";
    [_clearButton setTitle:@"AC" forState:UIControlStateNormal];
}

- (IBAction)multiplyButton:(id)sender {
    operation = Multiply;
    storage = self.displayTF.text;
}

- (IBAction)minusButton:(id)sender {
    operation = Minus;
    storage = self.displayTF.text;
}

- (IBAction)plusButton:(id)sender {
    
    operation = Plus;
    storage = self.displayTF.text;
}

- (IBAction)equalsButton:(id)sender {
    
    NSString *val = self.displayTF.text;
    if([val containsString:@"."])
    {
        switch(operation) {
            case Plus :
                self.displayTF.text= [NSString stringWithFormat:@"%f",[storage floatValue]+[val floatValue]];
                break;
            case Minus:
                self.displayTF.text= [NSString stringWithFormat:@"%f",[storage floatValue]-[val floatValue]];
                break;
            case Divide:
                self.displayTF.text= [NSString stringWithFormat:@"%f",[storage floatValue]/[val floatValue]];
                break;
            case Multiply:
                self.displayTF.text= [NSString stringWithFormat:@"%f",[val floatValue]*[val floatValue]];
                break;
        }
        
    }
    else{
        switch(operation) {
            case Plus :
                self.displayTF.text= [NSString stringWithFormat:@"%ld",[storage integerValue]+[val integerValue]];
                break;
            case Minus:
                self.displayTF.text= [NSString stringWithFormat:@"%ld",[storage integerValue]-[val integerValue]];
                break;
            case Divide:
                self.displayTF.text= [NSString stringWithFormat:@"%f",[storage floatValue]/[val floatValue]];
                break;
            case Multiply:
                self.displayTF.text= [NSString stringWithFormat:@"%ld",[storage integerValue]*[val integerValue]];
                break;
        }
    }
    
    operation=0;
    
    
}

- (IBAction)divideButton:(id)sender {
    operation = Divide;
    storage = self.displayTF.text;
}



- (IBAction)buttondot:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%@.",self.displayTF.text];
}

- (IBAction)plusOrMinusClick:(id)sender {
    if(_plusOrMinusButton.isSelected){
        _plusOrMinusButton.selected=NO;
        self.displayTF.text=[NSString stringWithFormat:@"-%@",self.displayTF.text];
    }
    else{
        _plusOrMinusButton.selected=YES;
         self.displayTF.text=[NSString stringWithFormat:@"%@",[self.displayTF.text stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    }
        
}


- (IBAction)percentageClick:(id)sender {
    self.displayTF.text=[NSString stringWithFormat:@"%f",self.displayTF.text.floatValue/100.0];
}

@end
