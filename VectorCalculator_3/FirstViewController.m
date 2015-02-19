//
//  FirstViewController.m
//  VectorCalculator_3
//
//  Created by Tuan Kiet Luu on 2015-02-18.
//  Copyright (c) 2015 Tuan Kiet Luu. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize firstView_answer, input_vector_one_a, input_vector_one_b, input_vector_two_a, input_vector_two_b, input_vector_three_a, input_vector_three_b;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
bool sFloat:(NSString*) textInput{
    return [[NSScanner scannerWithString:textInput] scanFloat:NULL];
}
*/
int isFloat(NSString* textInput){
    return [[NSScanner scannerWithString:textInput] scanFloat:NULL];
}

- (IBAction)firstView_addition:(id)sender {
    

    NSArray *inputArray = @[input_vector_one_a.text, input_vector_one_b.text, input_vector_two_a.text,input_vector_two_b.text,input_vector_three_a.text,input_vector_three_b.text];
    
    float vectorOneA = ([input_vector_one_a.text floatValue]);
    float vectorOneB = ([input_vector_one_b.text floatValue]);
    float vectorTwoA = ([input_vector_two_a.text floatValue]);
    float vectorTwoB = ([input_vector_two_b.text floatValue]);
    float vectorThreeA = ([input_vector_three_a.text floatValue]);
    float vectorThreeB = ([input_vector_three_b.text floatValue]);
    
    for(int i = 0; i < [inputArray count]; i++){
        
        NSScanner *scan = [NSScanner scannerWithString:inputArray[i]];
        
        if (![inputArray[i]  isEqual: @""] && (![scan scanFloat:NULL] || ![scan isAtEnd]))
        {
            firstView_answer.text = @"Not a float";
            break;
        }
        else
        {
            [firstView_answer setText: [NSString stringWithFormat:@"%fi + %fj", vectorOneA + vectorTwoA + vectorThreeA, vectorOneB + vectorTwoB + vectorThreeB]];
        }
        
    }
    
    

    
}




@end
