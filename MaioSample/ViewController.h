//
//  ViewController.h
//  MaioSample
//
//  Copyright (c) 2015年 maio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Maio/Maio.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <MaioDelegate, AVAudioPlayerDelegate>

/// SDK のセットアップ開始日時
@property (nonatomic) NSDate *startDate;

/// 表示ログに追記します。
- (void)appendLog:(NSString *)log;


@property (nonatomic) AVAudioPlayer *audioPlayer;

@end

