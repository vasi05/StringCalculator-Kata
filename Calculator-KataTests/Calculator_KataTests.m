//
//  Calculator_KataTests.m
//  Calculator-KataTests
//
//  Created by Vasile Croitoru on 20/04/16.
//  Copyright © 2016 Vasile Croitoru. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CalculatorMaster.h"

@interface Calculator_KataTests : XCTestCase

@end

@implementation Calculator_KataTests{
    CalculatorMaster * calculator;
}

-(void)setUp{
    calculator = [[CalculatorMaster alloc] init];
}

-(void)testAdd_EmptyString{
    XCTAssertEqual(0,[calculator add:@""]);
}

-(void)testAdd_OneNumber{
    XCTAssertEqual(1, [calculator add:@"1"]);
}

-(void)testAdd_MultipleNumbers{
    XCTAssertEqual(108, [calculator add:@"17,33, 41, 17"]);
}

-(void)testAdd_NegativeNumbers{
    XCTAssertThrows([calculator add:@"17,23,8,15,5,-3,3"],@"Negatives not allowed : -3");
}

-(void)testAdd_ShouldAllowNewLineBetweenNumbers{
    XCTAssertEqual(30,[calculator add:@"1\n24,5"]);
}

-(void)testAdd_CustomDelimiters{
    XCTAssertEqual(7, [calculator add:@"//~\n5~2"]);
}

-(void)testAdd_IgnoreNumbersBiggerThan1000{
     XCTAssertEqual(2, [calculator add:@"2,1001"]);
}

-(void)testAdd_AnyLengthDelimiter{
    XCTAssertEqual(6, [calculator add:@"//[***]\n1***2***3"]);
}

-(void)testAdd_MultipleDelimiters{
    XCTAssertEqual(6, [calculator add:@"//[*][%]\n1*2%3"]);
}

-(void)testAdd_MultipleDelimitersWithAnyLength{
    XCTAssertEqual(6, [calculator add:@"//[****][%%]\n1****2%%3"]);
}

@end
