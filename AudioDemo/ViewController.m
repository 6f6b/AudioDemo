//
//  ViewController.m
//  AudioDemo
//
//  Created by LiuFeng on 16/1/27.
//  Copyright © 2016年 LiuFeng. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SongsListController.h"

@interface ViewController ()
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@property (nonatomic,strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIImageView *musicImage;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *musicPaths = [NSBundle pathsForResourcesOfType:@"mp3" inDirectory:[[NSBundle mainBundle] resourcePath]];
    NSLog(@"%@",musicPaths[0]);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSURL *url = [NSURL fileURLWithPath:self.musicPath];
    
    if ([url isEqual:self.audioPlayer.url]) {
        return;
    }
    if (![url isEqual:self.audioPlayer.url]) {
        self.audioPlayer = nil;
        [self playBtn:nil];
        NSLog(@"歌曲切换");
    }
}

- (NSString *)musicPath{
    if (nil == _musicPath) {
        _musicPath = [[NSBundle mainBundle] pathForResource:@"张学友 - 遥远的她.mp3" ofType:nil];
    }
    return _musicPath;
}

- (AVAudioPlayer *)audioPlayer{
    if (nil == _audioPlayer) {
        
        NSMutableDictionary *retDic = [[NSMutableDictionary alloc] init];
        NSURL *url = [NSURL fileURLWithPath:self.musicPath];
        
        //解析MP3文件，获取其中的专辑名、歌手名、歌曲名以及专辑图片
        AVURLAsset *mp3Asset = [AVURLAsset URLAssetWithURL:url options:nil];
        for (NSString *format in [mp3Asset availableMetadataFormats]) {
            NSLog(@"format type = %@",format);
            for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format]) {
                
                if(metadataItem.commonKey)
                    [retDic setObject:metadataItem.value forKey:metadataItem.commonKey];
                
            }
        }
        self.artistLabel.text = [NSString stringWithFormat:@"歌手 - %@",[retDic objectForKey:@"artist"]];
        self.albumLabel.text = [NSString stringWithFormat:@"专辑 - %@",[retDic objectForKey:@"albumName"]];
        self.musicNameLabel.text = [retDic objectForKey:@"title"];
        self.musicImage.image = [UIImage imageWithData:[retDic objectForKey:@"artwork"]];
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [self.audioPlayer prepareToPlay];
    }
    return _audioPlayer;
}


- (NSTimer *)timer{
    if (nil == _timer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
        _timer = timer;
    }
    return _timer;
}

//更新进度条
- (void)dealTimer{
    CGFloat progress = self.audioPlayer.currentTime/self.audioPlayer.duration;
    [self.progress setProgress:progress animated:YES];
    NSLog(@"%@",NSStringFromCGRect(self.progress.frame));
}

//播放/暂停
- (IBAction)playBtn:(id)sender {
    UIButton *button = sender;
    if ([self.audioPlayer isPlaying]) {
        button.selected = NO;
        [self.audioPlayer pause];
        [self.timer setFireDate:[NSDate distantFuture]];
        return;
    }
    if (![self.audioPlayer isPlaying]) {
        button.selected = YES;
        [self.audioPlayer play];
        [self.timer setFireDate:[NSDate distantPast]];
    }
}

//设置播放效果
- (IBAction)dealConfig:(id)sender {
}

//进入歌单选歌
- (IBAction)dealSongs:(id)sender {
    SongsListController *sonsListController = [[SongsListController alloc] init];
    [self presentViewController:sonsListController animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
