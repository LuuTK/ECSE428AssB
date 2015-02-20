//
//  SecondViewController.m
//  VectorCalc
//
//  Created by Michael Ho on 2015-02-19.
//  Copyright (c) 2015 michaelchum. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIView *graphView;
@property (weak, nonatomic) IBOutlet UILabel *additionLabel;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *vectorOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *vectorTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *vectorThreeLabel;

@property (weak,nonatomic) FirstViewController *first;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.first = [self.tabBarController.viewControllers objectAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.additionLabel.text = [NSString stringWithFormat:@"%.2fî %.2fĵ", self.first.sumCartesian.dx, self.first.sumCartesian.dy];
    self.productLabel.text = [NSString stringWithFormat:@"%.2fî %.2fĵ", self.first.vectorCartesian.dx, self.first.vectorCartesian.dy];
    self.vectorOneLabel.text = [NSString stringWithFormat:@"%.2fî %.2fĵ", self.first.vectorOneCartesian.dx, self.first.vectorOneCartesian.dy];
    self.vectorTwoLabel.text = [NSString stringWithFormat:@"%.2fî %.2fĵ", self.first.vectorTwoCartesian.dx, self.first.vectorTwoCartesian.dy];
    self.vectorThreeLabel.text = [NSString stringWithFormat:@"%.2fî %.2fĵ", self.first.vectorThreeCartesian.dx, self.first.vectorThreeCartesian.dy];
}
@end
