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
{   //введенные значения... рядом повставлять тоже самое ссылающееся на другое текстовое поле только
    //когда ноль надо ноль вперед добавить, еще проверку на "пи" не забыть
    NSString *digit =  sender.currentTitle;
    if (self.checkNull) { //если пусто или ноля на форме нет
        if ([self.display.text rangeOfString: @"."].length == 0) {  //проверили нет ли точки в поле
            self.display.text = [self.display.text stringByAppendingString:digit];  // нету смело добавляем значение
            self.incertButtons.text = [self.incertButtons.text stringByAppendingString:digit];
        } else {    //есть точка в строке
            if ([digit isEqualToString: @"."]) {    //если вводим точку
                self.display.text = self.display.text;  //ничего не делаем
                self.incertButtons.text = self.incertButtons.text;  //думаю что вообще не нужны эти 2 строки
            } else { // вводим не точку
                self.display.text = [self.display.text stringByAppendingString:digit];  //добавляем значение
                self.incertButtons.text = [self.incertButtons.text stringByAppendingString:digit];
            }
        }
    } else { //если он есть (ноль), а он есть при начале работы
        if ([digit isEqualToString: @"."]) {//если воодим точку
            self.display.text = @"0";
            self.display.text = [self.display.text stringByAppendingString:digit];  //добавляем точку
            self.incertButtons.text = [[self.incertButtons.text stringByAppendingString:@"0"] stringByAppendingString:digit];
            self.checkNull = YES;     //и больше не попадаем в эту проверку        
        } else {    //вводим значение не точку
            self.display.text = digit;  // заменяем ноль
            self.incertButtons.text = [self.incertButtons.text stringByAppendingString:digit];
            self.checkNull = YES;   //больше не входим в эту проверку
        }
    }  
    self.incertButtons.text = [self.incertButtons.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
}
- (IBAction)clearButton:(id)sender {
    self.incertButtons.text = @""; //  введенные значение пустая строка может можно nil
    self.display.text = @"0";   //поле с введенными значениями вернем ноль
    self.checkNull = NO;    //так же вернем в исходное положение
    self.brain = nil; //не знаю но помогло все стереть
}

- (IBAction)backSpaseButton:(id)sender {
//пока не знаю надо subsStringWithrange 

}

- (IBAction)entetPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]]; //в массив добавляем то что введено на экране
    if (self.checkNull) {
        self.incertButtons.text = [self.incertButtons.text stringByAppendingString:@" "]; 
    } else {
        self.incertButtons.text = [[self.incertButtons.text stringByAppendingString:self.display.text] stringByAppendingString:@" "]; 
    }
      
    //пробел к введенным значениям добавляем вместо ентера
    //self.display.text = @"0";
    self.checkNull = NO;    
}
- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.checkNull == YES) [self entetPressed]; 
    double result = [self.brain performOperation:sender.currentTitle]; //передаем к вычислениям и проверкам надпись на кнопке
    //NSLog(@"%f", result);
    NSString *resultString = [NSString stringWithFormat:@"%g", result]; //получаем из результата строку
    //NSLog(@"%a", resultStrng);
    self.incertButtons.text = [self.incertButtons.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
    self.display.text = resultString; //на экран результат вывели
    self.incertButtons.text = [[[self.incertButtons.text stringByAppendingString:sender.currentTitle] stringByAppendingString:@" "] stringByAppendingString:@"="];    
    //результаты не подходят поэтому просто к введенным значениям добавляем надпись и пробел после нее чтобы визуально разделить все
}
  
- (void)viewDidUnload {
    [self setIncertButtons:nil];
    [super viewDidUnload];
}
@end
 