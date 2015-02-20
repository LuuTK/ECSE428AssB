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
@property (weak, nonatomic) IBOutlet UILabel *productLabel;

@property int numberVectors;

@property CGVector vectorOne;
@property CGVector vectorTwo;
@property CGVector vectorThree;

@end

