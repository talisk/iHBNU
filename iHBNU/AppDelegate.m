//
//  AppDelegate.m
//  iHBNU
//
//  Created by 孙恺 on 15/9/28.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CustomTabbarController.h"

#import "IQKeyboardManager.h"

#import "MainTabBarViewController.h"

#import "HomeViewController.h"
#import "UserViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [IQKeyboardManager sharedManager].enable = true;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LoginViewController *lvc = [[LoginViewController alloc] init];
    
    MainTabBarViewController *tabBarController = [[MainTabBarViewController alloc] init];
    
//    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
//    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] initWithNibName:@"DiscoverViewController" bundle:[NSBundle mainBundle]];
//    UserViewController *userVC = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:[NSBundle mainBundle]];
//    MoreViewController *moreVC = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:[NSBundle mainBundle]];
//    
//    tabBarController.viewControllers = [NSArray arrayWithObjects:homeVC, discoverVC, userVC, moreVC, nil];
    
//    CustomTabbarController *tabbarVC = [[CustomTabbarController alloc] init];
    
//    NewEntryController *controller = [[NewEntryController alloc] initWithNibName:@"NewEntryController" bundle:nil];
//    self.window.rootViewController = [[GKNavigationController alloc] initWithRootViewController:controller];
    
    self.window.rootViewController = lvc;

//    self.window.rootViewController = lvc;
    
    [self.window makeKeyAndVisible];

    
    
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
