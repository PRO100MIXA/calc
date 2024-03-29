//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Mikhael on 05.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;

@property (readonly) id program;
+(double) runProgram:(id)program;
+(NSString *)descriptionOfProgram:(id)program;
@end