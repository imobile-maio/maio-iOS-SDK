//
//  AppDelegate.m
//  MaioSample
//
//  Copyright (c) 2015年 maio. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/// maio から発行されるメディアIDに差し替えてください。
NSString * const MAIO_MEDIA_ID = @"DemoPublisherMedia";


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // ログ表示
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    [viewController appendLog:@"[Maio startWithMediaId:delegate:]"];
    
    // 広告の配信テスト設定を行います。アプリをリリースする際にはコメントアウトして下さい。
    [Maio setAdTestMode:YES];
    
    // SDK のセットアップを開始します。
    [Maio startWithMediaId:MAIO_MEDIA_ID delegate:viewController];
    
    return YES;
}

@end
