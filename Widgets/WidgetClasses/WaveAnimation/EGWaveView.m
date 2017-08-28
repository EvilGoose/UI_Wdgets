//
//  EGWaveView.m
//  Widgets
//
//  Created by EG on 2017/8/28.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGWaveView.h"

@implementation EGWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.type = DrawActionTypeNone;
    }
    return self;
}

- (void)setType:(DrawActionType)type {
    if (type != _type) {
        _type = type;
        [self setNeedsDisplay];
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    switch (self.type) {
        case DrawActionTypeNone:
            return;
            
        case DrawActionTypeSin:
            [self drawSinPath];
            break;
            
        case DrawActionTypeCos:
            [self drawCosPath];
            break;
            
        case DrawActionTypeMutPath:
            [self drawMutPath];
            break;

        default:
            break;
    }
    
}

- (void)drawSinPath {
    CGContextRef cgctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cgctx, 1.00f);
    CGContextSetStrokeColorWithColor(cgctx, [UIColor redColor].CGColor);
    
    float x = 0.0;
    float y = 240.0;
    CGContextMoveToPoint(cgctx, x, y);
    
    for(float x = 0; x < SCREEN_WIDTH; x++){
        y = sin(x / 180 * M_PI ) * 100 + 240.0;
        
        CGContextAddLineToPoint(cgctx, x, y);
        CGContextStrokePath(cgctx);
        CGContextMoveToPoint(cgctx, x, y);
    }
}


- (void)drawCosPath {
    CGContextRef cgctx=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cgctx, 2.00f);
    CGContextSetStrokeColorWithColor(cgctx, [UIColor blueColor].CGColor);
    
    float x = 0.0;
    float y = 240.0;
    CGContextMoveToPoint(cgctx, x, y);
    
    for(float x = 0; x < SCREEN_WIDTH; x++){
        y = cos(x / 180 * M_PI ) * 100 + 240.0;
        
        CGContextAddLineToPoint(cgctx, x, y);
        CGContextStrokePath(cgctx);
        CGContextMoveToPoint(cgctx, x, y);
    }
}

- (void)drawMutPath {
    
    
}

@end
