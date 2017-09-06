//
//  EGOpenGLView.h
//  Widgets
//
//  Created by EG on 2017/8/31.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/ES2//gl.h>
#import <OpenGLES/ES2/glext.h>

@interface EGOpenGLView : UIView

- (void)setupGL;

- (void)displayPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end
