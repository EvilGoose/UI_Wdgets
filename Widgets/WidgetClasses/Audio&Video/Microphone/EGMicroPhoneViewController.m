
    //
//  EGMicroPhoneViewController.m
//  Widgets
//
//  Created by EG on 2017/8/28.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGMicroPhoneViewController.h"
#import "EGMicroPhoneHelper.h"


# define COUNTDOWN 60

@interface EGMicroPhoneViewController (){
    NSTimer *_timer; //定时器
    NSInteger countDown;  //倒计时
    NSString *filePath;
}

@property (strong, nonatomic)AVAudioRecorder *recorder;//录音器

@property (strong, nonatomic)AVAudioPlayer *player; //播放器

@property (strong, nonatomic)NSURL *recordFileUrl; //文件地址

/**播放*/
@property (strong, nonatomic)UIButton *playButton;

/*提示*/
@property (strong, nonatomic)UILabel *noticeLabel;

/**Mark*/
@property (assign, nonatomic, getter=isRecord)BOOL record;

@end

@implementation EGMicroPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"等待...";
    countDown = 60;

    [self.view addSubview:self.playButton];
    [self.view addSubview:self.noticeLabel];
}

- (void)touchesBegan:(NSSet<UITouch *>  *)touches withEvent:(UIEvent *)event {
     [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (!granted) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:@"未授权使用麦克风" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:confirm];
            [self presentViewController:alert animated:YES completion:nil];
        }else {
            self.record = !self.record;
        }
    }];
}

- (void)setRecord:(BOOL)record {
    _record = record;
    if (record) {
        self.title = @"开始录音";
        self.view.backgroundColor = [UIColor grayColor];
        [self addTimer];
        [[EGMicroPhoneHelper sharedInstanceEGMicroPhoneHelper] startRecordToPath:
         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
          stringByAppendingString:@"/voiceRecord.wav"]];
        
        
//  demo2      [self startRecord];
    }else {
        self.title = @"停止录音";
        self.view.backgroundColor = [UIColor greenColor];
        countDown = 60;
        [self removeTimer];
        [[EGMicroPhoneHelper sharedInstanceEGMicroPhoneHelper] finishRecord];
        
        
//      demo2        [self stopRecord];
    }
}


/**
 * 添加定时器
 */
- (void)addTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshLabelText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 * 刷新状态展示
 */
-(void)refreshLabelText {
    countDown --;
    _noticeLabel.text = [NSString stringWithFormat:@"还剩 %ld 秒",(long)countDown];
}

/**
 * 移除定时器
 */
- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

/*未抽取
 demo2      
- (void)startRecord {
    [self addTimer];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if (session == nil) {
        
        NSLog(@"Error creating session: %@",[sessionError description]);
        
    }else{
        [session setActive:YES error:nil];
        
    }
    
        //1.获取沙盒地址
    filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:@"/voiceRecord.wav"];
    
        //2.获取文件路径
    self.recordFileUrl = [NSURL fileURLWithPath:filePath];
    
        //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
    
    if (_recorder) {
        
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self stopRecord];
        });
        
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
}

- (void)stopRecord {
    [self removeTimer];
 
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        _noticeLabel.text = [NSString stringWithFormat:@"录了 %ld 秒,文件大小为 %.2fKb",COUNTDOWN - (long)countDown,[[manager attributesOfItemAtPath:filePath error:nil] fileSize]/1024.0];
    }else{
        _noticeLabel.text = @"最多录60秒";
    }
}

- (void)playRecord {
//    [self.recorder stop];
//    
//    if ([self.player isPlaying]) return;
//
//    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:nil];
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [self.player play];
//    NSLog(@"%li",self.player.data.length/1024);
    [[EGMicroPhoneHelper sharedInstanceEGMicroPhoneHelper] playRecorder:
     [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
      stringByAppendingString:@"/voiceRecord.wav"]];
}
*/


#pragma mark - lazy subviews

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setBackgroundColor:[UIColor blackColor]];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playRecord) forControlEvents:UIControlEventTouchUpInside];
        _playButton.frame = CGRectMake(10, 70, 100, 40);
    }
    return _playButton;
}

- (void)playRecord {
    self.title = @"播放录音";
    [[EGMicroPhoneHelper sharedInstanceEGMicroPhoneHelper] playRecorder:
     [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
      stringByAppendingString:@"/voiceRecord.wav"]];
}

- (UILabel *)noticeLabel {
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH - 20, 40)];
        [_noticeLabel setTextColor:[UIColor whiteColor]];
        [_noticeLabel setBackgroundColor:[UIColor blackColor]];
    }
    return _noticeLabel;
}

@end
