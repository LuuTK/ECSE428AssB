//
//  FirstViewController.h
//  VectorCalc
//
//  Created by Michael Ho on 2015-02-19.
//  Copyright (c) 2015 michaelchum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGVectorAdditions.h"

@interface FirstViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *vectorOneX;
@property (weak, nonatomic) IBOutlet UITextField *vectorOneY;
@property (weak, nonatomic) IBOutlet UITextField *vectorTwoX;
@property (weak, nonatomic) IBOutlet UITextField *vectorTwoY;
@property (weak, nonatomic) IBOutlet UITextField *vectorThreeX;
@property (weak, nonatomic) IBOutlet UITextField *vectorThreeY;

@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UILabel *scalarLabel;
@property (weak, nonatomic) IBOutlet UILabel *vectorLabel;

// YES Cartesian mode - NO Polar mode
@property BOOL isCurrentCartesian;

@property BOOL shouldDisplayResults;

// Total number of vectors non-nil
@property NSInteger numberVectors;

// Vectors 1,2,3 YES non-il - NO nil
@property BOOL isVectorOne;
@property BOOL isVectorTwo;
@property BOOL isVectorThree;

// Vectors 1,2,3 in cartesian coords
@property CGVector vectorOneCartesian;
@property CGVector vectorTwoCartesian;
@property CGVector vectorThreeCartesian;

// Vectors 1,2,3 in polar coords
@property CGVector vectorOnePolar;
@property CGVector vectorTwoPolar;
@property CGVector vectorThreePolar;

// Sum vector in cartesian coords
@property CGVector sumCartesian;
// Vector product in cartesian coords
@property CGVector vectorCartesian;
// Scalar product in float
@property CGFloat scalarCartesian;

// Sum vector in polar coords
@property CGVector sumPolar;
// Vector product in polar coords
@property CGVector vectorPolar;

@end

