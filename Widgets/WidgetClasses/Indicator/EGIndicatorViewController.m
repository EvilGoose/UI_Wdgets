//
//  EGIndicatorViewController.m
//  Widgets
//
//  Created by EG on 2017/8/5.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGIndicatorViewController.h"

#import "GradientPeogressView.h"

@interface EGIndicatorViewController ()

/**custom indicator*/
@property (strong, nonatomic)GradientPeogressView *indicatorView;

@end

@implementation EGIndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.indicatorView];
}


- (GradientPeogressView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[GradientPeogressView alloc]initWithFrame:CGRectMake(10, 100, 40, 40)];
        _indicatorView.customColor = [UIColor blueColor];
        _indicatorView.gradient = YES;
        [_indicatorView setPercent:.8 animated:NO duration:0];
    }
    return _indicatorView;
}

@end
