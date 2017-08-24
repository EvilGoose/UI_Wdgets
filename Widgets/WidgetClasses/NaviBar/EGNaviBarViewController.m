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

@interface GDUDoubleTitleButton ()

/*top title lable*/
@property (strong, nonatomic)UILabel *topLabel;

/*bottom title label*/
@property (strong, nonatomic)UILabel *bottomLabel;

/*selected line*/
@property (strong, nonatomic)UIImageView *selectedLine;

@end

@implementation GDUDoubleTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topLabel];
        [self addSubview:self.bottomLabel];
        [self addSubview:self.selectedLine];
        self.selectedLine.hidden = YES;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    self.bottomTitle = title;
}

- (void)layoutSubviews {
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

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.selectedLine.hidden = !selected;
}

- (void)setTopTitle:(NSString *)topTitle {
    _topTitle = topTitle;
    self.topLabel.text = topTitle;
}

- (void)setBottomTitle:(NSString *)bottomTitle {
    _bottomTitle = bottomTitle;
    self.bottomLabel.text = bottomTitle;
}

#pragma mark - lazy

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = [UIColor whiteColor];
        _bottomLabel.text = @"0";
    }
    return _topLabel;
}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        [_bottomLabel setTextColor:[UIColor whiteColor]];
        _bottomLabel.text = @"0";
    }
    return _bottomLabel;
}

- (UIImageView *)selectedLine {
    if (!_selectedLine) {
        _selectedLine = [[UIImageView alloc]initWithImage:nil];
        _selectedLine.backgroundColor = [UIColor redColor];
    }
    return _selectedLine;
}

@end


@interface EGPersonalOptionView()

/*作品按钮*/
@property (strong, nonatomic)GDUDoubleTitleButton *worksButton;

/*关注按钮*/
@property (strong, nonatomic)GDUDoubleTitleButton *focusButton;

/*粉丝按钮*/
@property (strong, nonatomic)GDUDoubleTitleButton *fansButton;

/*选中按钮*/
@property (weak, nonatomic)GDUDoubleTitleButton *selectedButton;

/**底部分割线*/
@property (strong, nonatomic)UIImageView *bottomSeperator;

@end

@implementation EGPersonalOptionView

- (void)setDefaultIndex:(NSInteger)index {
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

- (void)setTitleColor:(UIColor *)titleColor {
    self.worksButton.topLabel.textColor = titleColor;
    self.fansButton.topLabel.textColor = titleColor;
    self.focusButton.topLabel.textColor = titleColor;
}

- (void)setSubTitleColor:(UIColor *)subTitleColor {
    self.worksButton.bottomLabel.textColor = subTitleColor;
    self.fansButton.bottomLabel.textColor = subTitleColor;
    self.focusButton.bottomLabel.textColor = subTitleColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self addSubview:self.worksButton];
    [self addSubview:self.focusButton];
    [self addSubview:self.fansButton];
    [self addSubview:self.bottomSeperator];
}

- (void)layoutSubviews {
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

- (void)setSelectedButton:(GDUDoubleTitleButton *)selectedButton {
    _selectedButton.selected = NO;
    _selectedButton = selectedButton;
    _selectedButton.selected = YES;
}

- (void)setWorkNumber:(NSString *)workNumber {
    _workNumber = workNumber;
    self.worksButton.topTitle = workNumber;
}

- (void)setFocusNumber:(NSString *)focusNumber {
    _focusNumber = focusNumber;
    self.focusButton.topTitle = focusNumber;
}

- (void)setFansNumber:(NSString *)fansNumber {
    _fansNumber = fansNumber;
    self.fansButton.topTitle = fansNumber;
}

#pragma mark - lazy

- (GDUDoubleTitleButton *)worksButton
{
    if (!_worksButton) {
        _worksButton = [GDUDoubleTitleButton buttonWithType:UIButtonTypeCustom];
        _worksButton.topTitle = @"0";
        _worksButton.bottomTitle = @"作品";
        [_worksButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9"] forState:UIControlStateNormal];
        [_worksButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9" alpha:.8] forState:UIControlStateSelected];
        [_worksButton addTarget:self action:@selector(optionViewUserClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _worksButton;
}

- (GDUDoubleTitleButton *)focusButton
{
    if (!_focusButton) {
        _focusButton = [GDUDoubleTitleButton buttonWithType:UIButtonTypeCustom];
        _focusButton.topTitle = @"0";
        _focusButton.bottomTitle = @"关注";
        [_focusButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9"] forState:UIControlStateNormal];
        [_focusButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9" alpha:.8] forState:UIControlStateSelected];
        [_focusButton addTarget:self action:@selector(optionViewUserClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focusButton;
}

- (GDUDoubleTitleButton *)fansButton
{
    if (!_fansButton) {
        _fansButton = [GDUDoubleTitleButton buttonWithType:UIButtonTypeCustom];
        _fansButton.topTitle = @"0";
        _fansButton.bottomTitle = @"飞迷";
        [_fansButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9"] forState:UIControlStateNormal];
        [_fansButton setTitleColor:[UIColor colorWithHexString:@"a8a8a9" alpha:.8] forState:UIControlStateSelected];
        [_fansButton addTarget:self action:@selector(optionViewUserClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fansButton;
}

- (UIImageView *)bottomSeperator {
    if (!_bottomSeperator) {
        _bottomSeperator = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        _bottomSeperator.backgroundColor = [UIColor darkGrayColor];
    }
    return _bottomSeperator;
}

- (void)optionViewUserClickAction:(GDUDoubleTitleButton *)sender {
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

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT + OPTION_VIEW_HEIGHT - NAV_HEIGHT * 2)
#define IMAGE_HEIGHT 220
#define NAV_HEIGHT 64
#define OPTION_VIEW_HEIGHT 65

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

- (UIImageView*)findHairlineImageViewUnder:(UIView*)view {
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return(UIImageView*)view;
    }
    
     for(UIView*subview in view.subviews) {
         UIImageView*imageView = [self findHairlineImageViewUnder:subview];
         if(imageView)  return imageView;
    }
    return nil;
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.optionsView setDefaultIndex:0];
    self.navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
      {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        self.title = @"HELLO";
        [self.optionsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(NAVIGATION_BAR_HEIGHT);
        }];
        
        [self.optionsView setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self.optionsView setSubTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self.optionsView setBackgroundColor:[[UIColor colorWithHexString:@"f7f7f7"] colorWithAlphaComponent:alpha]];
        
      }
    else
      {
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
        self.title = @"";
      }
}

#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row + 1];
    cell.textLabel.text = str;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor orangeColor];
    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
    vc.title = str;
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
    
}

@end
