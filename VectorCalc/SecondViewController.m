//
//  SecondViewController.m
//  VectorCalc
//
//  Created by Michael Ho on 2015-02-19.
//  Copyright (c) 2015 michaelchum. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet VectorGraphView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *additionLabel;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *vectorOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *vectorTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *vectorThreeLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.first = [self.tabBarController.viewControllers objectAtIndex:0];
    self.graphView.transform = CGAffineTransformMakeScale(1, -1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.additionLabel.text = [NSString stringWithFormat:@"%.2fî %.2fĵ", self.first.sumCartesian.dx, self.first.sumCartesian.dy];
   self.productLabel.text = [NSString stringWithFormat:@""];
    self.vectorOneLabel.text = [NSString stringWithFormat:@"%.2fî %.2fĵ", self.first.vectorOneCartesian.dx, self.first.vectorOneCartesian.dy];
    self.vectorTwoLabel.text = [NSString stringWithFormat:@"%.2fî %.2fĵ", self.first.vectorTwoCartesian.dx, self.first.vectorTwoCartesian.dy];
    self.vectorThreeLabel.text = [NSString stringWithFormat:@"%.2fî %.2fĵ", self.first.vectorThreeCartesian.dx, self.first.vectorThreeCartesian.dy];
    [self.graphView drawVectorOne:self.first.vectorOneCartesian];
    [self.graphView drawVectorTwo:self.first.vectorTwoCartesian];
    [self.graphView drawVectorThree:self.first.vectorThreeCartesian];
    [self.graphView drawSumVector:self.first.sumCartesian];
    [self.graphView drawProductVector:self.first.vectorCartesian];
}
@end
