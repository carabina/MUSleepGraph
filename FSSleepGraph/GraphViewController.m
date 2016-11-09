//
//  ViewController.m
//  FSSleepGraph
//
//  Created by Muhammad Usman on 10/02/2016.
//  Copyright © 2016 Muhammad Usman. All rights reserved.
//

#import "GraphViewController.h"
#import "MUSleepGraph.h"
#import "UILabel+Kerning.h"
#import "Constants.h"

@interface GraphViewController ()

@property (nonatomic, assign) int numberOfWeeks;
@property (nonatomic, assign) int maxGraphValue;

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.numberOfWeeks = 1;
    self.maxGraphValue = 100;
    
    [self setupGraph];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setupGraph{
    //CGRect
    MUSleepGraph *graphView = [[MUSleepGraph alloc]  initWithGraphView:self.graphView];
    
    //Customize the public properties
    graphView.maxSleepHours = self.maxGraphValue;
    graphView.numberOfWeeks = self.numberOfWeeks;
    
    NSMutableArray *yValuesArray = [NSMutableArray array];
    for (int i = 0; i < 7 * graphView.numberOfWeeks; i++) {
        //we are going to show sleep graph for one week.
        //put your own values here
        int sleepHours = random()  % self.maxGraphValue;
            [yValuesArray addObject:@(sleepHours)];
    }
    
    graphView.labelsView = self.view;
    graphView.sleepHours = yValuesArray;
    [graphView drawSleepGraph];
    
    [self.graphView addSubview:graphView];
    
    
    if(graphView.numberOfWeeks > 1){
        if(graphView.yLabelsArray.count > 0){
            for (int i = 0; i < graphView.yLabelsArray.count; i++) {
                UIView *subview = [graphView.yLabelsArray objectAtIndex:i];
                [self.graphView addSubview:subview];
            }
        }
    }

}
- (IBAction)maxValueStepperChanged:(id)sender {
    self.maxGraphValue = (int)self.maxValueStepper.value;
    [self.maxValueLbl setText:[NSString stringWithFormat:@"%d", self.maxGraphValue]];
}

- (IBAction)reloadGraphPressed:(id)sender {
    [self setupGraph];
}

- (IBAction)weeksStepperChanged:(id)sender {
    self.numberOfWeeks = (int)self.weeksStepper.value;
    [self.weeksValueLbl setText:[NSString stringWithFormat:@"%d", self.numberOfWeeks]];

}

@end
