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
@property  (nonatomic) BOOL checkNull; //определяем переменную булевую (0 или 1) 
@property (nonatomic, strong) CalculatorBrain * brain;
@end

@implementation CalculatorViewController


@synthesize display = _display; //что то вроде автоматического создания чего то 
@synthesize checkNull = checkNull; 
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}



- (IBAction)digitPressed:(UIButton *)sender //при нажатии на кнопку переменной присваиваем передаваемое значение (передается объект вроде как) 
{
    NSString *digit =  sender.currentTitle; // переменной digit присвоили наименование отображаемое на кнопке
    if (self.checkNull) { //если нет в тектовом поле нуля как проверили пока не понял
        if ([self.display.text rangeOfString: @"."].length == 0) { //проверили нет ли точки в поле
            if (digit == @".") { //проверяем что вводим а то число введем и не введется
                self.display.text = [self.display.text stringByAppendingString:digit];
            } else {
                self.display.text = [self.display.text stringByAppendingString:digit];
            }
        } else {
            if (digit == @".") {
                self.display.text = self.display.text;
            } else {
                self.display.text = [self.display.text stringByAppendingString:digit]; //добавляем к текстовому полю наименование кнопки 
            }
        }
    } else { //если он есть, а он есть при начале работы
    ////if ([self.display.text rangeOfString: @"."].length == 0) {
            //self.display.text = digit; //присваиваем текстовому полю значение нажатой кнопки
            //self.checkNull = YES; //больше не возвращаемся сюда (не проходим проверку)
        //} else {
        if (digit == @".") {
            self.display.text = [self.display.text stringByAppendingString:digit];
            self.checkNull = YES;               
        } else {
            self.display.text = digit;
            self.checkNull = YES; 
        }
        //} 
       // else {
            //self.display.text = [self.display.text stringByAppendingString:digit];
        //}
    }        
    
}
- (IBAction)entetPressed //по нажатию на ввод
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    //self.display.text = @"0";
    self.checkNull = NO;

    
}
- (IBAction)operationPressed:(UIButton *)sender // по нажатию на кнопку действия
{
    if (self.checkNull == YES) [self entetPressed]; 
    double result = [self.brain performOperation:sender.currentTitle];
    //NSLog(@"%f", result);
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    //NSLog(@"%a", resultStrng);
    self.display.text = resultString;
}
  
@end
 