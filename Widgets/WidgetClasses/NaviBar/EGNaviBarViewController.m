//
//  EGNaviBarViewController.m
//  Widgets
//
//  Created by EG on 2017/8/12.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGNaviBarViewController.h"
#import "UIColor+PDExtension.h"
#import <Masonry.h>

@interface EGDoubleTitleButton ()

/*top title lable*/
@property (strong, nonatomic)UILabel *topLabel;

/*bottom title label*/
@property (strong, nonatomic)UILabel *bottomLabel;

/*selected line*/
@property (strong, nonatomic)UIImageView *selectedLine;

@end

@implementation EGDoubleTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topLabel];
        [self addSubview:self.bottomLabel];
        [self addSubview:self.selectedLine];
        self.selectedLine.hidden = YES;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    self.bottomTitle = title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@23);
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.equalTo(@21);
    }];
    
    [self.selectedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.bottomLabel.mas_bottom).offset(9);
        make.size.mas_equalTo(CGSizeMake(75, 2));
    }];
}

#pragma mark -  setter

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.selectedLine.hidden = !selected;
}

- (void)setTopTitle:(NSString *)topTitle
{
    _topTitle = topTitle;
    self.topLabel.text = topTitle;
}

- (void)setBottomTitle:(NSString *)bottomTitle
{
    _bottomTitle = bottomTitle;
    self.bottomLabel.text = bottomTitle;
}

#pragma mark - lazy

- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = [UIColor whiteColor];
        _bottomLabel.text = @"0";
    }
    return _topLabel;
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomLabel setTextColor:[UIColor whiteColor]];
        _bottomLabel.text = @"0";
    }
    return _bottomLabel;
}

- (UIImageView *)selectedLine
{
    if (!_selectedLine) {
        _selectedLine = [[UIImageView alloc]initWithImage:nil];
        _selectedLine.backgroundColor = [UIColor blackColor];
    }
    return _selectedLine;
}

@end


@interface EGPersonalOptionView()

/*作品按钮*/
@property (strong, nonatomic)EGDoubleTitleButton *worksButton;

/*关注按钮*/
@property (strong, nonatomic)EGDoubleTitleButton *focusButton;

/*粉丝按钮*/
@property (strong, nonatomic)EGDoubleTitleButton *fansButton;

/*选中按钮*/
@property (weak, nonatomic)EGDoubleTitleButton *selectedButton;

/**底部分割线*/
@property (strong, nonatomic)UIImageView *bottomSeperator;

@end

@implementation EGPersonalOptionView

- (void)setDefaultIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            self.selectedButton = self.worksButton;
            break;
            
        case 1:
            self.selectedButton = self.focusButton;
            
        default:
            self.selectedButton = self.fansButton;
            break;
    }
    [self optionViewUserClickAction:self.selectedButton];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    self.worksButton.topLabel.textColor = titleColor;
    self.fansButton.topLabel.textColor = titleColor;
    self.focusButton.topLabel.textColor = titleColor;
}

- (void)setSubTitleColor:(UIColor *)subTitleColor
{
    self.worksButton.bottomLabel.textColor = subTitleColor;
    self.fansButton.bottomLabel.textColor = subTitleColor;
    self.focusButton.bottomLabel.textColor = subTitleColor;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    [self addSubview:self.worksButton];
    [self addSubview:self.focusButton];
    [self addSubview:self.fansButton];
    [self addSubview:self.bottomSeperator];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.worksButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self.focusButton.mas_left);
        make.width.equalTo(self.focusButton);
    }];
    
    [self.focusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self);
        make.left.equalTo(self.worksButton.mas_right);
        make.right.equalTo(self.fansButton.mas_left);
        make.width.equalTo(self.fansButton);
    }];
    
    [self.fansButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self);
        make.left.equalTo(self.focusButton.mas_right);
        make.right.equalTo(self);
        make.width.equalTo(self.worksButton);
    }];
    
    [self.bottomSeperator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}

#pragma mark - setter

- (void)setSelectedButton:(EGDoubleTitleButton *)selectedButton
{
    _selectedButton.selected = NO;
    _selectedButton = selectedButton;
    _selectedButton.selected = YES;
}

- (void)setWorkNumber:(NSString *)workNumber
{
    _workNumber = workNumber;
    self.worksButton.topTitle = workNumber;
}

- (void)setFocusNumber:(NSString *)focusNumber
{
    _focusNumber = focusNumber;
    self.focusButton.topTitle = focusNumber;
}

- (void)setFansNumber:(NSString *)fansNumber
{
    _fansNumber = fansNumber;
    self.fansButton.topTitle = fansNumber;
}

#pragma mark - lazy

- (EGDoubleTitleButton *)worksButton
{
    if (!_worksButton) {
        _worksButton = [EGDoubleTitleButton buttonWithType:UIButtonTypeCustom];
        _worksButton.topTitle = @"0";
        _worksButton.bottomTitle = @"作品";
        [_worksButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9"] forState:UIControlStateNormal];
        [_worksButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9" alpha:.8] forState:UIControlStateSelected];
        [_worksButton addTarget:self action:@selector(optionViewUserClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _worksButton;
}

- (EGDoubleTitleButton *)focusButton
{
    if (!_focusButton) {
        _focusButton = [EGDoubleTitleButton buttonWithType:UIButtonTypeCustom];
        _focusButton.topTitle = @"0";
        _focusButton.bottomTitle = @"关注";
        [_focusButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9"] forState:UIControlStateNormal];
        [_focusButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9" alpha:.8] forState:UIControlStateSelected];
        [_focusButton addTarget:self action:@selector(optionViewUserClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focusButton;
}

- (EGDoubleTitleButton *)fansButton
{
    if (!_fansButton) {
        _fansButton = [EGDoubleTitleButton buttonWithType:UIButtonTypeCustom];
        _fansButton.topTitle = @"0";
        _fansButton.bottomTitle = @"飞迷";
        [_fansButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9"] forState:UIControlStateNormal];
        [_fansButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9" alpha:.8] forState:UIControlStateSelected];
        [_fansButton addTarget:self action:@selector(optionViewUserClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fansButton;
}

- (UIImageView *)bottomSeperator
{
    if (!_bottomSeperator) {
        _bottomSeperator = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        _bottomSeperator.backgroundColor = [UIColor darkGrayColor];
    }
    return _bottomSeperator;
}

- (void)optionViewUserClickAction:(EGDoubleTitleButton *)sender
{
    self.selectedButton = sender;
    if (!self.clickedCallBack) return;
    
    NSInteger index;
    if (sender == self.worksButton) {
        index = 0;
    }else if (sender == self.focusButton) {
        index = 1;
    }else {
        index = 2;
    }
    
    self.clickedCallBack(index);
    
}

@end

#import "WRNavigationBar.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT + OPTION_VIEW_HEIGHT - NAVIGATION_BAR_HEIGHT * 2)
#define OPTION_VIEW_HEIGHT 65
#define IMAGE_HEIGHT 220

@interface EGNaviBarViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UIImageView *topView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (strong, nonatomic) EGPersonalOptionView *optionsView;

@property (nonatomic, strong) UITableView *tableView;

@property (weak, nonatomic)UIImageView *navBarHairlineImageView;

/**data 1*/
@property (strong, nonatomic)NSArray *dataList1;

/**data 2*/
@property (strong, nonatomic)NSArray *dataList2;

/**data 3*/
@property (strong, nonatomic)NSArray *dataList3;

/**selectedIndex*/
@property (assign, nonatomic)NSInteger selectedIndex;

/**index dict*/
@property (strong, nonatomic)NSMutableDictionary *indexDict;

/**flag*/
@property (assign, nonatomic)BOOL topFlag;
@property (assign, nonatomic)BOOL gradualFlag;

@end

@implementation EGNaviBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"··· " style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Navi_Back"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)]];
    
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    self.title = @"";
    [self.view addSubview:self.tableView];
    
    [self.topView addSubview:self.iconView];
	self.iconView.center = CGPointMake(self.topView.center.x, self.topView.center.y - 10);
    
    [self.topView addSubview:self.nameLabel];
    self.nameLabel.frame = CGRectMake(0, self.iconView.frame.size.height + self.iconView.frame.origin.y + 6, self.view.frame.size.width, 19);
    
    [self.view addSubview:self.optionsView];
    [self.optionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(IMAGE_HEIGHT);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(OPTION_VIEW_HEIGHT);
    }];

    self.tableView.tableHeaderView = self.topView;
    
        // 设置导航栏颜色
    [self wr_setNavBarBarTintColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]];
    
        // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    
        // 设置导航栏按钮和标题颜色
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    
    
}

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view
{
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return(UIImageView*)view;
    }
    
     for(UIView*subview in view.subviews) {
         UIImageView*imageView = [self findHairlineImageViewUnder:subview];
         if(imageView)  return imageView;
    }
    return nil;
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.optionsView setDefaultIndex:0];
    self.navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
        //控制
 
//    if (offsetY >= IMAGE_HEIGHT - OPTION_VIEW_HEIGHT) {
//        self.gradualFlag = NO;
//    }else {
//        self.gradualFlag = YES;
//    }
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAVIGATION_BAR_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        [self.optionsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        }];
        self.nameLabel.text = @"";
        self.title = @"HELLO";
        
        [self.optionsView setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self.optionsView setSubTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self.optionsView setBackgroundColor:[[UIColor colorWithHexString:@"f7f7f7"] colorWithAlphaComponent:alpha]];
    
    }
    else {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[UIColor whiteColor]];
        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
        [self.optionsView setTitleColor:[UIColor whiteColor]];
        [self.optionsView setBackgroundColor:[UIColor orangeColor]];
        [self.optionsView setSubTitleColor:[UIColor whiteColor]];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.optionsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(IMAGE_HEIGHT  - offsetY);
        }];
        self.nameLabel.text = @"HELLO";
        self.title = @"";
       }
}

#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array;
    switch (self.selectedIndex) {
        case 0:
            array = self.dataList1;
            break;
        case 1:
            array = self.dataList2;
            break;
        case 2:
            array = self.dataList3;
            break;
            
        default:
            break;
    }
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSArray *array;
    switch (self.selectedIndex) {
        case 0:
            array = self.dataList1;
            break;
        case 1:
            array = self.dataList2;
            break;
        case 2:
            array = self.dataList3;
            break;
            
        default:
            break;
    }
     cell.textLabel.text = array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     switch (self.selectedIndex) {
        case 0:
             return 50;
        case 1:
             return 60;
        default:
             return 70;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = RANDOM_COLOR;
    vc.title = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:frame
            style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(- NAVIGATION_BAR_HEIGHT, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIImageView *)topView
{
    if (_topView == nil) {
        _topView = [[UIImageView alloc] initWithImage:nil];
        _topView.backgroundColor = [UIColor orangeColor];
        _topView.frame = CGRectMake(0, 0, self.view.frame.size.width, IMAGE_HEIGHT + OPTION_VIEW_HEIGHT);
    }
    return _topView;
}

- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image5"]];
        _iconView.bounds = CGRectMake(0, 0, 80, 80);
        _iconView.layer.cornerRadius = 40;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.text = @"HELLO";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}

- (EGPersonalOptionView *)optionsView
{
    if (!_optionsView) {
        _optionsView = [[EGPersonalOptionView alloc]initWithFrame:CGRectMake(0, IMAGE_HEIGHT, SCREEN_WIDTH, OPTION_VIEW_HEIGHT)];
        _optionsView.backgroundColor = [UIColor orangeColor];
        __weak typeof(self) weakSelf = self;
        _optionsView.clickedCallBack = ^(NSInteger index) {
            [weakSelf handleOptionClickIndex:index];
        };
    }
    return _optionsView;
}

- (void)handleOptionClickIndex:(NSInteger )index
{
    NSString *lastKey;
    switch (self.selectedIndex) {
        case 0:
            lastKey = @"list1";
            break;
        case 1:
            lastKey = @"list2";
            break;
        case 2:
            lastKey = @"list3";
            break;
            
        default:
            break;
    }
    
    [self.indexDict setValue:@(self.tableView.contentOffset.y) forKey:lastKey];
    
    NSString *current;
    switch (index) {
        case 0:
            current = @"list1";
            break;
        case 1:
            current = @"list2";
            break;
        case 2:
            current = @"list3";
            break;
            
        default:
            break;
    }    
    self.selectedIndex = index;
    [self.tableView reloadData];
//    if (self.gradualFlag) {
//        self.tableView.contentOffset = CGPointMake(0, IMAGE_HEIGHT - OPTION_VIEW_HEIGHT);
//    }else {
        self.tableView.contentOffset = CGPointMake(0, [[self.indexDict valueForKey:current] floatValue]);
//    }
}

- (NSArray *)dataList1 {
    if (!_dataList1) {
        _dataList1 = @[
                       @"List1_1",@"List1_2",@"List1_3",@"List1_4",@"List1_5",
                       @"List1_6",@"List1_7",@"List1_8",@"List1_9",@"List1_10",
                       @"List1_11",@"List1_12",@"List1_13",@"List1_14",@"List1_15",
                       @"List1_16",@"List1_17",@"List1_18",@"List1_19",@"List1_20",
                       @"List1_21",@"List1_22",@"List1_23",@"List1_24",@"List1_25",
                       @"List1_26",@"List1_37",@"List1_28",@"List1_29",@"List1_30",
                       @"List1_31",@"List1_32",@"List1_33",@"List1_34",@"List1_35",
                       @"List1_36",@"List1_37",@"List1_38",@"List1_39",@"List1_40",
                       @"List1_41",@"List1_42",@"List1_43",@"List1_44",@"List1_45",
                       @"List1_46",@"List1_47",@"List1_48",@"List1_49",@"List1_50"];
    }
    return _dataList1;
}

- (NSArray *)dataList2 {
    if (!_dataList2) {
        _dataList2 = @[
                       @"List2_1",@"List2_2",@"List2_3",@"List2_4",@"List2_5",
//                       @"List2_6",@"List2_7",@"List2_8",@"List2_9",@"List2_10",
//                       @"List2_11",@"List2_12",@"List2_13",@"List2_14",@"List2_15",
//                       @"List2_16",@"List2_17",@"List2_18",@"List2_19",@"List2_20",
//                       @"List2_21",@"List2_22",@"List2_23",@"List2_24",@"List2_25",
//                       @"List2_26",@"List2_37",@"List2_28",@"List2_29",@"List2_30",
//                       @"List2_31",@"List2_32",@"List2_33",@"List2_34",@"List2_35",
//                       @"List2_36",@"List2_37",@"List2_38",@"List2_39",@"List2_40"
                       ];
    }
    return _dataList2;
}

- (NSArray *)dataList3 {
    if (!_dataList3) {
        _dataList3 = @[
                       @"List3_1",@"List3_2",@"List3_3",@"List3_4",@"List3_5",
                       @"List3_6",@"List3_7",@"List3_8",@"List3_9",@"List3_10",
                       @"List3_11",@"List3_12",@"List3_13",@"List3_14",@"List3_15",
                       @"List3_16",@"List3_17",@"List3_18",@"List3_19",@"List3_20",
                       @"List3_21",@"List3_22",@"List3_23",@"List3_24",@"List3_25",
                       @"List3_26",@"List3_37",@"List3_28",@"List3_29",@"List3_30",
                       @"List3_31",@"List3_32",@"List3_33",@"List3_34",@"List3_35",
                       @"List3_36",@"List3_37",@"List3_38",@"List3_39",@"List3_40",
                       @"List3_41",@"List3_42",@"List3_43",@"List3_44",@"List3_45",
                       @"List3_46",@"List3_47",@"List3_48",@"List3_49",@"List3_50",
                       @"List3_51",@"List3_52",@"List3_53",@"List3_54",@"List3_55",
                       @"List3_56",@"List3_57",@"List3_58",@"List3_59",@"List3_60"
                       ];
    }
    return _dataList3;
}

- (NSMutableDictionary *)indexDict {
    if (!_indexDict) {
        _indexDict = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                     @"list1":@0,
                                                                     @"list2":@0,
                                                                     @"list3":@0,
                                                                     }];
    }
    return _indexDict;
}


@end
