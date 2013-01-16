//
//  ViewController.h
//  Sample2
//
//  Created by 前田 恭男 on 12/11/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>

@interface StartViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>

- (IBAction)cameraButton:(id)sender;

@property (strong, nonatomic) IBOutlet UINavigationBar *titleBar;
- (IBAction)photoLibraryButton:(id)sender;
@property  UIImagePickerController *imagePicker;
@end
