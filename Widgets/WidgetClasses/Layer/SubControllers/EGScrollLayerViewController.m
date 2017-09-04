//
//  EGScrollLayerViewController.m
//  Widgets
//
//  Created by EG on 2017/9/4.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGScrollLayerViewController.h"

@implementation EGScrollView


- (instancetype)initWithFrame:(CGRect)frame {
        //this is called when view is created in code
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
        //this is called when view is created from a nib
    [super awakeFromNib];
    [self setUp];
}


- (void)setUp {
        //enable clipping
    self.layer.masksToBounds = YES;
    
    CALayer *mark = [[CALayer alloc]init];
    mark.frame = CGRectMake(0, 0, 100, 100);
    mark.backgroundColor = [UIColor redColor].CGColor;
    
    [self.layer addSublayer:mark];
    
        //attach pan gesture recognizer
    UIPanGestureRecognizer *recognizer = nil;
    recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
}

+ (Class)layerClass {
    return [CAScrollLayer class];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
        //get the offset by subtracting the pan gesture
    
    
        //translation from the current bounds origin
    CGPoint offset = self.bounds.origin;
    offset.x -= [recognizer translationInView:self].x;
    offset.y -= [recognizer translationInView:self].y;
    
        //scroll the layer
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
        //reset the pan gesture translation
    [recognizer setTranslation:CGPointZero inView:self];
    
    NSLog(@"pan on it");
}

@end


/**
 CAScrollLayer有一个-scrollToPoint:方法，它自动适应bounds的原点以便图层内容出现在滑动的地方。
 注意，这就是它做的所有事情。Core Animation并不处理用户输入，
 所以CAScrollLayer并不负责将触摸事件转换为滑动事件，既不渲染滚动条，也不实现任何iOS指定行为例如滑动反弹
 （当视图滑动超多了它的边界的将会反弹回正确的地方）
 
 CAScrollLayer有一个潜在的有用特性，有一个扩展分类实现了一些方法和属性：
 - (void)scrollPoint:(CGPoint)p;
 - (void)scrollRectToVisible:(CGRect)r;
 @property(readonly) CGRect visibleRect;
 */
@interface EGScrollLayerViewController ()

@end

@implementation EGScrollLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    EGScrollView *scrollView = [[EGScrollView alloc]initWithFrame:CGRectMake(100, 100, SCREEN_WIDTH -  200, 200)];
    scrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
