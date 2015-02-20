//
//  VectorGraphView.h
//  VectorCalc
//
//  Created by Michael Ho on 2015-02-20.
//  Copyright (c) 2015 michaelchum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"

@interface VectorGraphView : UIView

- (void)drawVectorOne:(CGVector)vectorOne;
- (void)drawVectorTwo:(CGVector)vectorTwo;
- (void)drawVectorThree:(CGVector)vectorThree;
- (void)drawSumVector:(CGVector)vector;
- (void)drawProductVector:(CGVector)vector;

@end
