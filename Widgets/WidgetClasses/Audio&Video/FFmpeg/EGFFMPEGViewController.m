//
//  EGFFMPEGViewController.m
//  Widgets
//
//  Created by EG on 2017/9/6.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGFFMPEGViewController.h"

#import "avformat.h"

/**
 正确的ffmpeg头文件导入方法：
 	打开build parser，选取search header path，打开添加窗口，
 	打开finder，添加ffmpeg-iOS 到工程中，打开对应文件在工程文件中的位置，
 	拖拽文件到窗口中,此时会多出一个路径，
 	在新加入的路径后面加上"/include"，
 完了就去添加  libz,libbz2,libiconv(后缀：.lib 或者 .tbd)
 */
@interface EGFFMPEGViewController ()

@end

@implementation EGFFMPEGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    av_register_all();
    // Do any additional setup after loading the view.
}

@end
