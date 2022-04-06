//
//  AppDelegate.m
//  WechatSimilarBubbleMenu
//
//  Created by JackYoung on 2022/4/6.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor blueColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    _window.rootViewController = nav;
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
