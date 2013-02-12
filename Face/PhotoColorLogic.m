//
//  PhotoColorLogic.m
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "PhotoColorLogic.h"
#import "HealthDatabaseHelp.h"
#import "HealthDto.h"
#import "HealthCalLogic.h"


enum  {
    COLOR_POINTER = 4,
    RED_POINTER = 2,
    GREEN_POINTER=1,
    BLUE_POINTER=0,
};

@interface PhotoColorLogic(){

}
@end

@implementation PhotoColorLogic

-(id)init{
    self=[super init];
    if(self){


    }
    return self;
        
}


#pragma mark -RGBAverageMethod
-(UInt8*)setImageDataPrpperty :(UIImage *)image{
    CGImageRef  imageRef;
    imageRef = image.CGImage;
    
    // 画像のデータプロバイダを取得する
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    return buffer;
    
}

-(NSArray *)calColorAve :(CGPoint)mouth leftEye:(CGPoint)leftEye rightEye:(CGPoint)rightEye image:(UIImage *)image{
    
    UInt8* buffer=[self setImageDataPrpperty:image];
    size_t bytesPerRow= CGImageGetBytesPerRow(image.CGImage);
    NSArray *aveArray=[self calAverage:mouth leftEye:leftEye rightEye:rightEye image:image buffer:buffer bytePerRow:bytesPerRow];
    
    return aveArray;
}


//平均値を所得する
-(NSArray *)calAverage :(CGPoint)mouth leftEye:(CGPoint)leftEye rightEye:(CGPoint)rightEye image:(UIImage *)image buffer:(UInt8*)buffer bytePerRow :(size_t)bytesPerRow{
    int totalR=0;
    int totalG=0;
    int totalB=0;
    int Xwidth=0;
    
    int startY=0;
    int stopY=0;
    int startX=0;
    int stopX=0;
    
    if (leftEye.y<rightEye.y) {
        startY=(int)leftEye.y;
        
    }
    else{
        startY=(int)rightEye.y;
        
    }
    stopY=(int)mouth.y;
    stopX=(int)rightEye.x;
    startX=(int)leftEye.x;

    for (int i=startX; i<stopX; i++) {
        for (int j=startY; j<stopY; j++ ) {
            
            //RGB値を所得する
            UInt8* pixelInfo = buffer+ bytesPerRow  * j + i  * COLOR_POINTER;
            UInt8 red = *(pixelInfo+RED_POINTER);
            UInt8 green = *(pixelInfo + GREEN_POINTER);
            UInt8 blue = *(pixelInfo + BLUE_POINTER);
            Xwidth++;

            if (!([self isValidColor:red green:green blue:blue])) {
                red=0;
                green=0;
                blue=0;
                Xwidth--;
            }
            totalR+=red;
            totalB+=blue;
            totalG+=green;
            
        }
    }
    
    //平均値の計算
    if (totalR>0&&totalG>0&&totalB>0) {
        int aveRed=(int)totalR/Xwidth;
        int aveGreen=(int)totalG/Xwidth;
        int aveBlue=(int)totalB/Xwidth;
        NSLog(@"Average RED:%d",aveRed);
        NSLog(@"Average BLUE:%d",aveBlue);
        NSLog(@"Average GREEN:%d",aveGreen);
        NSArray *aveRGB=[NSArray arrayWithObjects:[NSNumber numberWithInt:aveRed],[NSNumber numberWithInt:aveBlue],[NSNumber numberWithInt:aveGreen],nil];
        
        return  aveRGB;
        
    }else{
        NSLog(@"TestError");
    }
    return 0;
    
}



#pragma mark -FaceFeatureMethod

//画像の顔検出
-(NSArray *)createFacefeature:(UIImage *)image{

    //顔検出器の作成
    NSDictionary *options=[[NSDictionary alloc] initWithObjectsAndKeys:CIDetectorAccuracyHigh,CIDetectorAccuracy, nil];
    CIDetector *detector=[CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
    CIImage *ciImage=[[CIImage alloc] initWithCGImage:image.CGImage];
    NSArray *array=[detector featuresInImage:ciImage];
    detector=NULL;


    //各パーツの取得
    for (CIFaceFeature *faceFeature in array) {
        UIImageView *imageView=[[UIImageView alloc] initWithImage:image];
        NSLog(@"face get");
        return [self PartsOfFace:faceFeature View:imageView];
    }
    ciImage=nil;
    array=nil;
    return nil;
}


//パーツの座標所得
-(NSArray *)PartsOfFace :(CIFaceFeature *)faceFeature View:(UIImageView *)imageView{
    
    if (faceFeature.hasLeftEyePosition&&faceFeature.hasMouthPosition&&faceFeature.hasRightEyePosition) {
        CGAffineTransform transform=[self transformPosition:faceFeature: (UIImageView *)imageView];
        const CGPoint mouthPos=CGPointApplyAffineTransform(faceFeature.mouthPosition, transform);
        const CGPoint righteye=CGPointApplyAffineTransform(faceFeature.rightEyePosition, transform);
        const CGPoint leftEye=CGPointApplyAffineTransform(faceFeature.leftEyePosition, transform);


        NSArray *pointArray=[NSArray arrayWithObjects:[self changeNumber:mouthPos],[self changeNumber:righteye],[self changeNumber:leftEye], nil];
        return pointArray;
    }
    return 0;
}


//　画像の向きを変化させる
-(CGAffineTransform)transformPosition:(CIFaceFeature *)faceFeature :(UIImageView *)imageView{
    CGAffineTransform transform=CGAffineTransformMakeScale(1, -1);
    transform=CGAffineTransformTranslate(transform, 0, -imageView.bounds.size.height);
    return transform;
}

-(BOOL)isValidColor:(UInt8)r green:(UInt8)g blue:(UInt8)b{
    BOOL isValidColor=NO;
    if(200<r && r<=255 && 100<g && g<=200&& 100<b && b<=200){
        isValidColor=YES;
    }
    return isValidColor;
}

//CGpointをNSValueに変換
-(NSValue *)changeNumber:(CGPoint)point{
    NSValue *val=[NSValue valueWithCGPoint:point];
    return val;
}




@end
