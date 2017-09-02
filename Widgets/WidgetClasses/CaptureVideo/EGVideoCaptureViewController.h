//
//  EGVideoCaptureViewController.h
//  Widgets
//
//  Created by EG on 2017/8/31.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGBasicViewController.h"

/**
 视频工具箱是一个基于 CoreMedia，CoreVideo，CoreFoundation 框架的 C 语言 API，并且基于三种可用类型的会话：压缩，解压缩，像素移动。它从 CoreMedia 和 CoreVideo 框架衍生了一些不同的关于时间和帧管理的数据类型，例如 CMTime 或 CVPixelBuffer。
 
 初始化解压会话的时候，视频工具箱需要知道以 CMVideoFormatDescriptionRef 结构体描述的输入的格式，以及 —— 除非你想使用默认的无参数 —— 你通过 CFDictionary 指定的输出格式。视频格式的描述可以从 AVAssetTrack 实例来获取或者如果你使用自定义分路器 (demuxer) 的话，可以通过 CMVideoFormatDescriptionCreate 手动创建。最后，解码后的数据是通过异步回调机制提供的。回调引用和视频格式的描述在调用 VTDecompressionSessionCreate 时需要，而设置输出格式是可选的。
 */
@interface EGVideoCaptureViewController : EGBasicViewController

@end
