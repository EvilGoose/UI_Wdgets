//
//  EGPropertyAnimationViewController.m
//  Widgets
//
//  Created by EG on 2017/9/15.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGPropertyAnimationViewController.h"

/**
     隐式动画: “仅改变了一个属性，然后Core Animation来决定如何并且何时去做动画”
     
     “但当你改变一个属性，Core Animation是如何判断动画类型和持续时间的呢？实际上动画执行的时间取决于当前 事务 的设置，动画类型取决于图层行为。
     
     事务 实际上是Core Animation用来包含一系列属性动画集合的机制，任何用指定事务去改变可以做动画的图层属性都不会立刻发生变化，而是当事务一旦提交的时候开始用一个动画过渡到新值。
     
     事务 是通过CATransaction类来做管理，这个类的设计有些奇怪，不像你从它的命名预期的那样去管理一个简单的事务，而是管理了一叠你不能访问的事务。CATransaction没有属性或者实例方法，并且也不能用+alloc和-init方法创建它。但是可以用+begin和+commit分别来入栈或者出栈。”
     
     “任何可以做动画的图层属性都会被添加到栈顶的事务，你可以通过+setAnimationDuration:方法设置当前事务的动画时间，或者通过+animationDuration方法来获取值 (默认0.25秒)”
 
     “Core Animation在每个run loop周期中自动开始一次新的事务（run loop是iOS负责收集用户输入，处理定时器或者网络事件并且重新绘制屏幕的东西），即使你不显式的用[CATransaction begin]开始一次事务，任何在一次run loop循环中属性的改变都会被集中起来，然后做一次0.25秒的动画。”
     
     “我们知道Core Animation通常对CALayer的所有属性（可动画的属性）做动画，但是UIView把它关联的图层的这个特性关闭了。”
     
     “我们把改变属性时CALayer自动应用的动画称作行为，当CALayer的属性被修改时候，它会调用-actionForKey:方法，传递属性的名称”
     
     实质上是如下几步：
     
     - 图层首先检测它是否有委托，并且是否实现CALayerDelegate协议指定的-actionForLayer:forKey方法。如果有，直接调用并返回结果。
     
     - 如果没有委托，或者委托没有实现-actionForLayer:forKey方法，图层接着检查包含属性名称对应行为映射的actions字典。
     
     - 如果actions字典没有包含对应的属性，那么图层接着在它的style字典接着搜索属性名。
     
     - 最后，如果在style里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的-defaultActionForKey:方法。
     
     所以一轮完整的搜索结束之后，-actionForKey:要么返回空（这种情况下将不会有动画发生），要么是CAAction协议对应的对象，最后CALayer拿这个结果去对先前和当前的值做动画。
     
     这就解释了UIKit是如何禁用隐式动画的：
     每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，UIView对所有图层行为返回nil，但是在动画block范围之内，它就返回了一个非空值
*/

/*
 “CALayer的属性行为其实很不正常，因为改变一个图层的属性并没有立刻生效，而是通过一段时间渐变更新。”
 
 “当你改变一个图层的属性，属性值的确是立刻更新的（如果你读取它的数据，你会发现它的值在你设置它的那一刻就已经生效了），但是屏幕上并没有马上发生改变。这是因为你设置的属性并没有直接调整图层的外观，相反，他只是定义了图层动画结束之后将要变化的外观。
 
 当设置CALayer的属性，实际上是在定义当前事务结束之后图层如何显示的模型。Core Animation扮演了一个控制器的角色，并且负责根据图层行为和事务设置去不断更新视图的这些属性在屏幕上的状态。
 
 在iOS中，屏幕每秒钟重绘60次。如果动画时长比60分之一秒要长，Core Animation就需要在设置一次新值和新值生效之间，对屏幕上的图层进行重新组织。这意味着CALayer除了“真实”值（就是你设置的值）之外，必须要知道当前显示在屏幕上的属性值的记录。”
 
 变化流程
 
 “CALayer除了“真实”值（就是你设置的值）之外，必须要知道当前显示在屏幕上的属性值的记录”
 “每个图层属性的显示值都被存储在一个叫做呈现图层的独立图层”
 “这个呈现图层实际上是模型图层的复制，但是它的属性值代表了在任何指定时刻当前外观效果。”(使用 -presentationLayer 访问)
 “呈现树通过图层树中所有图层的呈现图层所形成。注意: 呈现图层仅仅当图层首次被提交（就是首次第一次在屏幕上显示）的时候创建”
 “用呈现图层来响应交互”
 */

@interface EGPropertyAnimationViewController ()

/**view*/
@property (nonatomic, strong)UIView *presentView;

/**colorLayer*/
@property (nonatomic, strong)CALayer *colorLayer;

@end

@implementation EGPropertyAnimationViewController

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.presentView];
    
    //test layer action when outside of animation block
    //    NSLog(@"Outside: %@", [self.presentView actionForLayer:self.presentView.layer forKey:@"backgroundColor"]);
    //
    //    [UIView animateWithDuration:1.0 animations:^{
    //
    //            test layer action when inside of animation block
    //        NSLog(@"Inside: %@", [self.presentView actionForLayer:self.presentView.layer forKey:@"backgroundColor"]);
    //    }];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(100, 100.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    CATransition *transition = [CATransition animation];
        //下面两个很值得研究下
    transition.type = kCATransitionMoveIn;
//    kCATransitionFade;
//    kCATransitionReveal;
//    kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
//	  kCATransitionFromRight
    
    self.colorLayer.actions = @{@"backgroundColor": transition};
   
        //add it to our view
    [self.presentView.layer addSublayer:self.colorLayer];
//            [self.view.layer addSublayer:self.colorLayer]; //比较上面的效果发现,隐式动画被取消了
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:1.0];
    
        //    [CATransaction setDisableActions:YES];//用于禁止隐式动画

    
//    [CATransaction setCompletionBlock:^{
//        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI * .5);
//        self.colorLayer.affineTransform = transform;
//    }];
    
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
//    放在这效果不一样,默认的旋转时间仍然是0.25s
//    [CATransaction setCompletionBlock:^{
//        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI * .5);
//        self.colorLayer.affineTransform = transform;
//    }];
//    
    
//    [CATransaction commit];
}

*/

- (void)viewDidLoad {
    [super viewDidLoad];
        //create a red layer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self.view];
        //check if we've tapped the moving layer
    if ([self.colorLayer.presentationLayer hitTest:point]) {
            //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
            //otherwise (slowly) move the layer to new position
        [CATransaction begin];
        [CATransaction setAnimationDuration:4.0];
        self.colorLayer.position = point;
        [CATransaction commit];
    }
}
        
- (UIView *)presentView {
    if (!_presentView) {
        _presentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _presentView.backgroundColor = [UIColor blackColor];
        _presentView.center = self.view.center;
    }
    return _presentView;
}
@end
