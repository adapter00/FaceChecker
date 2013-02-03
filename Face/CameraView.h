//
//  CamaraView.h
//  Face
//
//  Created by takao maeda on 2013/01/31.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <math.h>
#import <QuartzCore/QuartzCore.h>

//カメラ起動中にリアルタイム処理をするView
@class CameraView;

@interface CameraView : UIView<AVCaptureAudioDataOutputSampleBufferDelegate>{
    UIImage *imagebuffer;
    BOOL requireTakePhoto;
    BOOL processingtakePhoto;
    void *bitmap;
    
#ifdef __i386__
    
    AVCaptureSession *captureSession;
    dispatch_queue_t queue;
    
#endif

    
    UIImage *capturedImage;
    id delegate;
}






-(id)initWithFrame:(CGRect)frame delegate:(id)delegate;


//open camera session
-(void)openCameraSession;

//close camera session
-(void)closeCameraSession;

//Do capture
-(void)doCapture;

//capture Image
-(UIImage *)captureImage;

//set frame mode
@property (nonatomic , assign)BOOL frameMode;
@property (nonatomic , assign)id deleggate;

@end



@protocol CameraViewDelegate <NSObject>
@optional



-(void)Capturedend:(CameraView *)cameraView;
@end
