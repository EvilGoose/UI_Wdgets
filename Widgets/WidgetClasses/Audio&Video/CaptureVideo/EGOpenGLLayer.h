//
//  EGOpenGLLayer.h
//  
//
//  Created by EG on 2017/9/1.
//
//


#include <QuartzCore/QuartzCore.h>
#include <CoreVideo/CoreVideo.h>


/**
 	CAEAGLLayer完成,它是CALayer的一个子类,用来显示任意的OpenGL图形
 	https://www.kancloud.cn/manual/ios/97798
 */
@interface EGOpenGLLayer : CAEAGLLayer

@property CVPixelBufferRef pixelBuffer;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)resetRenderBuffer;

@end
