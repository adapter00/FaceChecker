//
//  CamaraView.m
//  Face
//
//  Created by takao maeda on 2013/01/31.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//

#import "CameraView.h"
#import "FrameRectView.h"


static inline double radians (double degrees){return degrees * M_PI/180;}
typedef enum RotationAngle_{
RotaionAngle90=90,
RotaionAngle180=180,
RotaionAngle270=270,
}RotationAngle;

@interface CameraView ()
-(UIImage *)rorareImage:(UIImage *)img anfle:(RotationAngle)angle;
-(void)callCaptureEnded;



@property (nonatomic , retain) FrameRectView *frameRectView;


@property (nonatomic , readonly) size_t cameraWidth;
@property (nonatomic , readonly) size_t cameraHeight;
@property (readonly) NSString *cameraSessionPreset;
@property (nonatomic , retain) UIImage *imageBuffer;
@property (retain) UIImage *capturedImage;

#ifdef __i386__

@property (nonatomic , retain)AVCaptureSession *capturedSession;

#endif

@end

@implementation CameraView


@synthesize frameRectView=_frameRectView;
@synthesize capturedSession=_capturedSession;
@synthesize imageBuffer=_imageBuffer;
@synthesize capturedImage;
@synthesize delegate=_delegate;


#pragma mark - 
#pragma mark public method

-(id)initWithFrame:(CGRect)frame delegate:(id)delegate{
    self=[super initWithFrame:frame];
        _delegate=delegate;
    
//    //set frame rect View
//    
//    {
//        //        _frameRectView=[[FrameRectView alloc] initWithFrame:frame withCenterY:self.frame.size.height/2];
//        //        [_frameRectView autorelease];
//        //        [self setFrameRectView:_frameRectView];
//        //        [self addSubview:_frameRectView];
//        
//    }
    return self;
    
}


-(void)openCameraSession{
    requireTakePhoto=NO;
    processingtakePhoto=NO;
    
    //initialize imageBuffer
    
    size_t width=self.cameraHeight;
    size_t height=self.cameraHeight;
    
    
    bitmap=NSZoneMalloc(self.zone,width*height*4);
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef dataProviderRef=CGDataProviderCreateWithData(NULL, bitmap, width*height*4, NULL);
    CGImageRef cgImage=CGImageCreate(width, height, 8, 32, width*4, colorSpace, kCGBitmapByteOrder32Little|kCGImageAlphaPremultipliedFirst, dataProviderRef, NULL, 0,kCGRenderingIntentDefault);
    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(dataProviderRef);
    
#ifdef __i386__
    

    //start session open
    self.capturedSession=[[[AVCaptureSession alloc] init] autorelease];
    
    //select device
    AVCaptureDevice *videoCaptureDevice=nil;
    NSArray *cameraArray=[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *camera in cameraArray) {
        if (camera.position == AVCaptureDevicePositionBack) {
            videoCaptureDevice=camera;
        }
    }
    
    
    
    //set video stream
    
    NSError *error=nil;
    AVCaptureDeviceInput *videoInput=[AVCaptureDeviceInput deviceInputWithDevice:videoCaptureDevice error:&error];
    
    if (videoInput) {
        [self.capturedSession addInput:videoInput];
        
        
        //config(session)
        [self.capturedSession beginConfiguration];
        self.capturedSession.sessionPreset=self.cameraSessionPreset;
        [self.capturedSession commitConfiguration];
        
        //config
        //- set video mode
        
        if ([videoCaptureDevice lockForConfiguration:&error]) {
            
            
            // AVMode -> autoFocus
            if ([videoCaptureDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                videoCaptureDevice.focusMode=AVCaptureFocusModeAutoFocus;
            }
            //Expose ->auto expose
            if ([videoCaptureDevice isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                videoCaptureDevice.exposureMode=AVCaptureExposureModeContinuousAutoExposure;
            }
            
            //touvh mode ->off
            if ([videoCaptureDevice isTorchModeSupported:AVCaptureTorchModeOff]) {
                videoCaptureDevice.torchMode=AVCaptureTorchModeOff;
            }
            
            [videoCaptureDevice unlockForConfiguration];
        }else{
            NSLog(@"Error : %@",error);
        }
        
        //Get Video data(Code Snippet SP16)
        AVCaptureVideoDataOutput *videoOutput=[[[AVCaptureVideoDataOutput alloc] init] autorelease];
        //        AVCaptureConnection *connection=[[AVCaptureConnection alloc] init];
        
        if (videoInput) {
            videoOutput.videoSettings=[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:kCVPixelBufferPixelFormatTypeKey];
            //            videoOutput.minFrameDuration=CMTimeMake(1,20);            //20fps
            //            connection.videoMinFrameDuration=CMTimeMake(1,20);
            videoOutput.alwaysDiscardsLateVideoFrames=YES;
            queue=dispatch_queue_create("maeda_t CameraView", NULL);
            [videoOutput setSampleBufferDelegate:self queue:queue];
            
            dispatch_release(queue);
            [self.capturedSession addOutput:videoOutput];
        }
        //start video session
        if (videoInput) {
            [self.capturedSession startRunning];
        }
    }
#endif
}


-(void)closeCameraSession{
#ifdef __i386__
    
    [self.capturedSession stopRunning];
    for (AVCaptureOutput *output in self.capturedSession.outputs) {
        [self.capturedSession removeOutput:output];
    }
    for (AVCaptureInput *input in self.capturedSession.inputs) {
        [self.capturedSession removeInput:input];
    }
    self.capturedSession=nil;
#endif
#pragma -mark TODO:??
    NSZoneFree(self.zone, bitmap);
    bitmap=NULL;
}


-(void)doCapture{
    if (!processingtakePhoto) {
        requireTakePhoto=YES;
    }
}


#pragma mark -
#pragma mark camera parameter

-(size_t)cameraWidth{
    return 1280;
}
-(size_t)cameraHeight{
    return 720;
}
-(NSString *)cameraSessionPreset{
#ifdef __i386__
    return AVCaptureSessionPreset640x480;
#else
    return nil;
#endif
}


#pragma mark -
#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate

#ifdef __i386__
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    if (requireTakePhoto) {
        requireTakePhoto=NO;
        processingtakePhoto=YES;
        CVPixelBufferRef pixelbuff=CMSampleBufferGetImageBuffer(sampleBuffer);
        if (CVPixelBufferLockBaseAddress(pixelbuff,0)==kCVReturnSuccess) {
            
            
            memcpy(bitmap, CVPixelBufferGetBaseAddress(pixelbuff), self.cameraWidth*self.cameraHeight*4);
            
            //Rotate image
            UIImage *rotatedImage=[self rorareImage:self.imageBuffer anfle:RotaionAngle270];
            UIImage *capImage=rotatedImage;
            
            if ([self frameMode]) {
                
                
                CGRect stRect = self.frameRectView.targetFrameRect;
                
                //Get Scale rate
                CGFloat rateW=1.0f* self.cameraHeight / self.frame.size.width;
                CGFloat rateH=1.0f* self.cameraWidth / self.frame.size.height;
                CGFloat rateAll=(rateW < rateH) ? rateW : rateH;
                
                
                //Core Image
                CGFloat hiddenWidth = (self.frame.size.height / self.cameraWidth) * self.cameraWidth - self.frame.size.height;
                CGFloat hiddenHeight=(self.frame.size.width / self.cameraHeight) * self.cameraWidth - self.frame.size.height;
                
                hiddenWidth = (hiddenWidth < 0) ? 0:hiddenWidth;
                hiddenHeight = (hiddenHeight < 0) ? 0 : hiddenHeight;
                
                CGRect cropRect= CGRectMake(stRect.origin.x * rateAll+ hiddenWidth *rateAll / 2,
                                            stRect.origin.y * rateAll+ hiddenHeight *rateAll / 2,
                                            stRect.size.width *rateAll,
                                            stRect.size.height *rateAll);
                CGImageRef croppedImage = CGImageCreateWithImageInRect(rotatedImage.CGImage,cropRect);
                capImage=[UIImage imageWithCGImage:croppedImage];
            }
            [self performSelectorOnMainThread:@selector(endedCaptureCameraImage:) withObject:capImage waitUntilDone:NO];
            
            CVPixelBufferUnlockBaseAddress(pixelbuff, 0);
        }
    }
}

#endif


-(void)endedCaptureCameraImage:(UIImage *) uiimage{
    processingtakePhoto = NO;
    [self setCapturedImage:uiimage];
    [self callCaptureEnded];
}


#pragma mark - frame mode

-(void)setFrameMode:(BOOL)frameMode{
    
    
    if (frameMode) {
        [self.frameRectView setHidden:NO];
    } else {
        [self.frameRectView setHidden:YES];
    }
}


- (BOOL)frameMode {
    return [self.frameRectView isHidden] ? NO : YES;
}


#pragma mark - 
#pragma mark -delefate methods

-(void)callCaptureEnded{
    NSLog(@"IN %s", __func__);
    if ([_delegate respondsToSelector:@selector(callCaptureEnded:)]) {
        [_delegate performSelector:@selector(callCaptureEnded:) withObject:self];
    }
}

#pragma mark -
#pragma utility methods

//rotate image
-(UIImage *)rotatelImage: (UIImage *)img angle:(RotationAngle)angle{
    CGImageRef imgRef=[img CGImage];
    CGContextRef context;
    
    switch (angle) {
        case RotaionAngle90:
            UIGraphicsBeginImageContext(CGSizeMake(img.size.height, img.size.width));
            context=UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, img.size.height, img.size.width);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextRotateCTM(context, M_1_PI/2.0);
            break;
        case RotaionAngle180:
            UIGraphicsBeginImageContext(CGSizeMake(img.size.height, img.size.width));
            context=UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, img.size.height, img.size.width);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextRotateCTM(context, -M_PI);
            break;
        case RotaionAngle270:
            UIGraphicsBeginImageContext(CGSizeMake(img.size.height, img.size.width));
            context=UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, img.size.height, img.size.width);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextRotateCTM(context, -M_PI/2.0);
            break;
        default:
            NSLog(@"you can select an angle of 90,180,270");
            return nil;
    }
    CGContextDrawImage(context, CGRectMake(0, 0, img.size.width, img.size.height), imgRef);
    UIImage *ret=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ret;
}


#pragma  mark -

-(void)dealloc{
    self.imageBuffer=nil;
    self.capturedImage = nil;
#ifdef __i386__
    self.capturedSession=nil;
#endif
    [self setFrameRectView:nil];
    [super dealloc];
}
@end