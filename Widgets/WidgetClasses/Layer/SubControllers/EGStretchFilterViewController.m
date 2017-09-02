//
//  EGStretchFilterViewController.m
//  Widgets
//
//  Created by EG on 2017/9/2.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGStretchFilterViewController.h"

@interface EGStretchFilterViewController ()

//伪关键字IBOutletCollection，我们使用这个关键字，可以将界面上一组相同的控件连接到同一个数组中。
//IBOutletCollection集合中对象的顺序是不确定的。我们通过调试方法可以看到集合中对象的顺序跟我们连接的顺序是一样的。但是这个顺序可能会因为不同版本的Xcode而有所不同。所以我们不应该试图在代码中去假定这种顺序。
//不管IBOutletCollection(ClassName)中的控件是什么，属性的类型始终是NSArray。实际上，我们可以声明是任何类型，如NSSet，NSMutableArray，甚至可以是UIColor，但不管我们在此设置的是什么类，IBOutletCollection属性总是指向一个NSArray数组

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *digitViews;

@property (nonatomic, weak) NSTimer *timer;
@end

@implementation EGStretchFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad]; //get spritesheet image
    UIImage *digits = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Digits" ofType:@"png"]];
//    [UIImage imageNamed:@"Digits.png"]
    
        //set up digit views
    for (UIView *view in self.digitViews) {
            //set contents
//        view.layer.magnificationFilter = kCAFilterNearest;
        view.layer.contents = (__bridge id)digits.CGImage;
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
            //        view.layer.contentsGravity = kCAGravityResizeAspect;//在xib中处理过图像显示模式，打开的话都一样
    }
    
	//start timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
	//set initial clock time
    [self tick];
}

- (void)tick {
        //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
        //set hours
    [self setDigit:components.hour / 10 forView:self.digitViews[0]];
    [self setDigit:components.hour % 10 forView:self.digitViews[1]];
    
        //set minutes
    [self setDigit:components.minute / 10 forView:self.digitViews[2]];
    [self setDigit:components.minute % 10 forView:self.digitViews[3]];
    
        //set seconds
    [self setDigit:components.second / 10 forView:self.digitViews[4]];
    [self setDigit:components.second % 10 forView:self.digitViews[5]];
}

- (void)setDigit:(NSInteger)digit forView:(UIView *)view {
        //adjust contentsRect to select correct digit
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
    view.layer.shadowOpacity = 0.0f;
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
