//
//  AppDelegate.m
//  News
//
//  Created by 国栋 on 16/2/19.
//  Copyright © 2016年 GD. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsViewController.h"
#import "StartViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window=[UIWindow new];
    self.window.rootViewController=[StartViewController new];
    [self.window makeKeyAndVisible];
    
//    UITabBarController *mainTab=[UITabBarController new];
//    self.window.rootViewController=mainTab;
//    
//    NewsViewController *news=[NewsViewController new];
//    news.title=@"新闻";
//    news.tabBarItem.image=[UIImage imageNamed:@"news"];
//    UINavigationController *navi1=[[UINavigationController alloc]initWithRootViewController:news];
//    [mainTab addChildViewController:navi1];
//    
//    AddViewController *add=[AddViewController new];
//    add.title=@"创建";
//    add.tabBarItem.image=[UIImage imageNamed:@"null"];
//    UINavigationController *navi2=[[UINavigationController alloc]initWithRootViewController:add];
//    [mainTab addChildViewController:navi2];
//    
//    SetViewController *set=[SetViewController new];
//    set.title=@"设置";
//    set.tabBarItem.image=[UIImage imageNamed:@"set"];
//    UINavigationController *navi3=[[UINavigationController alloc]initWithRootViewController:set];
//    [mainTab addChildViewController:navi3];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
