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
    if (_operandStack == Nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

-(void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithBool:operand]];
}

-(double)popOperand
{
    NSNumber *operandObkect = [self.operandStack lastObject];
    if (operandObkect) [self.operandStack removeLastObject];
    return [operandObkect doubleValue];
}

- (double)performOperation:(NSString *)operation
{
    double result = 0; //возвращаемый результат булевый 
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    }
    return result; //вернули результат 
} 

@end
