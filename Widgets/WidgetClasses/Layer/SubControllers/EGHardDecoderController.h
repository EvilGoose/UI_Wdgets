//
//  EGHardDecoderController.h
//  Widgets
//
//  Created by EG on 2017/9/5.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGBasicViewController.h"

/**
 对于获取到的一帧数据可能被分成了多个nalu，解码的时候不需要再拆分成单个nalu单独去解码，这样硬解码器内部认为此单nalu不是一个完整的帧，导致花屏。
 */
@interface EGHardDecoderController : EGBasicViewController

@end
