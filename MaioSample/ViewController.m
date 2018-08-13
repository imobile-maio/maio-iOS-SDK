//
//  ViewController.m
//  MaioSample
//
//  Copyright (c) 2015年 maio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSMutableArray *_outputs;
}
@property (weak, nonatomic) IBOutlet UIButton *openAd;
@property (weak, nonatomic) IBOutlet UIButton *openSkippableAd;
@property (weak, nonatomic) IBOutlet UIButton *openPlayableAd;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;
@end

@implementation ViewController

NSString * const MAIO_ZONE_ID = @"DemoPublisherZone";
NSString * const MAIO_SKIPPABLE_ZONE_ID = @"DemoPublisherZoneSkippable";
NSString * const MAIO_PLAYABLE_ZONE_ID = @"DemoPublisherZonePlayableForiOS";

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // ログリストの初期化
        _outputs = [NSMutableArray new];
        [self appendLog:[NSString stringWithFormat:@"version %@", [Maio sdkVersion]]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // ログラベルを更新
    [self updateLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  動画広告の再生を開始するイベントハンドラ
 */
- (IBAction)onOpenAd:(id)sender {
    // 動画広告を表示
    if ([Maio canShowAtZoneId:MAIO_ZONE_ID]) {
        [Maio showAtZoneId:MAIO_ZONE_ID];
    }
}

- (IBAction)onOpenSkippableAd:(id)sender {
    // 動画広告を表示
    if ([Maio canShowAtZoneId:MAIO_SKIPPABLE_ZONE_ID]) {
        [Maio showAtZoneId:MAIO_SKIPPABLE_ZONE_ID];
    }
}

- (IBAction)onOpenPlayableAd:(id)sender {
    // 動画広告を表示
    if ([Maio canShowAtZoneId:MAIO_PLAYABLE_ZONE_ID]) {
        [Maio showAtZoneId:MAIO_PLAYABLE_ZONE_ID];
    }
}
#pragma mark MaioDelegate

/**
 *  全てのゾーンの広告表示準備が完了したら呼ばれます。
 */
- (void)maioDidInitialize {
    // ログ表示
    [self appendLog:@(__FUNCTION__)];
}

/**
 *  広告の配信可能状態が変更されたら呼ばれます。
 *
 *  @param zoneId   広告の配信可能状態が変更されたゾーンの識別子
 *  @param newValue 変更後のゾーンの状態。YES なら配信可能
 */
- (void)maioDidChangeCanShow:(NSString *)zoneId newValue:(BOOL)newValue {
    // ログ表示
    [self appendLog:[NSString stringWithFormat:@"%@: %@ newValue: %@", @(__FUNCTION__), zoneId, newValue? @"YES": @"NO"]];
    
    // 広告が表示可能ならトリガーを有効化
    if ([zoneId isEqualToString:MAIO_ZONE_ID]) {
        self.openAd.enabled = newValue;
    } else if ([zoneId isEqualToString:MAIO_SKIPPABLE_ZONE_ID]) {
        self.openSkippableAd.enabled = newValue;
    } else if ([zoneId isEqualToString:MAIO_PLAYABLE_ZONE_ID]) {
        self.openPlayableAd.enabled = newValue;
    }
    
}

/**
 *  広告が再生される直前に呼ばれます。
 *  最初の再生開始の直前にのみ呼ばれ、リプレイ再生の直前には呼ばれません。
 *
 *  @param zoneId  広告が表示されるゾーンの識別子
 */
- (void)maioWillStartAd:(NSString *)zoneId {
    // ログ表示
    [self appendLog:[NSString stringWithFormat:@"%@: %@", @(__FUNCTION__), zoneId]];
}

/**
 *  広告の再生が終了したら呼ばれます。
 *  最初の再生終了時にのみ呼ばれ、リプレイ再生の終了時には呼ばれません。
 *
 *  @param zoneId  広告を表示したゾーンの識別子
 *  @param playtime 動画の再生時間（秒）
 *  @param skipped  動画がスキップされていたら YES、それ以外なら NO
 *  @param rewardParam  ゾーンがリワード型に設定されている場合、予め管理画面にて設定してある任意の文字列パラメータが渡されます。それ以外の場合は nil
 */
- (void)maioDidFinishAd:(NSString *)zoneId playtime:(NSInteger)playtime skipped:(BOOL)skipped rewardParam:(NSString *)rewardParam {
    // ログ表示
    [self appendLog:[NSString stringWithFormat:@"%@: %@ playtime: %zd skipped: %@ rewardParam: %@", @(__FUNCTION__), zoneId, playtime, skipped? @"YES": @"NO", rewardParam]];
}

/**
 *  広告がクリックされ、ストアや外部リンクへ遷移した時に呼ばれます。
 *
 *  @param zoneId  広告を表示したゾーンの識別子
 */
- (void)maioDidClickAd:(NSString *)zoneId {
    // ログ表示
    [self appendLog:[NSString stringWithFormat:@"%@: %@", @(__FUNCTION__), zoneId]];
}

/**
 *  広告が閉じられた際に呼ばれます。
 *
 *  @param zoneId  広告を表示したゾーンの識別子
 */
- (void)maioDidCloseAd:(NSString *)zoneId {
    // ログ表示
    [self appendLog:[NSString stringWithFormat:@"%@: %@", @(__FUNCTION__), zoneId]];
    
//    [self.audioPlayer play];
}

/**
 *  SDK でエラーが生じた際に呼ばれます。
 *
 *  @param zoneId  エラーに関連するゾーンの識別子
 *  @param reason   エラーの理由を示す列挙値
 */
- (void)maioDidFail:(NSString *)zoneId reason:(MaioFailReason)reason {
    // ログ表示
    [self appendLog:[NSString stringWithFormat:@"%@: %@ reason: %@", @(__FUNCTION__), zoneId, [self stringFromFailReason:reason]]];
}


#pragma mark - private methods

/**
 *  ログを追加します。
 */
- (void)appendLog:(NSString *)log {
    if (!_startDate) {
        _startDate = [NSDate date];
    }
    [_outputs addObject:[NSString stringWithFormat:@"%.1f: %@", [[NSDate date] timeIntervalSinceDate:_startDate],log]];
    [self updateLabel];
}
/**
 *  出力ラベルを更新します。
 */
- (void)updateLabel {
    if (self.logLabel) {
        self.logLabel.text = [_outputs componentsJoinedByString:@"\n"];
    }
}

/**
 *  MaioFailReason の文字列表記を取得します。
 */
- (NSString *)stringFromFailReason:(MaioFailReason)failReason {
    switch (failReason) {
        case MaioFailReasonUnknown:
            return @"Unknown";
        case MaioFailReasonNetworkConnection:
            return @"NetworkConnection";
        case MaioFailReasonNetworkServer:
            return @"NetworkServer";
        case MaioFailReasonNetworkClient:
            return @"NetworkClient";
        case MaioFailReasonSdk:
            return @"Sdk";
        case MaioFailReasonDownloadCancelled:
            return @"DownloadCancelled";
        case MaioFailReasonAdStockOut:
            return @"AdStockOut";
        case MaioFailReasonVideoPlayback:
            return @"VideoPlayback";
    }
}

@end
