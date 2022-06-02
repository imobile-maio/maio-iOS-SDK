![](https://github.com/imobile-maio/maio-iOS-SDK/blob/wiki/doc/images/logo.png)

# maio iOS SDK
- Version: 1.6.2
- Released: 2022/06/02
- Supported: iOS 9.0+ (Xcode 13.0+)

## What is maio?
[maio](https://maio.jp/) はこれまでのバナー広告に加え、新たな広告収益の機会を得ることが可能な動画広告プラットフォームです。
バナー広告と違い、デベロッパーの設定したタイミングで、動画広告をコンテンツの一部として配信することができます。

また、動画広告再生後にアプリ内通貨やライフ等の報酬（リワード）をユーザーに還元する事で、動画広告の再生数が増加し、収益の最大化が見込めます。
今までユーザーが離脱していたポイントに `動画広告 + リワード` を入れる事で、ユーザーのストレスを解消しアクティブ率を向上させる事も可能です。

## SKAdNetworkID
アプリのinfo.plistファイルに追加してください。

```
<key>SKAdNetworkItems</key>
<array>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v4nxqhlyqp.skadnetwork</string>
    </dict>
</array>
```

## Quick Start


### maio SDKの取得

maioを導入したいプロジェクトの`Podfile`に、以下の内容を追加します。

```ruby
pod 'MaioSDK'
```


### maio SDKの準備

`[Maio startWithMediaId:delegate:]`を呼び出し、maio SDKの初期化を開始します。

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

`[Maio canShow]`で、表示準備が完了したか確認し、`[Maio showWithViewController:]`で表示します。

```ObjC
#import <Maio/Maio.h>

@implementation ViewController

- (IBAction) showAd: (UIButton*) sender {
    if ([Maio canShow]) {
        [Maio showWithViewController:self];
    }
}

@end
```

## Manual Download
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

 ## 収集しているデータについて

 <br />


|連絡先情報|収集有無|	使用目的|トラッキングでの利用|
 |--- |--- |--- |--- |
|**名前** <br /> 姓や名など| -| -| -|
|**Eメールアドレス** <br />ハッシュ化されたEメールアドレスを含むが、これに限定しない| -| -| -|
|**電話番号**  <br />ハッシュ化された電話番号を含むが、これに限定しない| -| -| -|
|**所在地**  <br />自宅住所、物理的な住所、郵送先住所など| -| -| -|
|**ユーザのその他の連絡先情報**  <br /> 自宅または所在地| -| -| -|
| | | | |

|健康とフィットネス|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**健康** <br />ヘルスケアおよび医療関連のデータ -  <br />Clinical Health Records API、<br />HealthKit API、MovementDisorderAPI、<br />ヘルスケア関連の臨床調査、<br /> またはユーザーが提供したその他の<br />ヘルスケアまたは医療のデータを含むが、これらに限定しない| -| -| -|
|**フィットネス** <br />フィットネスおよび運動データ -<br /> Motion APIおよびFitness APIを含むがこれらに限定しない | -| -| -|
| | | | |

|財務情報|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**支払い情報** <br />支払い方法、支払いカード番号、<br />銀行口座番号など。Appが支払いサービスを利用している場合は、<br />支払い情報はApp外で入力され、<br />あなた（デベロッパ）<br />は支払い情報にアクセスできません。<br />その場合、データは収集されないため、<br />申告する必要はありません。| -| -| -|
|**クレジット情報** <br />クレジットスコアなど| -| -| -|
|**その他の財務情報** <br />給与、収入、資産、負債、その他の財務情報など| -| -| -|
| | | | |

|位置情報|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**詳細な位置情報** <br /> 小数点以下3桁以上の緯度経度と同等、またはそれよりも高い詳細レベルでの、<br />ユーザーまたはデバイスの場所を示す情報 | -| -| -|
|**おおよその場所** <br /> 小数点以下3桁以上の緯度経度よりも低い<br />詳細レベルでのユーザー<br />またはデバイスの場所を示す情報<br />（おおよその位置情報サービスなど）| -| -| -|
| | | | |

|機密情報|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**機密情報** <br />人種または民族情報、性的指向、<br />妊娠または出産に関する情報、障がい、<br />宗教または哲学的信念、<br />労働組合への加入、政治的意見、遺伝情報、または生体情報など| -| -| -|
| | | | |

|連絡先|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**連絡先** <br />ユーザーの電話、アドレス帳、ソーシャルグラフ内の連絡先リストなど| -| -| -|
| | | | |

|ユーザーコンテンツ|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**Eメールまたはテキストメッセージ** <br />Eメールまたはメッセージの件名、送信者、受信者、および内容を含む| -| -| -|
|**写真またはビデオ** <br />ユーザーの写真またはビデオ| -| -| -|
|**オーディオデータ** <br />ユーザーの声またはサウンドの録音| -| -| -|
|**ゲームプレイコンテンツ** <br />ゲーム内でユーザーが生成したコンテンツなど| -| -| -|
|**カスタマーサポート** <br />カスタマーサポートの依頼中にユーザーが生成したデータ|| -| -|-|
|**その他のユーザーコンテンツ** <br />ユーザーが生成したその他のコンテンツ| -| -| -|
| | | | |

|閲覧履歴|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**閲覧履歴** <br /> ユーザーが閲覧したコンテンツに関する情報| -| -| -|
| | | | |

|検索履歴|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**検索履歴** <br />ユーザーが実行した検索に関する情報| -| -| -|
| | | | |

|ID|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**ユーザーID** <br />スクリーン名、ハンドル、アカウントID、<br />割り当てられたユーザーID、顧客番号、<br />特定のユーザーやアカウント<br />の識別に利用できるユーザーレベルやアカウント<br />レベルのその他のIDなど| -| -| -|
|**デバイスID** <br />デバイスの広告ID、またはデバイスレベルのその他のIDなど| ✓| サードパーティ広告<br />アナリティクス| あり|
| | | | |

|購入|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**購入履歴** <br />アカウントや個人による購入、または購入傾向| -| -| -|
| | | | |

|使用状況データ|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**製品の操作** <br />Appの起動、タップ、クリック、スクロール情報、<br />音楽の視聴データ、<br />ビデオの視聴数、ゲームやビデオや曲の保存場所、<br />ユーザーのApp操作に関するその他の情報など| -| -| -|
|**広告データ** <br />ユーザーが見た広告に関する情報など| ✓| サードパーティ広告<br />アナリティクス| あり|
|**その他の使用状況データ** <br />Appのユーザーアクティビティに関するその他のデータ| -| -| -|
| | | | |

|診断|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**クラッシュデータ** <br />クラッシュログなど| -| -| -|
|**パフォーマンスデータ** <br />起動時間、ハング率、エネルギー使用量など| -| -| -|
|**その他の診断データ** <br />Appに関連する技術的診断を測定する<br />目的で収集されたその他のデータ| -| -| -|
| | | | |

|その他のデータ|収集有無|	使用目的|トラッキングでの利用|
|--- |--- |--- |--- |
|**その他の種類のデータ** <br />言及されていないその他の種類のデータ| ✓| サードパーティ広告アナリティクス| あり|
| | | | |

<br />

## 収集したデータの個人情報への関連付け
収集したデータの個人情報への関連付けを行なっていない。
