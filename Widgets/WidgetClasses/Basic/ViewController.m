//
//  ViewController.m
//  Widgets
//
//  Created by EG on 2017/8/4.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

/**widges*/
@property (strong, nonatomic)NSArray *widges;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"EG WIDGES";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.widges.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"widgesCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"widgesCellID"];
    }
    cell.textLabel.text = self.widges[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[NSClassFromString(self.widges[indexPath.row]) new]
                                         animated:YES];

}

- (NSArray <NSString *>*)widges {
    if (!_widges) {
        _widges = @[
                    @"EGTestViewController",
                    @"EGSeperateScrollViewController",
                    @"EGIndicatorViewController",
                    
                    ];
    }
    return _widges;
}

@end
