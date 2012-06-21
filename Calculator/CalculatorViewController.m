 //
//  CalculatorViewController.m
//  Calculator
//
//  Created by Mikhael on 05.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property  (nonatomic) BOOL checkNull;
@property (nonatomic, strong) CalculatorBrain * brain;
@end

@implementation CalculatorViewController

@synthesize incertButtons = _incertButtons;
@synthesize display = _display; 
@synthesize checkNull = checkNull; 
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{  
    NSString *digit =  sender.currentTitle;
        if (self.checkNull) { 
            if ([self.display.text rangeOfString: @"."].length == 0) { 
                self.display.text = [self.display.text stringByAppendingString:digit];
                self.incertButtons.text = [self.incertButtons.text stringByAppendingString:digit];
            } else {   
                if ([digit isEqualToString: @"."]) { 
                    self.display.text = self.display.text; 
                    self.incertButtons.text = self.incertButtons.text; 
                } else { 
                    self.display.text = [self.display.text stringByAppendingString:digit];  
                    self.incertButtons.text = [self.incertButtons.text stringByAppendingString:digit];
                }
            }
        } else {
            if ([digit isEqualToString: @"."]) {
                self.display.text = @"0";
                self.display.text = [self.display.text stringByAppendingString:digit];
                self.incertButtons.text = [[self.incertButtons.text stringByAppendingString:@"0"] stringByAppendingString:digit];
                self.checkNull = YES;       
            } else {  
                self.display.text = digit; 
                self.incertButtons.text = [self.incertButtons.text stringByAppendingString:digit];
                self.checkNull = YES;  
            }
        }
    self.incertButtons.text = [self.incertButtons.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
}

- (IBAction)backSpace:(id)sender {
    NSUInteger len;
    self.display.text = self.display.text;
    len = [self.display.text length];
    NSLog(@"%d", len);
    if (len == 1) {
        //NSLog(@"%d", len);
        [self clearButton];
    } else {
        self.display.text = [self.display.text substringToIndex:len-1];
        self.checkNull = YES; 
        len = [self.incertButtons.text length];
        //NSLog(@"%d", len);
        if ([self.incertButtons.text rangeOfString: @"="].length == 0){
            self.incertButtons.text = [self.incertButtons.text substringToIndex:len-1];
        }
    }
}

- (IBAction)clearButton {
    self.incertButtons.text = @""; 
    self.display.text = @"0"; 
    self.checkNull = NO;   
    self.brain = nil;
}

- (IBAction)plusOrMinus:(id)sender {
    self.display.text = [NSString stringWithFormat:@"%g", [self.display.text doubleValue]*(-1)];
}

- (IBAction)entetPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    if (self.checkNull) {
        self.incertButtons.text = [self.incertButtons.text stringByAppendingString:@" "]; 
    } else {
        self.incertButtons.text = [[self.incertButtons.text stringByAppendingString:self.display.text] stringByAppendingString:@" "]; 
    }
    //self.display.text = @"0";
    self.checkNull = NO;    
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.checkNull == YES) [self entetPressed]; 
    double result = [self.brain performOperation:sender.currentTitle]; 
    //NSLog(@"%f", result);
    NSString *resultString = [NSString stringWithFormat:@"%g", result]; 
    //NSLog(@"%a", resultStrng);
    self.incertButtons.text = [self.incertButtons.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
    self.display.text = resultString; 
    self.incertButtons.text = [[[self.incertButtons.text stringByAppendingString:sender.currentTitle] stringByAppendingString:@" "] stringByAppendingString:@"="];    
}
  
- (void)viewDidUnload {
    [self setIncertButtons:nil];
    [super viewDidUnload];
}
@end
 