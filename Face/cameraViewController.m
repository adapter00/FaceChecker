//
//  cameraViewController.m
//  Face
//
//  Created by 前田 恭男 on 13/01/23.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//

#import "CameraViewController.h"
#import "StartViewController.h"
#import "ViewBuilder.h"
#import "PhotoColorLogic.h"
#import "HealthStatusFacade.h"
#import "SVProgressHUD.h"
#import "HealthResultViewController.h"
#import "GraghViewController.h"
#import "CommonString.h"



@interface HeathCheckCameraViewController (){
    UIImageView *imageView;
    int total;
    AVCaptureSession *session;
    UIImage *capImage;
    UIImageView *previewImageView;
    HealthStatusFacade *hManager;
    dispatch_queue_t logicQueue;
    NSTimer *faceTimer;
    dispatch_queue_t globalQueue;
}

@property AVCaptureStillImageOutput *stillImageOutput;
@property AVCaptureVideoDataOutput *videoOutput;
@end


@implementation HeathCheckCameraViewController

@synthesize stillImageOutput;
@synthesize videoOutput;

#pragma mark LifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
    hManager=[[HealthStatusFacade alloc] init];
    previewImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:previewImageView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    [self initializeCameraView];
    
}


-(void)initializeCameraView{
    NSError *error=nil;
    session=[[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetMedium];
    AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //画像への入力作成し、セッションに追加
    AVCaptureDeviceInput *deviceInput=[AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    [session addInput:deviceInput];
    
    
    //画像への出力作成し、セッションに追加
    videoOutput=[[AVCaptureVideoDataOutput alloc] init];
    [session addOutput:videoOutput];
    
    //ビデオ入力のキャプチャの画像の情報のキューを設定
    dispatch_queue_t quete=dispatch_queue_create("myQueue", NULL);
    [videoOutput setAlwaysDiscardsLateVideoFrames:YES];
    [videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    [videoOutput setSampleBufferDelegate:self queue:quete];
    
    //ビデオへの出力の画像は、BGRAで出力
    videoOutput.videoSettings =@{(id)kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]};
    
    
    //ビデオ入力のAVCaptureConnectionを取得
    AVCaptureConnection *videoConnection=[videoOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //１秒辺り4回画像をキャプチャ
    videoConnection.videoMinFrameDuration=CMTimeMake(1, 50);
    [session startRunning];
    globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    faceTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showIndicator) userInfo:nil repeats:YES];

}

-(AVCaptureDevice *)videoDeviceWithPosition :(AVCaptureDevicePosition)position{
    NSArray *devices=[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position]==position) {
            return  device;
        }
    }
    return nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(void)viewDidUnload{
    [super viewDidUnload];
    imageView=nil;
}


-(void)deleteImageView{
    [imageView removeFromSuperview];
    imageView=nil;
}


-(id)dismissIndicator:(id)selector{
    [SVProgressHUD dismiss];
    HealthResultViewController *resultView = [[HealthResultViewController alloc]initWithNibName:@"HealthResultViewController" bundle:nil];
    resultView.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    NSLog(@"view!!!!!!");
    if (selector!=nil) {
        resultView.healthStatus=selector;
    }
    [self presentModalViewController:resultView animated:YES];
    return nil;
}
#pragma  mark- getImageMethod


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{

    
    //mainスレッドでキャプチャの貼付け
    capImage=[self imageFromSampleBufferRef:sampleBuffer];
    dispatch_async(dispatch_get_main_queue(), ^{
        previewImageView.image=capImage;
    });
    
//    //別スレッドで判定ロジック
//    dispatch_async(globalQueue, ^{
//            if ([hManager isFace:capImage]){
//                NSLog(@"face");
//                [self performSelector:@selector(showIndicator) withObject:nil afterDelay:1.0f];
//                [session stopRunning];
//            }
//        });
}


-(void)showIndicator{
    if([hManager isFace:capImage]){
    [session stopRunning];
    NSNumber *healthStatusNumber=[hManager checkTodayHealth:capImage];
    //インジケータの表示(4秒間表示させる)
                    NSLog(@"INDICATOR");
    [SVProgressHUD showWithStatus:DIAGNOSING];
    [self performSelector:@selector(dismissIndicator:) withObject:healthStatusNumber afterDelay:2.0f];
                    NSLog(@"GO");
    [faceTimer invalidate];
    }
}


-(UIImage *)imageFromSampleBufferRef:(CMSampleBufferRef)samplebuffer{
    
    // イメージバッファの取得
    CVImageBufferRef    buffer;
    buffer = CMSampleBufferGetImageBuffer(samplebuffer);
    
    // イメージバッファのロック
    CVPixelBufferLockBaseAddress(buffer, 0);
    // イメージバッファ情報の取得
    uint8_t*    base;
    size_t      width, height, bytesPerRow;
    base = CVPixelBufferGetBaseAddress(buffer);
    width = CVPixelBufferGetWidth(buffer);
    height = CVPixelBufferGetHeight(buffer);
    bytesPerRow = CVPixelBufferGetBytesPerRow(buffer);
    
    // ビットマップコンテキストの作成
    CGColorSpaceRef colorSpace;
    CGContextRef    cgContext;
    colorSpace = CGColorSpaceCreateDeviceRGB();
    cgContext = CGBitmapContextCreate(
                                      base, width, height, 8, bytesPerRow, colorSpace,
                                      kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    
    // 画像の作成
    CGImageRef  cgImage;
    UIImage*    image;
    cgImage = CGBitmapContextCreateImage(cgContext);
    image = [UIImage imageWithCGImage:cgImage scale:1.0f
                          orientation:UIImageOrientationRight];
    CGImageRelease(cgImage);
    CGContextRelease(cgContext);
    
    // イメージバッファのアンロック
    CVPixelBufferUnlockBaseAddress(buffer, 0);
    return image;
}





@end
