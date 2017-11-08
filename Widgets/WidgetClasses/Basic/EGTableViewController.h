//
//  EGTableViewController.h
//  Widgets
//
//  Created by EG on 2017/9/15.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGBasicViewController.h"

typedef void(^SelectedFeedBack)(NSIndexPath *);


@interface EGTableViewController : EGBasicViewController

/**data*/
@property (nonatomic, strong)NSArray *datasArray;

/**click feedBack*/
@property (copy,nonatomic) SelectedFeedBack selectedFeedBack;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data;

- (void)reloadData;

@end
