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




@interface MainTabViewController (){
    UIButton *cameraButton;
    CameraViewController *_cameraController;
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
    _cameraController=[[CameraViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *controller1=[[UIViewController alloc] init];
    UIViewController *controller2=[[UIViewController alloc] init];
    _cameraController.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"camera" image:[UIImage imageNamed:nil] tag:0];
    NSArray *views=[NSArray arrayWithObjects:_startController,_graghController,_cameraController,controller1,controller2, nil];
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
}


#pragma MATRK TODO:この遷移はTabではない
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"selectedView :%@",viewController.description);
    if(viewController==_cameraController){
        NSLog(@"check");
        [cameraButton setBackgroundImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte.png"] forState:UIControlStateNormal];
    }else{
        [cameraButton setBackgroundImage:[UIImage imageNamed:@"camera_button_take.png"] forState:UIControlStateNormal];
    }
}

@end
