//
//  AppDelegate.m
//  Face
//
//  Created by takao maeda on 2012/11/24.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabViewController.h"
#import "StartViewController.h"
#import "GraghViewController.h"
#import "CameraViewController.h"

@implementation AppDelegate

@synthesize tabController=_tabController;
@synthesize startController=_startController;
@synthesize graghController=_graghController;
@synthesize cameraController=_cameraController;
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    _tabController=[[MainTabViewController alloc] initWithNibName:nil bundle:nil];
    _startController=[[StartViewController alloc] initWithNibName:@"MainView" bundle:nil];
    _graghController=[[GraghViewController alloc] initWithNibName:@"GraghViewController" bundle:nil];
    _cameraController=[[CameraViewController alloc] initWithNibName:nil bundle:nil];
    NSArray *views=[NSArray arrayWithObjects:_startController,_cameraController,_graghController, nil];
    _tabController.viewControllers=views;
    
    //各バッチを設定
    
    self.window.rootViewController = _tabController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
