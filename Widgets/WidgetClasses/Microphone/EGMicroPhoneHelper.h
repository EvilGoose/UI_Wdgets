//
//  EGMicroPhoneHelper.h
//  Widgets
//
//  Created by EG on 2017/8/28.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface EGMicroPhoneHelper : NSObject

/**recordFileUrl*/
@property (copy, nonatomic)NSURL *recordFileUrl;

SINGLETON_INTERFACE(EGMicroPhoneHelper)

- (void)startRecordToPath:(NSString *)path;

- (void)pauseRecord;

- (void)finishRecord;

- (void)playRecorder:(NSString *)URLString;

@end
