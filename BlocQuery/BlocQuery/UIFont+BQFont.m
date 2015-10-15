//
//  UIFont+BQFont.m
//  BlocQuery
//
//  Created by Weinan Qiu on 2015-10-13.
//  Copyright © 2015 Kumiq. All rights reserved.
//

#import "UIFont+BQFont.h"

@implementation UIFont (BQFont)

+ (UIFont *) defaultAppFontWithSize:(CGFloat) size {
    return [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:size];
}

+ (UIFont *) defaultAppBoldFontWithSize:(CGFloat) size {
    return [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:size];
}

@end
