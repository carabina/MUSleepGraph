//
//  GraphPoints.h
//  FITsociety
//
//  Created by Muhammad Usman on 20/01/2016.
//  Copyright © 2016 Code Enterprise Pvt. Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GraphPoints : NSObject

@property (nonatomic, assign) CGPoint peakPoint;
@property (nonatomic, assign) CGPoint rightPathStart;
@property (nonatomic, assign) CGPoint rightPathEnd;
@property (nonatomic, assign) CGPoint leftPathStart;
@property (nonatomic, assign) CGPoint leftPathEnd;
@property (nonatomic, strong) UIColor *pathColor;

@end
