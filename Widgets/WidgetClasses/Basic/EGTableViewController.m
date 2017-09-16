//
//  EGTableViewController.m
//  Widgets
//
//  Created by EG on 2017/9/15.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGTableViewController.h"

@interface EGTableViewController()
<
UITableViewDelegate,
UITableViewDataSource
>

/**table view*/
@property (nonatomic, strong)UITableView *tableView;
/**frame*/
@property (nonatomic, assign)CGRect frame;
@end

@implementation EGTableViewController

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data {
    if (self = [super init]) {
        self.datasArray = data;
        self.frame = frame;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view = self.tableView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor darkGrayColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[NSClassFromString(self.datasArray[indexPath.row]) new] animated:YES];
}

#pragma mark - data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellID"];
    }
    
    cell.backgroundColor =
    (indexPath.row%2 == 1 ? [UIColor lightGrayColor] : [UIColor darkGrayColor]);
    cell.textLabel.text = self.datasArray[indexPath.row];
    return cell;
}
 
@end
