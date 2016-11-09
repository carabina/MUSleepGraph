//
//  UILabel+Kerning.h
//  FITsociety
//
//  Created by Muhammad Usman on 01/12/2015.
//  Copyright © 2015 Code Enterprise Pvt. Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Kerning)

//I am using this class to add customization to UILabel
//I hope this can be helpful for others if they have to customise the UILabel
//A further details UILabel customisation controll will be uploaded in future

-(void) setAttributedText:(NSString *)string
                 withFont:(UIFont *)font
                 kerining:(CGFloat)kerning
                    color:(UIColor *)color;
@end
