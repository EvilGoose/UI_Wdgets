//
//  EGBasicViewController.m
//  Widgets
//
//  Created by EG on 2017/8/4.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGBasicViewController.h"

@interface EGBasicViewController ()

@end

@implementation EGBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.title == nil) {
        self.title = NSStringFromClass(self.class);
    }
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
