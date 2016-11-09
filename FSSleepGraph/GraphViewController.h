//
//  ViewController.h
//  FSSleepGraph
//
//  Created by Muhammad Usman on 10/02/2016.
//  Copyright © 2016 Muhammad Usman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *graphView;
@property (weak, nonatomic) IBOutlet UIStepper *weeksStepper;
@property (weak, nonatomic) IBOutlet UILabel *weeksValueLbl;
@property (weak, nonatomic) IBOutlet UIStepper *maxValueStepper;
@property (weak, nonatomic) IBOutlet UILabel *maxValueLbl;


- (IBAction)weeksStepperChanged:(id)sender;
- (IBAction)maxValueStepperChanged:(id)sender;
- (IBAction)reloadGraphPressed:(id)sender;

@end

