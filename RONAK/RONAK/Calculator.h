//
//  Calculator.h
//  CalcTask
//
//  Created by Gaian on 8/28/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{ Plus,Minus,Multiply,Divide} CalcOperation;

@interface Calculator : UIView
{
    
    NSString *storage;
    CalcOperation operation;
}

- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button4:(id)sender;
- (IBAction)button5:(id)sender;
- (IBAction)button6:(id)sender;
- (IBAction)button7:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *button8;
- (IBAction)button9:(id)sender;
- (IBAction)button0:(id)sender;
- (IBAction)clearDisplay:(id)sender;
- (IBAction)multiplyButton:(id)sender;
- (IBAction)minusButton:(id)sender;
- (IBAction)plusButton:(id)sender;
- (IBAction)equalsButton:(id)sender;
- (IBAction)divideButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *displayTF;
- (IBAction)button8:(id)sender;
- (IBAction)button3:(id)sender;
- (IBAction)buttondot:(id)sender;


@end
