//
//  UIConstants.h
//  EGProject
//
//  Created by EG on 2017/7/6.
//  Copyright © 2017年 EGMade. All rights reserved.
//  UI相关，形状，大小，颜色

#ifndef UIConstants_h
#define UIConstants_h

#import "UIView+Extension.h"
#import  <Masonry.h>

    //屏幕宽
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

    //屏幕高
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

    //屏幕bounds
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

    //导航栏高度
#define NAVIGATION_BAR_HEIGHT 64

    //状态栏高度
#define STATUS_BAR_HEIGHT 20

    //搜索栏高度
#define SEARCH_BAR_HEIGHT 40

#define ORDER_BAR_HEIGHT 44



    //横向选项板高度（首页）
#define OPTIONS_VIEW_HEIGHT 30

#define OPTIONS_VIEW_WIDTH 80


    //Tab bar 高度
#define TAB_BAR_HEIGHT 49

    //Banner 高度
#define BANNER_HEIGHT 168

    //商品cell 高度
#define GOODS_CELL_HEIGHT 240

    //间隔
#define CUSTOM_HORIZON_MARGIN 10

#define CUSTOM_VERTICAL_MARGIN 8

    //RGBA 颜色
#define RGBA_COLOR(redNum, greenNum, blueNum, delta)  [UIColor colorWithRed:(redNum)/255.0 green:(greenNum)/255.0 blue:(blueNum)/255.0 alpha:(delta)]

    //随机色
#define RANDOM_COLOR RGBA_COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1)

    //调试色
#ifdef DEBUG
#define DEBUG_COLOR RANDOM_COLOR
#else
#define DEBUG_COLOR CLEAR_COLOR
#endif

    //主题字体色
#define TEXT_MAIN_COLOR [UIColor darkGrayColor]

    //字体副主题色
#define SUB_TEXT_MAIN_COLOR [UIColor lightGrayColor]

    //通用背景色
#define MAIN_THEME_BACKGROUND_COLOR [UIColor colorWithWhite:.8 alpha:1]

    //透明色
#define CLEAR_COLOR [UIColor clearColor]

    //白色
#define WHITE_COLOR [UIColor whiteColor]

    //黑色
#define BLACK_COLOR [UIColor blackColor]

    //红色
#define RED_COLOR [UIColor redColor]

    //黄色
#define YELLOW_COLOR [UIColor yellowColor]

    //绿色
#define GREEN_COLOR [UIColor greenColor]

    //橙色
#define ORANGE_COLOR [UIColor orangeColor]

    //蓝色
#define BLUE_COLOR [UIColor blueColor]

    //紫色
#define PURPLE_COLOR [UIColor purpleColor]

    //灰色
#define GRAY_COLOR [UIColor grayColor]

    //棕色
#define BROWN_COLOR [UIColor brownColor]

    //系统字体
#define DEFAULT_FONT [UIFont systemFontOfSize:14]

#define SYSTEM_BOLD_FONT(size) [UIFont boldSystemFontOfSize:size]

#define SYSTEM_FONT(size) [UIFont systemFontOfSize:size]

#endif /* UIConstants_h */
