//
//  VectorGraphView.m
//  VectorCalc
//
//  Created by Michael Ho on 2015-02-20.
//  Copyright (c) 2015 michaelchum. All rights reserved.
//

#import "VectorGraphView.h"

@implementation VectorGraphView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)drawVectorOne:(CGVector)vectorOne {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *vectorPath = [UIBezierPath bezierPath];
    [vectorPath moveToPoint:CGPointMake(0.0, 0.0)];
    [vectorPath addLineToPoint:CGPointMake(vectorOne.dx, vectorOne.dy)];
    [vectorPath closePath];
    shapeLayer.path = vectorPath.CGPath;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.lineWidth = 4.0;
    [self.layer addSublayer:shapeLayer];
}

- (void)drawVectorTwo:(CGVector)vectorTwo {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *vectorPath = [UIBezierPath bezierPath];
    [vectorPath moveToPoint:CGPointMake(0.0, 0.0)];
    [vectorPath addLineToPoint:CGPointMake(vectorTwo.dx, vectorTwo.dy)];
    [vectorPath closePath];
    shapeLayer.path = vectorPath.CGPath;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 4.0;
    [self.layer addSublayer:shapeLayer];
}

- (void)drawVectorThree:(CGVector)vectorThree {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *vectorPath = [UIBezierPath bezierPath];
    [vectorPath moveToPoint:CGPointMake(0.0, 0.0)];
    [vectorPath addLineToPoint:CGPointMake(vectorThree.dx, vectorThree.dy)];
    [vectorPath closePath];
    shapeLayer.path = vectorPath.CGPath;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.lineWidth = 4.0;
    [self.layer addSublayer:shapeLayer];
}

- (void)drawSumVector:(CGVector)vector {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *vectorPath = [UIBezierPath bezierPath];
    [vectorPath moveToPoint:CGPointMake(0.0, 0.0)];
    [vectorPath addLineToPoint:CGPointMake(vector.dx, vector.dy)];
    [vectorPath closePath];
    shapeLayer.path = vectorPath.CGPath;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.lineWidth = 4.0;
    [self.layer addSublayer:shapeLayer];
}

- (void)drawProductVector:(CGVector)vector {
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *vectorPath = [UIBezierPath bezierPath];
    [vectorPath moveToPoint:CGPointMake(0.0, 0.0)];
    [vectorPath addLineToPoint:CGPointMake(vector.dx, vector.dy)];
    [vectorPath closePath];
    shapeLayer.path = vectorPath.CGPath;
    shapeLayer.strokeColor = [UIColor purpleColor].CGColor;
    shapeLayer.lineWidth = 4.0;
    [self.layer addSublayer:shapeLayer];
}


@end
