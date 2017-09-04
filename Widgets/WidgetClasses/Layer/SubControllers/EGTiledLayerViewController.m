//
//  EGTiledLayerViewController.m
//  Widgets
//
//  Created by EG on 2017/9/4.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGTiledLayerViewController.h"

/**
 iOS应用通畅运行在内存受限的设备上，所以读取整个图片到内存中是不明智的。
 所有显示在屏幕上的图片最终都会被转化为OpenGL纹理，同时OpenGL有一个最大的纹理尺寸，这个取决于设备型号。
 Core Animation强制用CPU处理图片而不是更快的GPU。
 CATiledLayer为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入。
 */
@interface EGTiledLayerViewController ()

@end

@implementation EGTiledLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
