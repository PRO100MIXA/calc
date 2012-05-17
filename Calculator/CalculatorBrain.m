//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Mikhael on 05.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack; //массив динамичный вроде
@end


@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

-(NSMutableArray *)operandStack
{
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

-(void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

-(double)popOperand
{
    NSNumber *operandObkect = [self.operandStack lastObject];
    if (operandObkect) [self.operandStack removeLastObject];
    return [operandObkect doubleValue];
}

-(double)performOperation:(NSString *)operation
{   
    double result = 0; 
    if ([operation isEqualToString:@"+"]) {  //тут понятно значение на кнопке передали с перевели в строку и стравнили
        //NSLog(@"%f", result);
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        //NSLog(@"%f", result);
        result = - [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        //NSLog(@"%f", result);
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"/"]) {
        //NSLog(@"%f", result);
        result = 1 / [self popOperand] * [self popOperand];
    }
    [self pushOperand:result];
    return result; //вернули результат 
} 

@end
