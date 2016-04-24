//
//  CalculatorMaster.m
//  Calculator-Kata
//
//  Created by Vasile Croitoru on 20/04/16.
//  Copyright © 2016 Vasile Croitoru. All rights reserved.
//

#import "CalculatorMaster.h"

@implementation CalculatorMaster

typedef NS_ENUM(NSInteger, CalculatorNumberType) {
    CalculatorNumberTypeNormal,
    CalculatorNumberTypeIgnored,
    CalculatorNumberTypeNegative
};


-(int)add:(NSString *)numbers{
    NSCharacterSet * delimetersCharacterSet = [self getDelimetersCharacterSet:numbers];
    NSArray * arr = [numbers componentsSeparatedByCharactersInSet:delimetersCharacterSet];
    return [self sumFromArray:arr];
}

-(int)sumFromArray:(NSArray *)arr{
    __block int sum = 0;
    __block NSMutableArray * negativeValues = [[NSMutableArray alloc] init];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int number = [obj intValue];
        int numberType = [self checkValue:number];
        
        switch (numberType) {
            case CalculatorNumberTypeNormal:
                sum += number;
                break;
                
            case CalculatorNumberTypeNegative:
                [negativeValues addObject:obj];
                break;
                
            default:
                break;
        }
        
    }];
    
    if(negativeValues.count){
         [NSException raise:[NSString stringWithFormat:@"Negatives not allowed : %@",[negativeValues componentsJoinedByString:@","]] format:@"Negatives not allowed"];
    }
    
    return sum;
    
    
}


-(int)checkValue:(int)value{
    if(value < 0){
        return  CalculatorNumberTypeNegative;
    }
    else{
        if(value > 1000){
            return CalculatorNumberTypeIgnored;
        }
    }
    
    return CalculatorNumberTypeNormal;
}



-(BOOL)negativeValue:(int)value{
    return value < 0;
}

-(BOOL)ignoreValue:(int)value{
    return value > 1000;
}

-(NSCharacterSet *)getDelimetersCharacterSet:(NSString *)numbers{
    NSString * delimiters = [NSString stringWithFormat:@"\n,"];
    if([numbers hasPrefix:@"//"]){
        NSRange indexOfFirstNewLine = [numbers rangeOfString:@"\n"];
        delimiters = [delimiters stringByAppendingString:[numbers substringToIndex:indexOfFirstNewLine.location]];
    }
    
    [delimiters stringByReplacingOccurrencesOfString:@"[" withString:@""];
    [delimiters stringByReplacingOccurrencesOfString:@"]" withString:@""];
    
    return [NSCharacterSet characterSetWithCharactersInString:delimiters];
}

@end
