//
//  SongListCell.m
//  AudioDemo
//
//  Created by LiuFeng on 16/1/27.
//  Copyright © 2016年 LiuFeng. All rights reserved.
//

#import "SongListCell.h"
#import <AVFoundation/AVFoundation.h>

@interface SongListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *artWorkImage;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLable;
@property (weak, nonatomic) IBOutlet UILabel *musicNameLable;
@end
@implementation SongListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setValueForMusicPath:(NSString *)musicPath{
    NSMutableDictionary *retDic = [[NSMutableDictionary alloc] init];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    
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
    self.albumLable.text = [NSString stringWithFormat:@"专辑 - %@",[retDic objectForKey:@"albumName"]];
    self.musicNameLable.text = [retDic objectForKey:@"title"];
    self.artWorkImage.image = [UIImage imageWithData:[retDic objectForKey:@"artwork"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
