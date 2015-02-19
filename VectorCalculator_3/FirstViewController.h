//
//  FirstViewController.h
//  VectorCalculator_3
//
//  Created by Tuan Kiet Luu on 2015-02-18.
//  Copyright (c) 2015 Tuan Kiet Luu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController




@property (weak, nonatomic) IBOutlet UILabel *firstView_answer;


@property (weak, nonatomic) IBOutlet UITextField *input_vector_one_a;

@property (weak, nonatomic) IBOutlet UITextField *input_vector_one_b;

@property (weak, nonatomic) IBOutlet UITextField *input_vector_two_a;

@property (weak, nonatomic) IBOutlet UITextField *input_vector_two_b;

@property (weak, nonatomic) IBOutlet UITextField *input_vector_three_a;

@property (weak, nonatomic) IBOutlet UITextField *input_vector_three_b;


- (IBAction)firstView_addition:(id)sender;







@end

