//
//  cameraViewController.h
//  Face
//
//  Created by 前田 恭男 on 13/01/23.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import "CameraView.h"

@interface HeathCheckCameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>

@property  UIImagePickerController *imagePicker;
@property (nonatomic ,retain)CameraView *cameraView;


@end
