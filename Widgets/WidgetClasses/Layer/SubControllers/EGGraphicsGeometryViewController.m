//
//  EGGraphicsGeometryViewController.m
//  Widgets
//
//  Created by EG on 2017/9/2.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGGraphicsGeometryViewController.h"

/*
 UIView有三个比较重要的布局属性：frame，bounds和center
 CALayer对应地叫做：frame，bounds和position
 
 frame：图层的外部坐标（也就是在父图层上占据的空间）
 bounds：内部坐标（{0, 0}通常是图层的左上角）
 center和position都代表了相对于父图层anchorPoint所在的位置
 
 frame并不是一个非常清晰的属性，它其实是一个虚拟属性，是根据bounds，position和transform计算而来
 
 当对图层做变换的时候，比如旋转或者缩放，frame实际上代表了覆盖在图层旋转之后的整个轴对齐的矩形区域，
 也就是说frame的宽高可能和bounds的宽高不再一致了
 
 默认来说，anchorPoint位于图层的中点，所以图层的将会以这个点为中心放置
 anchorPoint用单位坐标来描述，也就是图层的相对坐标，图层左上角是{0, 0}，右下角是{1, 1}，因此默认坐标是{0.5, 0.5}
 
 和视图一样，图层在图层树当中也是相对于父图层按层级关系放置，一个图层的position依赖于它父图层的bounds，如果父图层发生了移动，它的所有子图层也会跟着移动。

 */

@interface EGGraphicsGeometryViewController ()

@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) UIView *greenView;

@property (nonatomic, weak) CALayer *blueLayer;

@end

@implementation EGGraphicsGeometryViewController

/**
 CALayer并不关心任何响应链事件，所以不能直接处理触摸事件或者手势。
 但是它有一系列的方法帮你处理事件：-containsPoint:和-hitTest:
 
 注意当调用图层的-hitTest:方法时，测算的顺序严格依赖于图层树当中的图层顺序（和UIView处理事件类似）。
 上面所提到的zPosition属性可以明显改变屏幕上图层的顺序，但不能改变事件传递的顺序。（也就是说，图层顺序改变了，由于事件传递顺序不改变，那么将无法获取前面可以监听的事件）
 这意味着如果改变了图层的z轴顺序，你会发现将不能够检测到最前方的视图点击事件，这是因为被另一个图层遮盖住了
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.redView];
        //上面应该是红色view
    
    self.greenView.layer.zPosition = 1.0f;
        //绿色view翻到上面去了
    
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, 100, 100)];
        _redView.layer.backgroundColor = [UIColor redColor].CGColor;
        
     }
    return _redView;
}

- (UIView *)greenView {
    if (!_greenView) {
        _greenView = [[UIView alloc]initWithFrame:CGRectMake(10, 80, 100, 100)];
        _greenView.layer.backgroundColor = [UIColor greenColor].CGColor;
        _greenView.layer.shadowOpacity = 0.5f;
        _greenView.layer.shadowOffset = CGSizeMake(10, 10);
//        CGMutablePathRef squarePath = CGPathCreateMutable();
//        CGPathAddRect(squarePath, NULL, _greenView.bounds);
//        _greenView.layer.shadowPath = squarePath; CGPathRelease(squarePath);
        
            //阴影的形状
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathAddEllipseInRect(circlePath, NULL, _greenView.bounds);
        _greenView.layer.shadowPath = circlePath; CGPathRelease(circlePath);

     }
    return _greenView;
}

@end
