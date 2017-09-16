//
//  EGKVCPropertyAnimationViewController.m
//  Widgets
//
//  Created by EG on 2017/9/16.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGKVCPropertyAnimationViewController.h"

@interface EGKVCPropertyAnimationViewController ()
<
CAAnimationDelegate
>
@property (nonatomic, strong) UIImageView *hourHand;

@property (nonatomic, strong) UIImageView *minuteHand;

@property (nonatomic, strong) UIImageView *secondHand;

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation EGKVCPropertyAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.hourHand];
    [self.view addSubview:self.minuteHand];
    [self.view addSubview:self.secondHand];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        //set initial hand positions
    [self updateHandsAnimated:NO];
}

- (void)tick {
    [self updateHandsAnimated:YES];
} 

- (void)updateHandsAnimated:(BOOL)animated {
        //convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
        //calculate hour hand angle
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
        //calculate minute hand angle
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
        //calculate second hand angle
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    
        //rotate hands
    [self setAngle:hourAngle forHand:self.hourHand animated:animated];
    [self setAngle:minuteAngle forHand:self.minuteHand animated:animated];
    [self setAngle:secondAngle forHand:self.secondHand animated:animated];
}

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated {
        //generate transform
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
            //create transform animation
        CABasicAnimation *animation = [CABasicAnimation animation];
        [self updateHandsAnimated:NO];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
            //here is KVC!!!
        [animation setValue:handView forKey:@"handView"];
        [handView.layer addAnimation:animation forKey:nil];
    }
    else {
            //set transform directly
        handView.layer.transform = transform;
    }
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
        //set final position for hand view
    UIView *handView = [anim valueForKey:@"handView"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
}

#pragma mark - lazy

- (UIImageView *)hourHand {
    if (!_hourHand) {
        _hourHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hour"]];
        _hourHand.layer.anchorPoint = CGPointMake(0.5, 1);
        _hourHand.layer.contentsGravity = kCAGravityResizeAspect;
        _hourHand.frame = CGRectMake(100, 100, _hourHand.width, _hourHand.height);
    }
    return _hourHand;
}

- (UIImageView *)minuteHand {
    if (!_minuteHand) {
        _minuteHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Minute"]];
        _minuteHand.layer.anchorPoint = CGPointMake(0.5, 1);
        _minuteHand.layer.contentsGravity = kCAGravityResizeAspect;
        _minuteHand.frame = CGRectMake(100, 100 - (_minuteHand.height - _hourHand.height), _minuteHand.width, _minuteHand.height);
    }
    return _minuteHand;
}

- (UIImageView *)secondHand {
    if (!_secondHand) {
        _secondHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Second"]];
        _secondHand.layer.anchorPoint = CGPointMake(0.5, 1);
        _secondHand.layer.contentsGravity = kCAGravityResizeAspect;
        _secondHand.frame = CGRectMake(100, 100 - (_secondHand.height - _hourHand.height), _secondHand.width, _secondHand.height);
    }
    return _secondHand;
}

@end
