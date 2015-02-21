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
    }];
}

- (void)testSum {
    CGVector v1 = CGVectorMake(1, 2);
    CGVector v2 = CGVectorMake(3, 4);
    
    CGVector result = CGVectorSum(v1, v2);
    XCTAssertEqualWithAccuracy(result.dx, 4, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(result.dy, 6, FLT_EPSILON);
}

@end
