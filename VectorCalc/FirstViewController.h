//
//  FirstViewController.h
//  VectorCalc
//
//  Created by Michael Ho on 2015-02-19.
//  Copyright (c) 2015 michaelchum. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@property BOOL isCurrentCartesian;

@property int numberVectors;

@property CGVector vectorOneCartesian;
@property CGVector vectorTwoCartesian;
@property CGVector vectorThreeCartesian;

@property CGVector vectorOnePolar;
@property CGVector vectorTwoPolar;
@property CGVector vectorThreePolar;

@property CGVector sumCartesian;
@property CGVector scalarCartesian;
@property CGVector vectorCartesian;

@property CGVector sumPolar;
@property CGVector scalarPolar;
@property CGVector vectorPolar;

@end

