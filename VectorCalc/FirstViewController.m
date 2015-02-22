//
//  FirstViewController.m
//  VectorCalc
//
//  Created by Michael Ho on 2015-02-19.
//  Copyright (c) 2015 michaelchum. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *leftUnitLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *rightUnitLabels;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentForm;

@end

@implementation FirstViewController

- (IBAction)formChanged:(id)sender {
    if (self.segmentForm.selectedSegmentIndex == 0) {
        [self changeToCartesian];
    } else if (self.segmentForm.selectedSegmentIndex == 1) {
        [self changeToPolar];
    }
    [self displayResults];
}

- (IBAction)computePushed:(id)sender {
    if ([self isAllValidInput] == NO) return;
    [self storeVectors];
    [self compute];
    [self displayResults];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self changeToCartesian];
    [self clearDisplayResults];
    
    self.vectorOneX.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorOneX.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorOneX.delegate = self;

    self.vectorOneY.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorOneY.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorOneY.delegate = self;

    self.vectorTwoX.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorTwoX.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorTwoX.delegate = self;
    
    self.vectorTwoY.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorTwoY.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorTwoY.delegate = self;
    
    self.vectorThreeX.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorThreeX.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorThreeX.delegate = self;
    
    self.vectorThreeY.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorThreeY.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorThreeY.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.vectorOneX resignFirstResponder];
    [self.vectorOneY resignFirstResponder];
    [self.vectorTwoX resignFirstResponder];
    [self.vectorTwoY resignFirstResponder];
    [self.vectorThreeX resignFirstResponder];
    [self.vectorThreeY resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ( [self isValidFloat:[textField text]] ) {
        [textField setTextColor:[UIColor blackColor]];
    } else {
        [textField setTextColor:[UIColor redColor]];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.shouldDisplayResults = NO;
    [self clearDisplayResults];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ( [self isValidFloat:[textField text]] ) {
        [textField setTextColor:[UIColor blackColor]];
    } else {
        [textField setTextColor:[UIColor redColor]];
    }
}

- (BOOL)isAllValidInput {
    if ([self isAllValidFloats] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid input"
                                                        message:@"At least one of the vector's have wrong input(s) please make sure all input(s) are floats before performing an operation."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    } else if ([self isValidVectorWithX:self.vectorOneX andY:self.vectorOneY] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid vector"
                                                        message:@"Vector 1 is invalid."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    } else if ([self isValidVectorWithX:self.vectorTwoX andY:self.vectorTwoY] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid vector"
                                                        message:@"Vector 2 is invalid."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else if ([self isValidVectorWithX:self.vectorThreeX andY:self.vectorThreeY] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid vector"
                                                        message:@"Vector 3 is invalid."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    } else if ([self hasAtLeastTwoVectors] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not enough vectors"
                                                        message:@"At least two valid vectors are required to perform operation."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

- (BOOL)isValidFloat:(NSString*)input {
    BOOL result = NO;
    // strip negative sign
    if([input hasPrefix:@"-"]) input = [input substringFromIndex:1];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    result = [regex numberOfMatchesInString:input options:0 range:NSMakeRange(0, [input length])];
    return result;
}

- (BOOL)isAllValidFloats {
    return [self isValidFloat:[self.vectorOneX text]] &&
    [self isValidFloat:[self.vectorOneY text]] &&
    [self isValidFloat:[self.vectorTwoX text]] &&
    [self isValidFloat:[self.vectorTwoY text]] &&
    [self isValidFloat:[self.vectorThreeX text]] &&
    [self isValidFloat:[self.vectorThreeY text]];
}

- (BOOL)isValidVectorWithX:(UITextField *)firstVector andY:(UITextField *)secondVector {
    return [self isValidFloat:[self.vectorOneX text]] && [self isValidFloat:[self.vectorOneY text]] &&
    !(firstVector.text.length == 0 && secondVector.text.length != 0) &&
    !(firstVector.text.length != 0 && secondVector.text.length == 0);
}

- (BOOL)hasAtLeastTwoVectors {
    return (self.vectorOneX.text.length != 0 && self.vectorOneY.text.length != 0 && self.vectorTwoX.text.length != 0 && self.vectorTwoY.text.length != 0) || (self.vectorOneX.text.length != 0 && self.vectorOneY.text.length != 0 && self.vectorThreeX.text.length != 0 && self.vectorThreeY.text.length != 0) || (self.vectorTwoX.text.length != 0 && self.vectorTwoY.text.length != 0 && self.vectorThreeX.text.length != 0 && self.vectorThreeY.text.length != 0) || (self.vectorOneX.text.length != 0 && self.vectorOneY.text.length != 0 && self.vectorTwoX.text.length != 0 && self.vectorTwoY.text.length != 0 && self.vectorThreeX.text.length != 0 && self.vectorThreeY.text.length != 0);
}

- (void)changeToCartesian {
    self.isCurrentCartesian = YES;
    for (UILabel *unitLabel in self.leftUnitLabels) unitLabel.text = @"î";
    for (UILabel *unitLabel in self.rightUnitLabels) unitLabel.text = @"ĵ";
    self.vectorOneX.placeholder = @"X unit";
    self.vectorOneY.placeholder = @"Y unit";
    self.vectorTwoX.placeholder = @"X unit";
    self.vectorTwoY.placeholder = @"Y unit";
    self.vectorThreeX.placeholder = @"X unit";
    self.vectorThreeY.placeholder = @"Y unit";
}

- (void)changeToPolar {
    self.isCurrentCartesian = NO;
    for (UILabel *unitLabel in self.leftUnitLabels) unitLabel.text = @"ȓ";
    for (UILabel *unitLabel in self.rightUnitLabels) unitLabel.text = @"°";
    self.vectorOneX.placeholder = @"norm";
    self.vectorOneY.placeholder = @"angle";
    self.vectorTwoX.placeholder = @"norm";
    self.vectorTwoY.placeholder = @"angle";
    self.vectorThreeX.placeholder = @"norm";
    self.vectorThreeY.placeholder = @"angle";
}

- (NSInteger)numberOfVectors {
    int count = 0;
    self.isVectorOne = NO;
    self.isVectorTwo = NO;
    self.isVectorThree = NO;
    if (self.vectorOneX.text.length != 0 && self.vectorOneY.text.length != 0) {
        self.isVectorOne = YES;
        count ++;
    }
    if (self.vectorTwoX.text.length !=0 && self.vectorTwoY.text.length != 0) {
        self.isVectorTwo = YES;
        count++;
    }
    if (self.vectorThreeX.text.length != 0 && self.vectorThreeY.text.length != 0) {
        self.isVectorThree = YES;
        count++;
    }
    return count;
}

- (void)resetVectors {
    self.vectorOneCartesian = CGVectorMake(0.0, 0.0);
    self.vectorTwoCartesian = CGVectorMake(0.0, 0.0);
    self.vectorThreeCartesian = CGVectorMake(0.0, 0.0);
    self.vectorOnePolar = CGVectorMake(0.0, 0.0);
    self.vectorTwoPolar = CGVectorMake(0.0, 0.0);
    self.vectorThreePolar = CGVectorMake(0.0, 0.0);
}

- (void)storeVectors {
    self.numberVectors = [self numberOfVectors];
    [self resetVectors];
    if (self.isCurrentCartesian == YES) {
        if (self.isVectorOne) {
            self.vectorOneCartesian = CGVectorMake(self.vectorOneX.text.floatValue,self.vectorOneY.text.floatValue);
            self.vectorOnePolar = CGVectorMake(CGVectorLength(self.vectorOneCartesian), CGVectorAngle(self.vectorOneCartesian));
        }
        if (self.isVectorTwo) {
            self.vectorTwoCartesian = CGVectorMake(self.vectorTwoX.text.floatValue,self.vectorTwoY.text.floatValue);
            self.vectorTwoPolar = CGVectorMake(CGVectorLength(self.vectorTwoCartesian), CGVectorAngle(self.vectorTwoCartesian));
        }
        if (self.isVectorThree) {
            self.vectorThreeCartesian = CGVectorMake(self.vectorThreeX.text.floatValue,self.vectorThreeY.text.floatValue);
            self.vectorThreePolar = CGVectorMake(CGVectorLength(self.vectorThreeCartesian), CGVectorAngle(self.vectorThreeCartesian));
        }
    } else if (self.isCurrentCartesian == NO) {
        if (self.isVectorOne) {
            self.vectorOnePolar = CGVectorMake(self.vectorOneX.text.floatValue,self.vectorOneY.text.floatValue);
            self.vectorOneCartesian = [self polarToCartesian:self.vectorOnePolar];
        }
        if (self.isVectorTwo) {
            self.vectorTwoPolar = CGVectorMake(self.vectorTwoX.text.floatValue,self.vectorTwoY.text.floatValue);
            self.vectorTwoCartesian = [self polarToCartesian:self.vectorTwoPolar];
        }
        if (self.isVectorThree) {
            self.vectorThreePolar = CGVectorMake(self.vectorThreeX.text.floatValue,self.vectorThreeY.text.floatValue);
            self.vectorThreeCartesian = [self polarToCartesian:self.vectorThreePolar];
        }
    }
}

- (void)compute {
    self.shouldDisplayResults = YES;
    [self addition];
    [self scalarProduct];
    [self vectorProduct];
}

- (void)displayResults {
    if (self.shouldDisplayResults == NO) return;
    NSString *sumPrefix = @"The sum is";
    NSString *vectorPrefix = @"The Vect. Prod. of first 2 vectors is ";
    NSString *scalarPrefix = @"The scalar product of vectors is";

    
    if (self.isCurrentCartesian == YES) {
        
        self.sumLabel.text = [NSString stringWithFormat:@"%@ %.2fî %.2fĵ", sumPrefix, self.sumCartesian.dx, self.sumCartesian.dy];
        //self.vectorLabel.text = [NSString stringWithFormat:@"%@ %.2fî %.2fĵ", vectorPrefix, self.vectorCartesian.dx, self.vectorCartesian.dy];
        /*
        
        float vectorOneX = self.vectorOneCartesian.dx;
        float vectorOneY = self.vectorOneCartesian.dy;
        float vectorTwoX = self.vectorTwoCartesian.dx;
        float vectorTwoY = self.vectorTwoCartesian.dy;
        
        
        float answer = vectorOneX*vectorTwoY - (vectorOneY * vectorTwoX);
        _vectorLabel.text = [NSString stringWithFormat:@"%@ %.2f", vectorPrefix, answer];
*/
        if(self.numberVectors > 2){
            self.scalarLabel.text = @"";
            self.vectorLabel.text = @"";
        }else{
            self.scalarLabel.text = [NSString stringWithFormat:@"%@ %.2f", scalarPrefix, self.scalarCartesian];
            self.vectorLabel.text = [NSString stringWithFormat:@"%@ %.2f", vectorPrefix, _vectorCartesian.dx];
            
        }
    
    } else if (self.isCurrentCartesian == NO) {
        
        self.sumLabel.text = [NSString stringWithFormat:@"%@ %.2fȓ %.2f°", sumPrefix, self.sumPolar.dx, self.sumPolar.dy];
       
        
        
        float vectorOneX = _vectorOnePolar.dx * cos((_vectorOnePolar.dy)*M_PI/180);
        float vectorOneY = _vectorOnePolar.dx * sin((_vectorOnePolar.dy)*M_PI/180);
        float vectorTwoX = _vectorTwoPolar.dx * cos((_vectorTwoPolar.dy)*M_PI/180);
        float vectorTwoY = _vectorTwoPolar.dx * sin((_vectorTwoPolar.dy)*M_PI/180);

        double answerCrossPolar = vectorOneX*vectorTwoY - (vectorOneY * vectorTwoX);
        double answerScalarPolar = vectorOneX * vectorTwoX + vectorOneY * vectorTwoY;
      
        if(self.numberVectors > 2){
            self.scalarLabel.text = @"";
            self.vectorLabel.text = @"";
        }else{
            _scalarLabel.text = [NSString stringWithFormat:@"%@ %.2f", scalarPrefix, answerScalarPolar];
            _vectorLabel.text = [NSString stringWithFormat:@"%@ %.2f", vectorPrefix, answerCrossPolar];
            
        }

        //_vectorLabel.text = [NSString stringWithFormat:@"%@ %.2f", vectorPrefix, _vectorPolar.dx];
        //self.vectorLabel.text = [NSString stringWithFormat:@"%@ %.2f", vectorPrefix, _vectorPolar.dx];
    }


}

- (void)clearDisplayResults {
    self.sumLabel.text = @"";
    self.scalarLabel.text = @"";
    self.vectorLabel.text = @"";
}

- (void)addition {
    self.sumCartesian = CGVectorMake(0.0, 0.0);
    if (self.isVectorOne) self.sumCartesian = [self addTwoVectorsCartesian:self.sumCartesian second:self.vectorOneCartesian];
    if (self.isVectorTwo) self.sumCartesian = [self addTwoVectorsCartesian:self.sumCartesian second:self.vectorTwoCartesian];
    if (self.isVectorThree) self.sumCartesian = [self addTwoVectorsCartesian:self.sumCartesian second:self.vectorThreeCartesian];
    self.sumPolar = [self cartesianToPolar:self.sumCartesian];
}

- (void)scalarProduct {
    if (self.isVectorOne && self.isVectorTwo) {
        self.scalarCartesian = [self scalarProductTwoVectorsCartesian:self.vectorOneCartesian second:self.vectorTwoCartesian];
    } else if (self.isVectorTwo && self.isVectorThree) {
        self.scalarCartesian = [self scalarProductTwoVectorsCartesian:self.vectorTwoCartesian second:self.vectorThreeCartesian];
    } else if (self.isVectorOne && self.isVectorThree) {
        self.scalarCartesian = [self scalarProductTwoVectorsCartesian:self.vectorOneCartesian second:self.vectorThreeCartesian];
    } else {
        self.scalarCartesian = 1.0;
    }
}

// DO THIS TUAN
- (void)vectorProduct {
    if (self.isVectorOne && self.isVectorTwo) {
        _vectorCartesian.dx = [self vectorProductTwoVectorsCartesian:self.vectorOneCartesian second:self.vectorTwoCartesian];
    } else if (self.isVectorTwo && self.isVectorThree) {
        _vectorCartesian.dx = [self vectorProductTwoVectorsCartesian:self.vectorTwoCartesian second:self.vectorThreeCartesian];
    } else if (self.isVectorOne && self.isVectorThree) {
        _vectorCartesian.dx = [self vectorProductTwoVectorsCartesian:self.vectorOneCartesian second:self.vectorThreeCartesian];
    } else {
        _vectorCartesian.dx = 1.0;
    }
    _vectorPolar.dx = [self vectorProductTwoVectorsPolar:self.vectorOneCartesian second:self.vectorTwoCartesian];
}

- (CGVector)addTwoVectorsCartesian:(CGVector)first second:(CGVector)second {
    return CGVectorSum(first, second);
}

- (CGVector)addThreeVectorsCartesian:(CGVector)first second:(CGVector)second third:(CGVector)third {
    return CGVectorSum(CGVectorSum(first, second), third);
}

- (CGFloat)scalarProductTwoVectorsCartesian:(CGVector)first second:(CGVector)second {
    return first.dx * second.dx + first.dy * second.dy;
}

- (CGVector)polarToCartesian:(CGVector)polar {
    return CGVectorMake(polar.dx*cos(polar.dy),polar.dx*sin(polar.dy));
}

- (CGVector)cartesianToPolar:(CGVector)cartesian {
    return CGVectorMake(CGVectorLength(cartesian), CGVectorAngle(cartesian));
}

// DO THIS TUAN
//U x V = Ux*Vy - Uy*Vx
- (CGFloat)vectorProductTwoVectorsCartesian:(CGVector)first second:(CGVector)second {
    return CGVectorCrossProduct(first, second);
}
- (CGFloat)vectorProductTwoVectorsPolar:(CGVector)first second:(CGVector)second {
    
    CGVector v1 = [self polarToCartesian:first];
    CGVector v2 = [self polarToCartesian:second];
    
    float vectorOneX = v1.dx * cos((v1.dy)*M_PI/180);
    float vectorOneY = v1.dx * sin((v1.dy)*M_PI/180);
    float vectorTwoX = v2.dx * cos((v2.dy)*M_PI/180);
    float vectorTwoY = v2.dx * sin((v2.dy)*M_PI/180);
    
    double answerCrossPolar = vectorOneX*vectorTwoY - (vectorOneY * vectorTwoX);
    
    
    
    return answerCrossPolar;
}

// DO THIS TUAN
- (CGVector)vectorProductThreeVectorsCartesian:(CGVector)first second:(CGVector)second third:(CGVector)third {
    return CGVectorMake(0.0,0.0);
}

@end
