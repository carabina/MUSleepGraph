//
//  TestViewController.h
//  FITsociety
//
//  Created by Muhammad Usman on 20/01/2016.
//  Copyright © 2016 Code Enterprise Pvt. Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MUSleepGraph : UIScrollView

@property (nonatomic, strong) NSArray *sleepHours;
@property (nonatomic, assign) int maxSleepHours;
@property (nonatomic, assign) int yAxisMultiplyer;
@property (nonatomic, assign) int xAxisOffset;
@property (nonatomic, assign) int topMargin;
@property (nonatomic, assign) int leftMargin;
@property (nonatomic, assign) int pathWidth;
@property (nonatomic, assign) int xLabelsWidth;
@property (nonatomic, strong) NSMutableArray *pointsArray;
@property (nonatomic, strong) UIView *labelsView;
@property (nonatomic, assign) int numberOfWeeks;
@property (nonatomic, strong) NSMutableArray *yLabelsArray;

-(void)drawSleepGraph;
-(instancetype)initWithGraphView:(UIView*)graphView;

@end
