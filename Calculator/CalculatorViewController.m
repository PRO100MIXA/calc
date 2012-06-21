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
@property  (nonatomic) BOOL displayIsEmpty;
@property (nonatomic, strong) CalculatorBrain * brain;
@end

@implementation CalculatorViewController

@synthesize history = _history;
@synthesize display = _display; 
@synthesize displayIsEmpty = _displayIsEmpty; 
@synthesize brain = _brain;
@synthesize historyInMemory = _historyInMemory;
@synthesize displayInMemory = _displayInMemory;

-(CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

-(void) setHistoryInMemory:(NSString *)newValue { 
    self.history.text = newValue;
}

-(void) setDisplayInMemory:(NSString *)newValue { 
    self.display.text = newValue;
}

- (IBAction)digitPressed:(UIButton *)sender
{  
    NSString *digit =  sender.currentTitle;
    //NSLog(@"%g", self.displayInMemory);
        if (self.displayIsEmpty) { 
            if ([self.displayInMemory rangeOfString: @"."].length == 0) { 
                self.displayInMemory = [self.displayInMemory stringByAppendingString:digit];
                self.historyInMemory = [self.historyInMemory stringByAppendingString:digit];
            } else {   
                if ([digit isEqualToString: @"."]) { 
                    self.displayInMemory = self.displayInMemory; 
                    self.historyInMemory = self.historyInMemory; 
                } else { 
                    self.displayInMemory = [self.displayInMemory stringByAppendingString:digit];  
                    self.historyInMemory = [self.historyInMemory stringByAppendingString:digit];
                }
            }
        } else {
            if ([digit isEqualToString: @"."]) {
                self.displayInMemory = @"0";
                self.displayInMemory = [self.displayInMemory stringByAppendingString:digit];
                self.historyInMemory = [[self.historyInMemory stringByAppendingString:@"0"] stringByAppendingString:digit];
                self.displayIsEmpty = YES;       
            } else {  
                self.displayInMemory = digit; 
                self.historyInMemory = [self.historyInMemory stringByAppendingString:digit];
                self.displayIsEmpty = YES;  
            }
        }
    self.historyInMemory = [self.historyInMemory stringByReplacingOccurrencesOfString:@"=" withString:@""];
}

- (IBAction)backSpacePressed {
    NSUInteger len;
    self.display.text = self.display.text;
    len = [self.display.text length];
    if (len == 1) {
        //NSLog(@"%d", len);
        [self clearPressed];
    } else {
        self.display.text = [self.display.text substringToIndex:len-1];
        self.displayIsEmpty = YES; 
        len = [self.history.text length];
        //NSLog(@"%d", len);
        if ([self.history.text rangeOfString: @"="].length == 0){
            self.history.text = [self.history.text substringToIndex:len-1];
        }
    }
}

- (IBAction)clearPressed {
    self.history.text = @""; 
    self.display.text = @"0"; 
    self.displayIsEmpty = NO;   
    self.brain = nil;
}

- (IBAction)operationChangeOfSignPressed {
    self.display.text = [NSString stringWithFormat:@"%g", [self.display.text doubleValue]*(-1)];
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    if (self.displayIsEmpty) {
        self.history.text = [self.history.text stringByAppendingString:@" "]; 
    } else {
        self.history.text = [[self.history.text stringByAppendingString:self.display.text] stringByAppendingString:@" "]; 
    }
    //self.display.text = @"0";
    self.displayIsEmpty = NO;    
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.displayIsEmpty == YES) [self enterPressed]; 
    double result = [self.brain performOperation:sender.currentTitle]; 
    //NSLog(@"%f", result);
    NSString *resultString = [NSString stringWithFormat:@"%g", result]; 
    //NSLog(@"%a", resultStrng);
    self.history.text = [self.history.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
    self.display.text = resultString; 
    self.history.text = [[[self.history.text stringByAppendingString:sender.currentTitle] stringByAppendingString:@" "] stringByAppendingString:@"="];    
}
  
- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
- (IBAction)operationChangeOfSign:(id)sender {
}
@end
 