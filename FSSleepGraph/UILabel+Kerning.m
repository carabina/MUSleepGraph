//
//  UILabel+Kerning.m
//  FITsociety
//
//  Created by Muhammad Usman on 01/12/2015.
//  Copyright © 2015 Code Enterprise Pvt. Limited. All rights reserved.
//

#import "UILabel+Kerning.h"

@implementation UILabel (Kerning)

-(void)setAttributedText:(NSString *)string withFont:(UIFont *)font kerining:(CGFloat)kerning color:(UIColor *)color{
    if(string.length != 0){
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedString addAttribute:NSKernAttributeName
                                 value:[NSNumber numberWithFloat:kerning]
                                 range:NSMakeRange(0, [string length])];
        [attributedString addAttribute:NSFontAttributeName
                                 value:font
                                 range:NSMakeRange(0, [string length])];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:color
                                 range:NSMakeRange(0, [string length])];
        
        [self setAttributedText:attributedString];

    }else{
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
        [self setAttributedText:attributedString];
        
    }

}

@end
