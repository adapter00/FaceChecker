//
//  AppDelegate.h
//  Face
//
//  Created by takao maeda on 2012/11/24.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StartViewController;
@class MainTabViewController;
@class GraghViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainTabViewController *tabController; 
@property (strong, nonatomic) StartViewController *startController;
@property (strong, nonatomic) GraghViewController *graghController;

@end
