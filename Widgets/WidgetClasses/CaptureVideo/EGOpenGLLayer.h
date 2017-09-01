//
//  EGOpenGLLayer.h
//  
//
//  Created by EG on 2017/9/1.
//
//


#include <QuartzCore/QuartzCore.h>
#include <CoreVideo/CoreVideo.h>

@interface EGOpenGLLayer : CAEAGLLayer

@property CVPixelBufferRef pixelBuffer;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)resetRenderBuffer;

@end
