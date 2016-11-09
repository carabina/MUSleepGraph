//
//  Constants.h
//  FSSleepGraph
//
//  Created by Muhammad Usman on 10/02/2016.
//  Copyright © 2016 Muhammad Usman. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//font colours

#define COLOUR_000000 0x000000

#define COLOUR_1E1E1E 0x1E1E1E

#define COLOUR_232323 0x232323

#define COLOUR_191919 0x191919

#define COLOUR_808080 0x808080

#define COLOUR_D94343 0xD94343

#define COLOUR_FFFFFF 0xFFFFFF

#define COLOUR_97F619 0x97F619 //Bar graph green

#define COLOUR_EB4F0F 0xEB4F0F //bar graph orange

#define COLOUR_E9280E 0xE9280E //bar graph red

#define COLOUR_592F19 0x592F19 // Dark orange bar color

#define COLOUR_40581C 0x40581C // dark green bar color

#define COLOUR_5A1A19 0x5A1A19 //Dark red bar color

#define COLOUR_FFFF1F 0xFFFF1F //Light yellow color

#define COLOUR_5A5A1A 0x5A5A1A //dark yellow color
//fonts

#define LATO_REGULAR_FONT_STRING @"Lato-Regular"

#define LATO_BOLD_ITALIC_FONT_STRING @"Lato-BoldItalic"

#define LATO_BOLD_FONT_STRING @"Lato-Bold"

#define LATO_BLACK_ITALIC_FONT_STRING @"Lato-BlackItalic"

#define LATO_ITALIC_FONT_STRING @"Lato-Italic"

#define LATO_HAIRLINE_ITALIC_FONT_STRING @"Lato-HairlineItalic"

#define LATO_BLACK_FONT_STRING @"Lato-Black"

#define HELVETICA_NEUE_RAGULAR_FONT_STRING @"HelveticaNeue"

#define LATO_HAIRLINE_FONT_STRING @"Lato-Hairline"

#define LATO_LIGHT_ITALIC_FONT_STRING @"Lato-LightItalic"

#define BARON_NEUE_REGULAR_FONT_STRING @"BaronNeue"

#define BARON_NEUE_BLACK_ITALIC_FONT_STRING @"BaronNeueBlackItalic"

#define BARON_NEUE_BOLD_ITALIC_FONT_STRING @"BaronNeueBoldItalic"

#define BARON_NEUE_BLACK_FONT_STRING @"BaronNeueBlack"

#define BARON_NEUE_BOLD_FONT_STRING @"BaronNeueBold"

#define BARON_NEUE_ITALIC_FONT_STRING @"BaronNeueItalic"

//Font Macro
#define FontUsingMacro(_name_, _size_) ((UIFont *)[UIFont fontWithName:(NSString *)(_name_) size:(CGFloat)(_size_)])
