//
//  EGTableViewController.h
//  Widgets
//
//  Created by EG on 2017/9/15.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGBasicViewController.h"

@interface EGTableViewController : EGBasicViewController

/**data*/
@property (nonatomic, strong)NSArray *datasArray;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data;

@end
