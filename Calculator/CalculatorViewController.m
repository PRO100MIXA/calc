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
@property (nonatomic, strong) CalculatorBrain *Brain;
@end

@implementation CalculatorViewController


@synthesize display = _display; //что то вроде автоматического создания чего то 
@synthesize checkNull = checkNull; 
@synthesize Brain = _Brain;

-(CalculatorBrain *)Brain
{
    if (!_Brain) _Brain = [[CalculatorBrain alloc] init];
    return _Brain;
}


- (IBAction)digitPressed:(UIButton *)sender //при нажатии на кнопку переменной присваиваем передаваемое значение (передается объект вроде как) 
{
    NSString *digit =  sender.currentTitle; // переменной digit присвоили наименование отображаемое на кнопке 
    if (self.checkNull) { //если нет в тектовом поле нуля как проверили пока не понял
        self.display.text = [self.display.text stringByAppendingString:digit]; //добавляем к текстовому полю наименование кнопки
    } else { //если он есть, а он есть при начале работы
        self.display.text = digit; //присваиваем текстовому полю значение нажатой кнопки
        self.checkNull = YES; //больше не возвращаемся сюда (не проходим проверку)
    }
        
    
}
- (IBAction)entetPressed //по нажатию на ввод
{
    [self.Brain pushOperand:[self.display.text doubleValue]];
    self.checkNull = NO;
    
}
- (IBAction)operationPressed:(UIButton *)sender // по нажатию на кнопку действия
{
    if (self.checkNull) [self entetPressed]; 
    double result = [self.Brain performOperation:sender.currentTitle];
    NSLog(@"%d", result);
    NSString *resultStrng = [NSString stringWithFormat:@"%d", result];
    self.display.text = resultStrng;
}
  
@end
 