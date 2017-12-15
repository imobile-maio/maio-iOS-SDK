![](https://github.com/imobile-maio/maio-iOS-SDK/blob/wiki/doc/images/logo.png)

# maio iOS SDK
- Version: 1.2.18
- Released: 2017/11/01
- Supported: iOS 6.0+

## What is maio?
[maio](https://maio.jp/) はこれまでのバナー広告に加え、新たな広告収益の機会を得ることが可能な動画広告プラットフォームです。
バナー広告と違い、デベロッパーの設定したタイミングで、動画広告をコンテンツの一部として配信することができます。

また、動画広告再生後にアプリ内通貨やライフ等の報酬（リワード）をユーザーに還元する事で、動画広告の再生数が増加し、収益の最大化が見込めます。
今までユーザーが離脱していたポイントに `動画広告 + リワード` を入れる事で、ユーザーのストレスを解消しアクティブ率を向上させる事も可能です。


## Quick Start

### maio SDKの導入

[CocoaPods](https://guides.cocoapods.org/using/getting-started.html#toc_3)を用いた導入方法となります。

maioを導入したいプロジェクトの階層に`Podfile`を作成します。

```sh
cd path/to/project # `(導入したいプロジェクト).xcodeproj`のあるディレクトリに移動します
pod init
```

生成されたPodfileを開き、以下の内容を導入したいアプリのtargetに追加します。

```ruby
pod 'MaioSDK'
```

追加したら、以下のコマンドを実行します。

```sh
pod install --repo-update
```

### maio SDKの準備

広告を表示するためには、`[Maio startWithMediaId:delegate:]`を呼び出し、MediaIdを渡してセットアップを始める必要があります。
セットアップを始めると、SDKは広告表示に必要なリソースのダウンロードを自動で行います。

この命令は一度実行されれば十分で、なるべく早く呼び出すことがスムーズな広告表示につながります。

```ObjC
// AppDelegate.m

#import <Maio/Maio.h>

@implementation AppDelegate

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {

    // 広告の配信テスト設定を行います。アプリをリリースする際にはコメントアウトしてください。
    [Maio setAdTestMode: YES];

    // maio SDKの初期化を開始します。
    // MAIO_MEDIA_ID は、Maio管理画面より割り当てられたメディアIDに差し替えてください。
    [Maio startWithMediaId: @"MAIO_MEDIA_ID" delegate: nil];
}

@end
```

### maioの表示

動画広告を表示する前に、表示準備が完了しているか確認することをおすすめします。
`[Maio canShow]`は、表示準備が正常に完了したかどうかを示します。


```ObjC
#import <Maio/Maio.h>

@implementation ViewController

- (IBAction) showAd: (UIButton*) sender {
    if ([Maio canShow]) {
        [Maio show];
    }
}

@end
```

## Download
[releases](https://github.com/imobile-maio/maio-iOS-SDK/releases) から最新のリリースバージョンをダウンロードして下さい。

## Get Started
日本語 [wiki/Get-Started](https://github.com/imobile-maio/maio-iOS-SDK/wiki/Get-Started)

English [wiki/Get-Started](https://github.com/imobile-maio/maio-iOS-SDK/wiki/Get-Started-(EN))

## API Reference
日本語 [wiki/API-Reference](https://github.com/imobile-maio/maio-iOS-SDK/wiki/API-Reference)

English [wiki/API-Reference](https://github.com/imobile-maio/maio-iOS-SDK/wiki/API-Reference-(EN))

## FAQ
日本語 [wiki/FAQ](https://github.com/imobile-maio/maio-iOS-SDK/wiki/FAQ)

English [wiki/FAQ](https://github.com/imobile-maio/maio-iOS-SDK/wiki/FAQ-(EN))

## Contact Us
- General
  + https://maio.jp/#contactWrap
- Technical Trouble Shooting
  + https://maio.jp/techsupport/index.html
