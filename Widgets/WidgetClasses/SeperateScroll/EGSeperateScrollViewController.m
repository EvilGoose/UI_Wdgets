//
//  EGSeperateScrollViewController.m
//  Widgets
//
//  Created by EG on 2017/8/5.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGSeperateScrollViewController.h"
#import <MJRefresh.h>

@interface EGSeperateScrollViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
/**container*/
@property (strong, nonatomic)UIScrollView *containerScrollView;

/**top tableView*/
@property (strong, nonatomic)UITableView *topTableView;

/**bottom tableView*/
@property (strong, nonatomic)UITableView *bottomTableView;

@end

@implementation EGSeperateScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view = self.containerScrollView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.containerScrollView addSubview:self.topTableView];
    [self.containerScrollView addSubview:self.bottomTableView];
}

- (void)test {
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
    if (tableView == self.topTableView) {
        cell.textLabel.text = @"Hello";
    }else {
        cell.textLabel.text = @"World";
    }
    return cell;
 }

#pragma mark - lazy

- (UIScrollView *)containerScrollView {
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc]initWithFrame:SCREEN_BOUNDS];
        _containerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
        _containerScrollView.backgroundColor = ORANGE_COLOR;
        _containerScrollView.scrollEnabled = NO;
    }
    return _containerScrollView;
}

- (UITableView *)topTableView {
    if (!_topTableView) {
        _topTableView = [[UITableView alloc]initWithFrame:SCREEN_BOUNDS];
        _topTableView.delegate = self;
        _topTableView.dataSource = self;
        _topTableView.backgroundColor = CLEAR_COLOR;
        MJRefreshBackNormalFooter *mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [UIView animateWithDuration:.5 animations:^{
                self.containerScrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);
            } completion:^(BOOL finished) {
                [_topTableView.mj_footer endRefreshing];
            }];
        }];
        mj_footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
		mj_footer.automaticallyHidden = YES;
        mj_footer.stateLabel.hidden = YES;
        _topTableView.mj_footer = mj_footer;
     }
    return _topTableView;
}

- (UITableView *)bottomTableView {
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.backgroundColor = CLEAR_COLOR;
        MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [UIView animateWithDuration:.5 animations:^{
                self.containerScrollView.contentOffset = CGPointZero;
            } completion:^(BOOL finished) {
                [_bottomTableView.mj_header endRefreshing];
            }];
        }];
        mj_header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        mj_header.stateLabel.hidden = YES;
        _bottomTableView.mj_header = mj_header;
    }
    return _bottomTableView;
}

@end
