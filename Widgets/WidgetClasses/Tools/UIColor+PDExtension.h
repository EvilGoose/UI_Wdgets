//
//  UIColor+PDExtension.h
//  GDUMini
//
//  Created by ProFlight on 16/5/30.
//  Copyright © 2016年 ProFlight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PDExtension)


+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
