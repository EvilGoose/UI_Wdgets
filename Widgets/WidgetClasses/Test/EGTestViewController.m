//
//  EGTestViewController.m
//  Widgets
//
//  Created by EG on 2017/8/5.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGTestViewController.h"
#import <MJRefresh.h>

@interface EGTestViewController ()
<UITableViewDataSource>

/**table view*/
@property (strong, nonatomic)UITableView *tableView;

@end

@implementation EGTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"widgesCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"widgesCellID"];
    }
    cell.textLabel.text = @"Hello";
    return cell;
    
}

#pragma mark - lazy 
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:SCREEN_BOUNDS];
        _tableView.backgroundColor = YELLOW_COLOR;
        _tableView.dataSource = self; 
    }
    return _tableView;
}

@end
