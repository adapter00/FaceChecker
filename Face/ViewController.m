//
//  ViewController.m
//  Sample2
//
//  Created by 前田 恭男 on 12/11/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ViewBuilder.h"
#import "View.h"
#import "PhotoColorLogic.h"

@interface ViewController (){
    CIImage *ciImage;
    UIImageView *imageView;
    UIImage *resizeImage;
}

@end



@implementation ViewController


@synthesize imagePicker;



#pragma mark LifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
    [self initialize];
}

-(void)initialize{
    imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate=self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)button:(id)sender {
    [self presentModalViewController:imagePicker animated:YES];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *originalImage=(UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    resizeImage=[ViewBuilder resizeImage:originalImage];
    imageView=[ViewBuilder createImageView:resizeImage];
    [self.view addSubview:imageView];
    [self createFacefeature];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [imageView removeFromSuperview];
    imageView=nil;
}


#pragma mark ImageLogic
//画像の顔検出
-(void)createFacefeature{
    NSDictionary *options=[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector *detector=[CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
    ciImage=[[CIImage alloc] initWithCGImage:resizeImage.CGImage];
    NSArray *array=[detector featuresInImage:ciImage];
    
    for (CIFaceFeature *faceFeature in array) {
        [self PartsOfFace:faceFeature];
    }
}

-(void)PartsOfFace :(CIFaceFeature *)faceFeature{
    if (faceFeature.hasLeftEyePosition&&faceFeature.hasMouthPosition&&faceFeature.hasRightEyePosition) {
        
        
#pragma mark TODO:メソッドを外出しできるように
        //アフィン関数を使用して画像の向きを変化させる
        CGAffineTransform transform=[self transformPosition:faceFeature];
        const CGPoint mouthPos=CGPointApplyAffineTransform(faceFeature.mouthPosition, transform);
        const CGPoint righteye=CGPointApplyAffineTransform(faceFeature.rightEyePosition, transform);
        const CGPoint leftEye=CGPointApplyAffineTransform(faceFeature.leftEyePosition, transform);
        const CGPoint face=CGPointApplyAffineTransform(faceFeature.bounds.origin,transform);
        
        //各部位に赤点をつける　開発用
        [self pointAtPosition:mouthPos];
        [self pointAtPosition:righteye];
        [self pointAtPosition:leftEye];
        
        PhotoColorLogic *pLogic=[[PhotoColorLogic alloc] init];
        int a=[pLogic calColorAve:mouthPos stop:leftEye image:resizeImage];
        NSLog(@"HealthStatus :%d",a);
    }
}


-(CGAffineTransform)transformPosition:(CIFaceFeature *)faceFeature{
    CGAffineTransform transform=CGAffineTransformMakeScale(1, -1);
    transform=CGAffineTransformTranslate(transform, 0, -imageView.bounds.size.height);
    return transform;
}


#pragma mark TODO:各部位に赤点をつける　開発用なので消しておく
-(void)pointAtPosition:(CGPoint)atPoint{
    View *view=[[View alloc] initWithFrame:CGRectMake(atPoint.x, atPoint.y, 10, 10)];
    [imageView addSubview:view];
}
@end