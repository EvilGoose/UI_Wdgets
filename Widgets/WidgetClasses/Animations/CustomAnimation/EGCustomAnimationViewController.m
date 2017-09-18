
    //
//  EGCustomAnimationViewController.m
//  Widgets
//
//  Created by EG on 2017/9/18.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGCustomAnimationViewController.h"

@interface EGCustomAnimationViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)NSArray *datasArray;

@property (nonatomic, copy) NSArray *images;

@property (nonatomic, assign)NSInteger selectedIndex;

@end

@implementation EGCustomAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedIndex = 0;
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.tableView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView transitionWithView:self.imageView
                      duration:1
                       options:(self.selectedIndex << 20)
                    animations:^{
                        UIImage *currentImage = self.imageView.image;
                        NSUInteger index = [self.images indexOfObject:currentImage];
                        index = (index + 1) % [self.images count];
                        self.imageView.image = self.images[index];
                    }
                    completion:^(BOOL finished) {
                        
                    }];
}


#pragma mark - lazy

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon1"]];
        _imageView.backgroundColor = [UIColor greenColor];
        _imageView.centerX = self.view.centerX;
        _imageView.y = 70;
    }
    return _imageView;
}

- (NSArray *)images {
    if (!_images) {
        _images = @[[UIImage imageNamed:@"icon1"],
                    [UIImage imageNamed:@"icon2"],
                    [UIImage imageNamed:@"icon3"],
                    [UIImage imageNamed:@"icon4"]];
    }
    return _images;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor darkGrayColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSArray *)datasArray {
    if (!_datasArray) {
        _datasArray = @[
                        @"UIViewAnimationOptionTransitionNone",
                        @"UIViewAnimationOptionTransitionFlipFromLeft",
                        @"UIViewAnimationOptionTransitionFlipFromRight",
                        @"UIViewAnimationOptionTransitionCurlUp",
                        @"UIViewAnimationOptionTransitionCurlDown",
                        @"UIViewAnimationOptionTransitionCrossDissolve",
                        @"UIViewAnimationOptionTransitionFlipFromTop",
                        @"UIViewAnimationOptionTransitionFlipFromBottom"
                        ];
    }
    return _datasArray;
}

#pragma mark - delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
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
    
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.text = self.datasArray[indexPath.row];
    return cell;
}

@end
