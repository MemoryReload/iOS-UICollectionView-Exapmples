//
//  AppDelegate.m
//  LayoutTransition
//
//  Created by 何平 on 2020/5/18.
//  Copyright © 2020 cn.com.kuwo. All rights reserved.
//

#import "AppDelegate.h"
#import "AFPrimaryViewController.h"
#import "AFPrimaryLayout.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    AFPrimaryLayout* primaryLayout = [[AFPrimaryLayout alloc] init];
    AFPrimaryViewController* collectionVC = [[AFPrimaryViewController alloc] initWithCollectionViewLayout:primaryLayout];
    UIViewController* rootVC = [[UINavigationController alloc] initWithRootViewController:collectionVC];
    
    self.mainWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.mainWindow.rootViewController = rootVC;
    [self.mainWindow makeKeyAndVisible];
    
    return YES;
}
@end
