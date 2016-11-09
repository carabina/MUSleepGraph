//
//  TestViewController.m
//  FITsociety
//
//  Created by Muhammad Usman on 20/01/2016.
//  Copyright © 2016 Code Enterprise Pvt. Limited. All rights reserved.
//

#import "MUSleepGraph.h"
#import "GraphPoints.h"
#import "Constants.h"
#import "UILabel+Kerning.h"

@interface MUSleepGraph ()
@property (nonatomic, assign) BOOL isScrollEnable;
@property (nonatomic, assign) float yAxisPercentage;
@end

@implementation MUSleepGraph

-(instancetype)initWithGraphView:(UIView*)graphView{
    self = [super init];
    if (self) {
        [self initView:graphView.frame];
    }
    return self;
}

-(void)initView:(CGRect)frame{
    self.frame = frame;
    frame.size.width = [[UIScreen mainScreen] bounds].size.width;
    self.frame = frame;
    [self updateView];
}

- (void)updateView {
    
    //Default Values
    [self setBackgroundColor:UIColorFromRGB(COLOUR_1E1E1E)];
    _leftMargin = 30;
    _yAxisMultiplyer = self.frame.size.height / 14;
    _xAxisOffset = self.frame.size.width / 14;
    _topMargin = 40;
    _xLabelsWidth = 50;
    _pathWidth = 2.5;
    _sleepHours = [NSArray array];
    if(_maxSleepHours == 0){
        _maxSleepHours = 9;
    }
    _numberOfWeeks = 1;
    _pointsArray = [NSMutableArray array];
    _isScrollEnable = NO;
    
    //Layers needs to be reloaded
    //this is to reload layer
    [self setNeedsDisplay];
    
}

-(void)setLeftMargin:(int)leftMargin{
    _leftMargin = leftMargin;
}

-(void)setYAxisMultiplyer:(int)yAxisMultiplyer{
    _yAxisMultiplyer = yAxisMultiplyer;
}

-(void)setXAxisOffset:(int)xAxisOffset{
    _xAxisOffset = xAxisOffset;
}

-(void)setIsScrollEnable:(BOOL)isScrollEnable{
    _isScrollEnable = isScrollEnable;
}
-(void)setTopMargin:(int)topMargin{
    _topMargin = topMargin;
}

-(void)setXLabelsWidth:(int)xLabelsWidth{
    _xLabelsWidth = xLabelsWidth;
}

-(void)setLabelsView:(UIView *)labelsView{
    _labelsView = labelsView;
}

-(void)setPathWidth:(int)pathWidth{
    _pathWidth = pathWidth;
}

-(void)setYLabelsArray:(NSMutableArray *)yLabelsArray{
    
    _yLabelsArray = yLabelsArray;
}

-(void)setSleepHours:(NSArray *)sleepHours{
    _sleepHours = sleepHours;

    if(sleepHours.count > 0){
        [self getPointsArray];
        [self addXlabelsToGraph];
        [self setYLabels];
    }
}

-(void)setMaxSleepHours:(int)maxSleepHours {
    
    _maxSleepHours = maxSleepHours;
    float mult = (float)maxSleepHours / 10;
    _yAxisPercentage = mult;
}

-(void)setYAxisPercentage:(float)yAxisPercentage{
    _yAxisPercentage = yAxisPercentage;
}

-(void)setPointsArray:(NSMutableArray *)pointsArray{
    _pointsArray = pointsArray;
}

-(void)setNumberOfWeeks:(int)numberOfWeeks{
    _numberOfWeeks = numberOfWeeks;
    CGFloat width = self.frame.size.width * numberOfWeeks;
    
    if(numberOfWeeks > 1){
        self.isScrollEnable = YES;
        self.contentSize =CGSizeMake(width, self.frame.size.height);

    }
}
-(void)drawSleepGraph{
    if(_pointsArray.count != 0 && _sleepHours.count == _pointsArray.count){
        [self drawPathWithArray:_pointsArray];
    }
}

-(void)addXlabelsToGraph{
    //we have to add labels according to points
    //Both array should have same count
    if(_pointsArray.count == _sleepHours.count){
        //oring.y will be same for all labels
        CGFloat originY = (_yAxisMultiplyer * 13) ;
        
        for (int i = 0 ; i < _sleepHours.count; i++) {
            //calculating the label frame
            GraphPoints *currentPoint = [_pointsArray objectAtIndex:i];
            if(_sleepHours.count / 7 ){
                
            }
            NSDate *currentDate = [NSDate date];
            NSMutableArray *daysArray = [[self getWeekdaysAbriviationsForDate:currentDate] mutableCopy];

            if(_numberOfWeeks > 1){
                for (int i = 1; i < _numberOfWeeks; i++) {
                    currentDate = [self getDateAfterDays:7 forSourceDate:currentDate];
                    [daysArray addObjectsFromArray:[self getWeekdaysAbriviationsForDate:currentDate]];
                }
            }
            UILabel *xLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, originY, _xLabelsWidth, 30)];
            [xLabel setTextColor:UIColorFromRGB(COLOUR_FFFFFF)];
            xLabel.center = CGPointMake(currentPoint.peakPoint.x, xLabel.center.y);
            
            //Getting sleep hours in string
            NSString *sleepHour = [NSString stringWithFormat:@"%0.1f", [[_sleepHours objectAtIndex:i] floatValue]];
            sleepHour = [sleepHour stringByReplacingOccurrencesOfString:@"." withString:@","];
            NSString *labelText = [NSString stringWithFormat:@"%@\n%@",[daysArray objectAtIndex:i], sleepHour];
            //Apply attributes according to your choice here
            NSArray *stringsArray = [labelText componentsSeparatedByString:@"\n"];
            NSMutableAttributedString *firtString = [[NSMutableAttributedString alloc] initWithString:[stringsArray firstObject]];
            NSMutableAttributedString *secondString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@",[stringsArray lastObject]]];
            
            [firtString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(COLOUR_FFFFFF) range:NSMakeRange(0, firtString.length)];
            [firtString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(COLOUR_FFFFFF) range:NSMakeRange(0, firtString.length)];
            [firtString addAttribute:NSFontAttributeName
                               value:[UIFont fontWithName:@"Arial" size:12]
                               range:NSMakeRange(0, [firtString length])];
            [secondString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(COLOUR_808080) range:NSMakeRange(0, secondString.length)];
            [secondString addAttribute:NSFontAttributeName
                                 value:[UIFont fontWithName:@"Arial" size:12]
                                 range:NSMakeRange(0, [secondString length])];
            NSMutableAttributedString *finalString = [[NSMutableAttributedString alloc] initWithAttributedString:firtString];
            [finalString appendAttributedString:secondString];
            
            [xLabel setAttributedText:finalString];
            xLabel.numberOfLines = 2;
            xLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:xLabel];
        }
    }
}

-(void)setYLabels{
    self.yLabelsArray = [NSMutableArray array];
    CGFloat originY = _topMargin +  (_yAxisMultiplyer * 10) ;
    for (int i = 0; i <= 10; i++) {
        originY = _topMargin + (_yAxisMultiplyer * (10 - i));
        GraphPoints *currentPoint = [_pointsArray objectAtIndex:0];
        //yAxis labels
        UILabel *yLabel = [[UILabel alloc]  initWithFrame:CGRectMake(_xAxisOffset, originY, _xLabelsWidth, 30)];
        yLabel.textAlignment = NSTextAlignmentCenter;
        yLabel.center = CGPointMake(currentPoint.peakPoint.x, originY);
        
        //yAxisPercentage is interval for the values
        float labelValue = i * self.yAxisPercentage;
        [yLabel setAttributedText:[NSString stringWithFormat:@"%0.1f", labelValue] withFont:[UIFont fontWithName:@"Arial" size:17] kerining:0.7 color:UIColorFromRGB(COLOUR_FFFFFF)];
        
        if(self.isScrollEnable && self.labelsView)
            //this will be added on main view outside the scrollview
            [self.yLabelsArray addObject:yLabel];
        else
            [self addSubview:yLabel];
    }
}

-(void)getPointsArray{
    
    //Get points for all sleep hour values
    for (int i = 0; i < _sleepHours.count ; i ++) {
        GraphPoints *currentPoint = [[GraphPoints alloc] init];
        float currentSleepHours = [[_sleepHours objectAtIndex:i] floatValue];
        currentSleepHours = currentSleepHours / _yAxisPercentage;
        float maxLimit = 10;
        if(currentSleepHours == maxLimit){
            
            //this is maximum peak possible
            //we will not multiply hour's difference to yAxisMultiplyer
            currentPoint.peakPoint = CGPointMake(_leftMargin + (i * _xAxisOffset * 2),  (_yAxisMultiplyer ));
            
        }else{
            
            //this is between 0 and maxSleepHours
            currentPoint.peakPoint = CGPointMake(_leftMargin + (i * _xAxisOffset * 2), _topMargin + (_yAxisMultiplyer * (maxLimit - currentSleepHours)));
            
        }
        
        //Setting colors
        if(currentSleepHours <= 4){
            //Red color
            currentPoint.pathColor = UIColorFromRGB(COLOUR_E9280E);
        }else if (currentSleepHours < maxLimit){
            //green color
            currentPoint.pathColor = UIColorFromRGB(COLOUR_97F619);
        }else{
            currentPoint.pathColor = UIColorFromRGB(COLOUR_FFFF1F);
        }
        
        if(currentSleepHours == 0){
            
            //user has not entered sleep hours
            //we will show straight line here
            currentPoint.rightPathStart = CGPointMake(currentPoint.peakPoint.x+(_xAxisOffset), currentPoint.peakPoint.y + (_xAxisOffset/2));
            currentPoint.leftPathStart = CGPointMake(currentPoint.peakPoint.x - (_xAxisOffset), currentPoint.peakPoint.y + (_xAxisOffset/2));
            
            currentPoint.rightPathEnd = currentPoint.rightPathStart;
            currentPoint.leftPathEnd = currentPoint.leftPathStart;
            [_pointsArray addObject:currentPoint];
            continue;
        }
        
        //Calulating the start points of left and right path lines
        currentPoint.rightPathStart = CGPointMake(currentPoint.peakPoint.x + (_xAxisOffset/2), currentPoint.peakPoint.y + (_xAxisOffset/2));
        currentPoint.leftPathStart = CGPointMake(currentPoint.peakPoint.x - (_xAxisOffset/2), currentPoint.peakPoint.y + (_xAxisOffset/2));
        
        //Calculating right path
        if(currentSleepHours <= 4){
            currentPoint.rightPathEnd = CGPointMake(currentPoint.rightPathStart.x, _yAxisMultiplyer * maxLimit + _topMargin);
        }
        else
            if(i+1 != _sleepHours.count){
            
            //this is not the last peak yet.
            //we still have another peak on right
            if(currentSleepHours < ([[_sleepHours objectAtIndex:i+1] floatValue]/_yAxisPercentage)){
                // next peak is higher than current peak
                //right lower peak should be lower than current peak
                currentPoint.rightPathEnd = CGPointMake(currentPoint.rightPathStart.x, currentPoint.peakPoint.y + (currentPoint.peakPoint.y/2));
            }else{
                //next peak will be lower than current peak
                //right lower peak should be lower than next peak
                //we have to calculate the next peak and its half
                //we dont need x axis of next peak so we are going to consider it 0
                CGPoint nextPeak = CGPointZero;
                if([[_sleepHours objectAtIndex:i+1] floatValue] == _maxSleepHours){
                    //next peak has maximim sleep hours
                    nextPeak = CGPointMake(0, _topMargin + (_yAxisMultiplyer ));
                    
                }else{
                    nextPeak = CGPointMake(0, _topMargin + (_yAxisMultiplyer * (maxLimit - ([[_sleepHours objectAtIndex:i+1] floatValue]/_yAxisPercentage))));
                    
                }
                if(([[_sleepHours objectAtIndex:i+1] floatValue] / _yAxisPercentage) <= 4){
                    //next sleephours value is zero
                    //we have to decrease the right path's depth
                    currentPoint.rightPathEnd = CGPointMake(currentPoint.rightPathStart.x, _yAxisMultiplyer * maxLimit + _topMargin);
                    
                }else{
                    float y = nextPeak.y + (nextPeak.y/2);
                    if(y > (_yAxisMultiplyer * maxLimit + _topMargin)){
                        y = (_yAxisMultiplyer * maxLimit + _topMargin);
                    }
                    currentPoint.rightPathEnd = CGPointMake(currentPoint.rightPathStart.x, y);

                }
            }
        }else{
            //current peak is last one
            //we do not have any further peaks
            currentPoint.rightPathEnd = CGPointMake(currentPoint.rightPathStart.x, currentPoint.peakPoint.y + (currentPoint.peakPoint.y/2));
        }
        
        //calculating left path
        if(currentSleepHours <= 4){
            currentPoint.leftPathEnd = CGPointMake(currentPoint.peakPoint.x - (_xAxisOffset/2), _yAxisMultiplyer * maxLimit + _topMargin);
            
        }else
            if(i != 0){
            //this is not the first peak .
            //we still have another peak on left
            if(currentSleepHours < ([[_sleepHours objectAtIndex:i-1] floatValue] / _yAxisPercentage)){
                // previous peak is higher than current peak
                // left lower peak should be lower than current peak
                currentPoint.leftPathEnd = CGPointMake(currentPoint.peakPoint.x- (_xAxisOffset/2), currentPoint.peakPoint.y + (currentPoint.peakPoint.y/2));
                
            }else{
                //previous peak is lower than current peak
                //right lower peak should be lower than next peak
                //we have to calculate the next peak and its half
                //we dont need x axis of next peak so we are going to consider it 0
                
                CGPoint previousPeak = CGPointZero;
                if([[_sleepHours objectAtIndex:i-1] floatValue] == _maxSleepHours){
                    //previous peak has highest sleep value
                    previousPeak = CGPointMake(0, _topMargin + (_yAxisMultiplyer));
                }else{
                    previousPeak = CGPointMake(0, _topMargin + (_yAxisMultiplyer * (maxLimit - ([[_sleepHours objectAtIndex:i-1] floatValue]/_yAxisPercentage))));
                    
                }
                if(([[_sleepHours objectAtIndex:i-1] floatValue]/_yAxisPercentage) <= 4){
                    //previous sleephours value is zero
                    //we have to decrease the left path's depth
                    currentPoint.leftPathEnd = CGPointMake(currentPoint.leftPathStart.x, _yAxisMultiplyer * maxLimit + _topMargin);
                    
                }
                else{
                    float y = previousPeak.y + (previousPeak.y/2);
                    if(y > (_yAxisMultiplyer * maxLimit + _topMargin)){
                        y = (_yAxisMultiplyer * maxLimit + _topMargin);
                    }

                    currentPoint.leftPathEnd = CGPointMake(currentPoint.leftPathStart.x, y);
                }
            }
        }else{
            
//            float y = currentPoint.peakPoint.y + (currentPoint.peakPoint.y/2);
//            if(y > (_yAxisMultiplyer * maxLimit + _topMargin)){
//                y = (_yAxisMultiplyer * maxLimit + _topMargin);
//            }
//            
            currentPoint.leftPathEnd = CGPointMake(currentPoint.peakPoint.x - (_xAxisOffset/2), currentPoint.peakPoint.y + (currentPoint.peakPoint.y/2));
        }
        //We have calculated everything
        //Add current graph point to points array
        [_pointsArray addObject:currentPoint];
    }
}

-(void)drawPathWithArray:(NSArray *)pathsArray{
    
    for(int i = 0; i < pathsArray.count ; i++){
        
        GraphPoints *currentPoints = [pathsArray objectAtIndex:i];
        if(CGPointEqualToPoint(currentPoints.leftPathEnd, currentPoints.leftPathEnd) && CGPointEqualToPoint(currentPoints.rightPathStart, currentPoints.rightPathEnd)){
            //here, sleep hours are equal to zero
            //we have to draw straight line here
            CGPoint startPoint = currentPoints.rightPathStart;
            CGPoint endPoint = currentPoints.leftPathStart;
            [self drawPathForStartPoint:startPoint endPoint:endPoint withColor:currentPoints.pathColor];
        }else{
            CGPoint startPoint = currentPoints.rightPathStart;
            CGPoint endPoint = currentPoints.rightPathEnd;
            [self drawPathForStartPoint:startPoint endPoint:endPoint withColor:currentPoints.pathColor];
            startPoint = currentPoints.leftPathStart;
            endPoint = currentPoints.leftPathEnd;
            [self drawPathForStartPoint:endPoint endPoint:startPoint withColor:currentPoints.pathColor];
        }
    }
    
}

-(void)drawPathForStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint withColor:(UIColor*)color{
    
    float radius = _xAxisOffset/2;
    CGPoint centerArc1 = CGPointZero;
    CGPoint centerArc2 = CGPointZero;
    CGFloat arc1StartAngle = 0;
    CGFloat arc1EndAngle = 1.5 * M_PI;
    CGFloat arc2StartAngle = M_PI;
    CGFloat arc2EndAngle = 0.5 * M_PI;
    
    if(startPoint.y < endPoint.y){
        //line will be drawn from top to bottom
        centerArc1 = CGPointMake(startPoint.x - radius, startPoint.y);
        centerArc2 = CGPointMake(endPoint.x + radius, endPoint.y);
    }else if(startPoint.y > endPoint.y){
        //Line will start from bottom
        centerArc1 = CGPointMake(startPoint.x - radius, startPoint.y);
        centerArc2 = CGPointMake(startPoint.x + radius, endPoint.y);
        arc1StartAngle = 0.5 * M_PI;
        arc1EndAngle = 0;
        arc2StartAngle = 1.5 * M_PI;
        arc2EndAngle = M_PI;
    }
    
    if (startPoint.y == endPoint.y){
        //Line
        UIBezierPath *curvePath1 = [self quadCurvedPathWithPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:startPoint],[NSValue valueWithCGPoint:endPoint], nil]];
        CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
        shapeLayer1.path = curvePath1.CGPath;
        shapeLayer1.fillColor = [UIColor clearColor].CGColor;
        shapeLayer1.strokeColor = color.CGColor;
        shapeLayer1.lineWidth = _pathWidth;
        [self.layer addSublayer:shapeLayer1];
        
    }else{
        //Line
        UIBezierPath *curvePath1 = [self quadCurvedPathWithPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:startPoint],[NSValue valueWithCGPoint:endPoint], nil]];
        CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
        shapeLayer1.path = curvePath1.CGPath;
        shapeLayer1.fillColor = [UIColor clearColor].CGColor;
        shapeLayer1.strokeColor = color.CGColor;
        shapeLayer1.lineWidth = _pathWidth;
        [self.layer addSublayer:shapeLayer1];
        
        UIBezierPath *arc1 = [UIBezierPath bezierPath];
        [arc1 addArcWithCenter:centerArc1 radius:radius startAngle:arc1StartAngle endAngle:arc1EndAngle clockwise:NO];
        CAShapeLayer *arcLayer1 = [CAShapeLayer layer];
        arcLayer1.path = arc1.CGPath;
        arcLayer1.fillColor = [UIColor clearColor].CGColor;
        arcLayer1.strokeColor = color.CGColor;
        arcLayer1.lineWidth = _pathWidth;
        [self.layer addSublayer:arcLayer1];
        
        UIBezierPath *arc2 = [UIBezierPath bezierPath];
        [arc2 addArcWithCenter:centerArc2 radius:radius startAngle:arc2StartAngle endAngle:arc2EndAngle clockwise:NO];
        CAShapeLayer *arcLayer2 = [CAShapeLayer layer];
        arcLayer2.path = arc2.CGPath;
        arcLayer2.fillColor = [UIColor clearColor].CGColor;
        arcLayer2.strokeColor = color.CGColor;
        arcLayer2.lineWidth = _pathWidth;
        [self.layer addSublayer:arcLayer2];
    }
    
    
}

- (UIBezierPath *)quadCurvedPathWithPoints:(NSArray *)points
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSValue *value = points[0];
    CGPoint p1 = [value CGPointValue];
    [path moveToPoint:p1];
    
    for (NSUInteger i = 1; i < points.count; i++) {
        value = points[i];
        CGPoint p2 = [value CGPointValue];
        
        CGPoint midPoint = midPointForPoints(p1, p2);
        [path addQuadCurveToPoint:midPoint controlPoint:controlPointForPoints(midPoint, p1)];
        [path addQuadCurveToPoint:p2 controlPoint:controlPointForPoints(midPoint, p2)];
        
        p1 = p2;
    }
    return path;
}

static CGPoint midPointForPoints(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
}

static CGPoint controlPointForPoints(CGPoint p1, CGPoint p2) {
    CGPoint controlPoint = midPointForPoints(p1, p2);
    CGFloat diffY = fabs(p2.y - controlPoint.y);
    
    if (p1.y < p2.y)
        controlPoint.y += diffY;
    else if (p1.y > p2.y)
        controlPoint.y -= diffY;
    
    return controlPoint;
}


-(NSArray*) getWeekdaysAbriviationsForDate:(NSDate *)targetDate{
    NSDateFormatter* theDateFormatter = [[NSDateFormatter alloc] init] ;
    [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter setDateFormat:@"EEEE"];
    [theDateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    NSString *today =  [theDateFormatter stringFromDate:targetDate];
    [theDateFormatter setDateFormat:@"dd"];
    
    NSMutableArray *abriviationsArray = [NSMutableArray array];
    
    if([today.lowercaseString isEqualToString:@"friday"]){
        abriviationsArray = [NSMutableArray arrayWithObjects:@"Fri", @"Sat", @"Sun", @"Mon", @"Tue", @"Wed", @"Thu", nil];
    }else if ([today.lowercaseString isEqualToString:@"saturday"]){
        abriviationsArray = [NSMutableArray arrayWithObjects:@"Sat", @"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", nil];
    }else if ([today.lowercaseString isEqualToString:@"sunday"]){
        abriviationsArray = [NSMutableArray arrayWithObjects:@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", nil];
    }else if ([today.lowercaseString isEqualToString:@"monday"]){
        abriviationsArray = [NSMutableArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", nil];
    }else if ([today.lowercaseString isEqualToString:@"tuesday"]){
        abriviationsArray = [NSMutableArray arrayWithObjects:@"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", @"Mon", nil];
    }else if ([today.lowercaseString isEqualToString:@"wednesday"]){
        abriviationsArray = [NSMutableArray arrayWithObjects:@"Wed", @"Thu", @"Fri", @"Sat", @"Sun", @"Mon", @"Tue", nil];
    }else if ([today.lowercaseString isEqualToString:@"thursday"]){
        abriviationsArray = [NSMutableArray arrayWithObjects:@"Thu", @"Fri", @"Sat", @"Sun", @"Mon", @"Tue", @"Thu", nil];
    }
    
    return abriviationsArray;
    
}

-(NSDate *)getDateAfterDays:(int)days forSourceDate:(NSDate *)sourceDate {
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = days;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:sourceDate options:0];
    
    
    return nextDate;
}


@end
