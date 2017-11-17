//
//  Calc.h
//  CalTsk
//
//  Created by TTPLCOMAC1 on 13/11/17.
//  Copyright © 2017 TTPLCOMAC1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{ Plus,Minus,Multiply,Divide} CalcOperation;

@interface Calculator : UIView

{
    NSString *storage;
    CalcOperation operation;
    BOOL signDetect;

}
- (IBAction)clearButton:(id)sender;
- (IBAction)numBtnActn:(id)sender;
- (IBAction)modBtnActn:(id)sender;
- (IBAction)plsMnsBtnActn:(id)sender;
- (IBAction)plusButton:(id)sender;
- (IBAction)minusButton:(id)sender;
- (IBAction)multiplyButton:(id)sender;
- (IBAction)divideButton:(id)sender;
- (IBAction)equalsButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *displayTF;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSString *equalsStr;
@property BOOL dotDetect;
@property BOOL minBool;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;

@end
