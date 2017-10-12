//
//  EGRecoderManager.h
//  Widgets
//
//  Created by EG on 2017/9/23.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class EGRecoderManager,EGRecoder;

@protocol EGRecoderManagerDelegate <NSObject>

@optional

- (void)recordManager:(EGRecoderManager *)recoderManager didFailWithError:(NSError *)error;

- (void)recordManagerRecordingBegin:(EGRecoderManager *)recoderManager;

- (void)recordManagerRecordingFinished:(EGRecoderManager *)recoderManager;

- (void)recordManagerStillImageCapture:(EGRecoderManager *)recoderManager;

- (void)recordManagerDeviceConfigureationChanged:(EGRecoderManager *)recoderManager;

@end

@interface EGRecoderManager : NSObject

/**session*/
@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, assign) AVCaptureVideoOrientation orientation;

/**input*/
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;

@property (nonatomic, strong) AVCaptureDeviceInput *audioInput;

/**output*/
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;

/**recorder*/
@property (nonatomic, strong) EGRecoder *recoder;

/**observer*/
@property (nonatomic, assign) id deviceConnectedObserver;

@property (nonatomic, assign) id deviceDisconnectedObserver;

/**identifier*/
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskIdentifier;

/**delegate*/
@property (nonatomic, weak) id<EGRecoderManagerDelegate> delegate;

- (BOOL) setupSession;

- (void) startRecording;

- (void) stopRecording;

- (void) captureStillImage;

- (BOOL) toggleCamera;

- (NSUInteger) cameraCount;

- (NSUInteger) micCount;

- (void) autoFocusAtPoint:(CGPoint)point;

- (void) continousFocusAtPoint:(CGPoint)point;

@end

@interface EGRecoderManager (internalUtility)

- (AVCaptureDevice *) captureWithPosition:(AVCaptureDevicePosition)position;

- (AVCaptureDevice *) frontCamera;

- (AVCaptureDevice *) backCamera;

- (NSURL *) tempFileURL;

- (void) removeFile:(NSURL *)outputFileURL;

- (void) copyFileToDocuments:(NSURL *)fileURL;

@end

