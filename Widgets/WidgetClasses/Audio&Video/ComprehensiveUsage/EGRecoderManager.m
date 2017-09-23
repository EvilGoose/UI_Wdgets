//
//  EGRecoderManager.m
//  Widgets
//
//  Created by EG on 2017/9/23.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGRecoderManager.h"

@implementation EGRecoderManager

- (instancetype)init {
    if (self = [super init]) {
//        __weak typeof(self) weakSelf = self;
        __block id weakSelf = self;
        void (^deviceConnectedBlock)(NSNotification *) = ^(NSNotification *notification) {
            AVCaptureDevice *device = [notification object];
            BOOL sessionHasDeviceWithMatchingMediaType = NO;
            NSString *deviceMediaType = nil;
            if ([device hasMediaType:AVMediaTypeAudio]) {
                deviceMediaType = AVMediaTypeAudio;
            }
            
            if (deviceMediaType != nil) {
                for (AVCaptureDeviceInput *input in [self.session inputs]) {
                    if ([input.device hasMediaType:deviceMediaType]) {
                        sessionHasDeviceWithMatchingMediaType = YES;
                        break;
                    }
                }
                if (!sessionHasDeviceWithMatchingMediaType) {
                    NSError *error;
                    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
                    if ([self.session canAddInput:input]) {
                        [self.session addInput:input];
                    }
                }
            }
            
            if ([self.delegate respondsToSelector:@selector(recordManagerDeviceConfigureationChanged:)]) {
                [self.delegate recordManagerDeviceConfigureationChanged:self];
            }
            
            
            void(^deviceDisconnectedBlock)(NSNotification *) = ^(NSNotification *notification){
                AVCaptureDevice *device = [notification object];
                if ([device hasMediaType:AVMediaTypeAudio]) {
                    [self.session removeInput:[weakSelf audioInput]];
                    [weakSelf setAudioInput:nil];
                }else if ([device hasMediaType:AVMediaTypeVideo]) {
                    [self.session removeInput:[weakSelf videoInput]];
                    [weakSelf setVideoInput:Nil];
                }
                
                if ([self.delegate respondsToSelector:@selector(recordManagerDeviceConfigureationChanged:)]) {
                    [self.delegate recordManagerDeviceConfigureationChanged:self];
                }
                
            };
            
        
            NSNotificationCenter *notificationCelter = [NSNotificationCenter defaultCenter];
            
            [self setDeviceConnectedObserver:[notificationCelter addObserverForName:AVCaptureDeviceWasConnectedNotification object:nil queue:nil usingBlock:deviceConnectedBlock]];
            [self setDeviceConnectedObserver:[notificationCelter addObserverForName:AVCaptureDeviceWasDisconnectedNotification object:nil queue:nil usingBlock:deviceDisconnectedBlock]];
            [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
            [notificationCelter addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
            self.orientation = AVCaptureVideoOrientationPortrait;
            
        };
        
        
    }
    return self;
}

- (void)deviceOrientationDidChange {
    
}

@end

@implementation EGRecoderManager (internalUtility)



@end
