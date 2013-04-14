//
//  MainTabViewController.m
//  Face
//
//  Created by 前田 恭男 on 13/01/23.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//

#import "MainTabViewController.h"
#import "StartViewController.h"
#import "GraghViewController.h"
#import "CameraViewController.h"
#import "HowToViewXController.h"
#import "HealthKnowledgeViewController.h"


@interface MainTabViewController (){
    UIButton *cameraButton;
    HeathCheckCameraViewController *_cameraController;
}

@end

@implementation MainTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //タブの初期化
    [super viewDidLoad];
    self.delegate = self;
    [self initializeCustomTab];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//カスタムタブを作成する
-(void)initializeCustomTab{
    StartViewController *_startController=[[StartViewController alloc] initWithNibName:@"MainView" bundle:nil];
    GraghViewController *_graghController=[[GraghViewController alloc] initWithNibName:@"GraghViewController" bundle:nil];
    _cameraController=[[HeathCheckCameraViewController alloc] initWithNibName:nil bundle:nil];
    HowToViewXController *howViewController=[[HowToViewXController alloc] initWithNibName:@"HowToViewXController" bundle:nil];
    HealthKnowledgeViewController *_healthKnowledgeViewController=[[HealthKnowledgeViewController alloc] initWithNibName:@"HealthKnowledgeViewController" bundle:nil];


    
    _startController.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"START" image:nil tag:2];
    _cameraController.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"camera" image:[UIImage imageNamed:nil] tag:0];
    howViewController.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"HOW TO" image:nil tag:1];
    _graghController.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"GRAPH" image:nil tag:4];
     _healthKnowledgeViewController.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"KNOWLEDGE" image:nil tag:3];

    NSArray *views=[NSArray arrayWithObjects:_startController,_graghController,_cameraController,howViewController,_healthKnowledgeViewController, nil];
    self.viewControllers=views;
    cameraButton=[self createCustomButton];
    [self.view addSubview:cameraButton];
}

-(UIButton *)createCustomButton{    
    UIImage *buttonImage=[UIImage imageNamed:@"camera_button_take.png"];
    UIImage *buttonHigihlightimage=[UIImage imageNamed:@"tabBar_cameraButton_ready_matte.png"];
    cameraButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.autoresizingMask=UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    cameraButton.frame=CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [cameraButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [cameraButton setBackgroundImage:buttonHigihlightimage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference=buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference<0) {
        cameraButton.center=self.tabBar.center;
    }else {
        CGPoint center=self.tabBar.center;
        center.y=center.y - heightDifference/2.0;
        cameraButton.center=center;
    }
    [cameraButton addTarget:self action:@selector(centerButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    return cameraButton;
}

-(void)centerButtonTouch{
    self.selectedIndex=2;
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte.png"] forState:UIControlStateNormal];

}

#pragma MATRK TODO:この遷移はTabではない
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"camera_button_take.png"] forState:UIControlStateNormal];
}

@end
