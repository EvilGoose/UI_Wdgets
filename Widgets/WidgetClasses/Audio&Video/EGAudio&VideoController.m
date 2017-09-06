//
//  EGAudio&VideoController.m
//  Widgets
//
//  Created by EG on 2017/9/6.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGAudio&VideoController.h"

@interface EGAudio_VideoController ()
<
UITableViewDelegate,
UITableViewDataSource
>

/**table view*/
@property (nonatomic, strong)UITableView *tableView;

/**data*/
@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation EGAudio_VideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"Audio&Video";
    self.view = self.tableView;
}

#pragma mark - delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[NSClassFromString(self.dataArray[indexPath.row]) new] animated:YES];
}

#pragma mark - data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellID"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       
                       @"EGMicroPhoneViewController",
                       @"EGVideoCaptureViewController",
                       @"EGMixAudioViewController",
                       @"EGMixVideoViewController",
                       @"EGMixAudioVideoViewController",
                       @"EGFFMPEGViewController"
                       ];
    }
    return _dataArray;
}

@end
