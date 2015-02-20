//
//  FirstViewController.m
//  VectorCalc
//
//  Created by Michael Ho on 2015-02-19.
//  Copyright (c) 2015 michaelchum. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (IBAction)computePushed:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.vectorOneX.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorOneX.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorOneX.placeholder = @"X unit";
    self.vectorOneX.delegate = self;

    self.vectorOneY.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorOneY.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorOneY.placeholder = @"Y unit";
    self.vectorOneY.delegate = self;

    self.vectorTwoX.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorTwoX.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorTwoX.placeholder = @"X unit";
    self.vectorTwoX.delegate = self;
    
    self.vectorTwoY.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorTwoY.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorTwoY.placeholder = @"Y unit";
    self.vectorTwoY.delegate = self;
    
    self.vectorThreeX.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorThreeX.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorThreeX.placeholder = @"X unit";
    self.vectorThreeX.delegate = self;
    
    self.vectorThreeY.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.vectorThreeY.autocorrectionType = UITextAutocorrectionTypeNo;
    self.vectorThreeY.placeholder = @"Y unit";
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

- (NSInteger)numberOfVectors {
    int count = 0;
    if (self.vectorOneX.text.length != 0 && self.vectorOneY.text.length != 0) {
        count++;
    }
    if (self.vectorTwoX.text.length !=0 && self.vectorTwoY.text.length != 0) {
        count++;
    }
    if (self.vectorThreeX.text.length != 0 && self.vectorThreeY.text.length != 0) {
        count++;
    }
    return count;
}

- (float)addTwoVectors:(float)firstVector secondVector:(float)secondVector {
    return 2.0;
}

- (float)addThreeVectors:(float)firstVector secondVector:(float)secondVector thirdVector:(float)thirdVector {
    return 2.0;
}

- (float)multiplyTwoVectors:(float)firstVector secondVector:(float)secondVector {
    return 2.0;
}

- (float)multiplyThreeVectors:(float)firstVector secondVector:(float)secondVector thirdVector:(float)thirdVector {
    return 2.0;
}

- (IBAction)computePushed:(id)sender {
}
@end
