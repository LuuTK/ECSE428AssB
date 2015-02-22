//
//  VectorCalcTests.m
//  VectorCalcTests
//
//  Created by Michael Ho on 2015-02-19.
//  Copyright (c) 2015 michaelchum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CGVectorAdditions.h"
#import "FirstViewController.h"

@interface VectorCalcTests : XCTestCase

@end

@implementation VectorCalcTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [self testSum];
        [self testSumWithNegativeNumbers];
        [self testSumDecimals];
        [self testVectorDotProduct];
        [self testVectorDotProductPolar];
        [self testCrossProduct];
        [self testCrossProductPolar];
        
    }];
}

//Basic test for a summation
- (void)testSum {
    CGVector v1 = CGVectorMake(1, 2);
    CGVector v2 = CGVectorMake(3, 4);
    CGVector v3 = CGVectorMake(0,10);
    
    CGVector result = CGVectorSum(v1, v2);
    CGVector result2 = CGVectorSum(result, v3);
    
    XCTAssertEqualWithAccuracy(result2.dx, 4, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(result2.dy, 16, FLT_EPSILON);
}

- (void)testSumWithNegativeNumbers {
    CGVector v1 = CGVectorMake(1, 2);
    CGVector v2 = CGVectorMake(3, 4);
    CGVector v3 = CGVectorMake(0,-10);
    
    CGVector result = CGVectorSum(v1, v2);
    CGVector result2 = CGVectorSum(result, v3);
   
    
    XCTAssertEqualWithAccuracy(result2.dx, 4, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(result2.dy, -4, FLT_EPSILON);
}

- (void)testSumDecimals {
    CGVector v1 = CGVectorMake(1.545134, 2.13413415);
    CGVector v2 = CGVectorMake(3.13241351, 4.523451324);
    CGVector v3 = CGVectorMake(0.13415123,10.413251341);
    
    CGVector result = CGVectorSum(v1, v2);
    CGVector result2 = CGVectorSum(result, v3);
    
    XCTAssertEqualWithAccuracy((round(result2.dx * 100)/100.0), 4.81, FLT_EPSILON);
    XCTAssertEqualWithAccuracy((round(result2.dy * 100)/100.0), 17.07, FLT_EPSILON);
}

- (void)testVectorDotProduct {
    CGVector v1 = CGVectorMake(2.25, 5.61);
    CGVector v2 = CGVectorMake(3.36, 6.19);
    
    double result = CGVectorDotProduct(v1, v2);
    
    XCTAssertEqualWithAccuracy((round(result * 100)/100.0), 42.29, FLT_EPSILON);
}

- (void)testVectorDotProductPolar {
    CGVector v1 = CGVectorMake(2.23, 64.3);
    CGVector v2 = CGVectorMake(5, 53.1);
    
    double result = CGVectorDotProductScalarPolar(v1, v2);
    
    XCTAssertEqualWithAccuracy((round(result * 100)/100.0), 10.94, FLT_EPSILON);
}

- (void)testCrossProduct {
    CGVector v1 = CGVectorMake(1.41, 2.25);
    CGVector v2 = CGVectorMake(3.90, 4.50);
    
    double result = CGVectorCrossProduct(v1, v2);
    
    XCTAssertEqualWithAccuracy(result, -2.43, FLT_EPSILON);
}

- (void)testCrossProductPolar {
    CGVector v1 = CGVectorMake(2.23, 64.3);
    CGVector v2 = CGVectorMake(5, 53.1);
    
    double result = CGVectorCrossProductPolar(v1, v2);
    
    XCTAssertEqualWithAccuracy((round(result * 100)/100.0), -2.17, FLT_EPSILON);
}

- (void)testDegToRad {

    double degrees = 64.5;
    double answer = degrees * M_PI /180;

    
    XCTAssertEqualWithAccuracy((round(answer * 1000000)/1000000.0), 1.125737, FLT_EPSILON);
}

- (void)testRadToDeg {
    
    double rad = 1.4;
    double answer = rad * 180 / M_PI;
    
    
    XCTAssertEqualWithAccuracy((round(answer * 1000000)/1000000.0), 80.214091, FLT_EPSILON);
}


@end
