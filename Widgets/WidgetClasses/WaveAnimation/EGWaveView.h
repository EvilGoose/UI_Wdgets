//
//  EGWaveView.h
//  Widgets
//
//  Created by EG on 2017/8/28.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DrawActionTypeNone,
    DrawActionTypeSin,
    DrawActionTypeCos,
    DrawActionTypeMutPath
} DrawActionType;

@interface EGWaveView : UIView

/**type*/
@property (assign, nonatomic)DrawActionType type;

@end
