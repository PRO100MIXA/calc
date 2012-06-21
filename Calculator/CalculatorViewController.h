//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Mikhael on 05.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *history;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (nonatomic) NSString *historyInMemory;
@property (nonatomic) NSString *displayInMemory;

- (IBAction)backSpacePressed;
- (IBAction)clearPressed;
- (IBAction)operationChangeOfSignPressed;
- (IBAction)enterPressed;

@end
