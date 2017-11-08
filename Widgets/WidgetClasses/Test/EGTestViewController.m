//
//  EGTestViewController.m
//  Widgets
//
//  Created by EG on 2017/8/5.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGTestViewController.h"
#import <MJRefresh.h>

@interface EGTestViewController ()

@end

@implementation EGTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"说明";

    NSLog(@"result is %ld", [self numberWithHexString:@"1F"]);
}


+ (NSString *)convertStringToHexStr:(NSString *)str {
    if (!str || [str length] == 0) {
        return @"";
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];

    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];

    return string;
}

- (NSInteger)numberWithHexString:(NSString *)hexString{
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    int hexNumber;
    sscanf(hexChar, "%x", &hexNumber);
    return (NSInteger)hexNumber;
}

@end
