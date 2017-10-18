//
//  EGAVPlayerViewController.m
//  Widgets
//
//  Created by FangViee on 2017/10/18.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import "EGAVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface EGAVPlayerViewController ()

/**播放器*/
@property(strong,nonatomic) AVPlayer *player;

/**播放器展示*/
@property(strong,nonatomic) AVPlayerLayer *playerLayer;

/**视频*/
@property (nonatomic , strong) NSURL *localMovieURL;

@end

@implementation EGAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view.layer addSublayer:self.playerLayer];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationEnterBackground)
                                                 name: UIApplicationDidEnterBackgroundNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackFinished)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.player.currentItem];
}


-(void)playbackFinished {
        // 播放完成后重复播放
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player play];
}

- (void)applicationBecomeActive {
    [self.player play];
}

- (void)applicationEnterBackground {
    [self.player pause];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.player.currentItem];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player play];
}

- (AVPlayer *)player {
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:[[AVPlayerItem alloc] initWithURL:self.localMovieURL]];
    }
    return _player;
}

- (AVPlayerLayer *)playerLayer {
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _playerLayer.frame = SCREEN_BOUNDS;
        _playerLayer.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _playerLayer;
}


-(NSURL *)localMovieURL {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"video_welcome" ofType:@"mp4"];
    if (path) {
        return [NSURL fileURLWithPath:path];
    }else {
        return nil;
    }
}

@end
