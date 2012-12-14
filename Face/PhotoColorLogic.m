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
#import "HealthFacade.h"

@implementation PhotoColorLogic







-(int)checkTodayHealth :(int)todayRed blue:(int)todayGreen Blue:(int)todayBlue{
    HealthFacade *facade=[[HealthFacade alloc] init];
    HealthDto *dto=[[HealthDto alloc] init];
    dto.red=todayRed;
    dto.blue=todayBlue;
    dto.green=todayGreen;
    return [facade compareToday:dto];
}






-(int)calColorAve :(CGPoint)start stop:(CGPoint)stop image:(UIImage *)image{
    CGImageRef  imageRef;
    imageRef = image.CGImage;
    
#pragma mark TODO:いらないものを消去しておくこと
    
    // ピクセルを構成するRGB各要素が何ビットで構成されている
    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    // ピクセル全体は何ビットで構成されているか
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    // 画像の横1ライン分のデータが、何バイトで構成されているか
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    // 画像の色空間
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    // 画像のBitmap情報
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    // 画像がピクセル間の補完をしているか
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    // 表示装置によって補正をしているか
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    // 画像のデータプロバイダを取得する
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    int totalR=0;
    int totalG=0;
    int totalB=0;
    int Xwidth=0;
    for (int i=stop.x; i<start.x; i++) {
        for (int j=stop.y; j<start.y;j++ ) {
            UInt8 *pixelInfo = buffer+bytesPerRow  * j + i  * 4;
            UInt8 red = *(pixelInfo+3);
            UInt8 green = *(pixelInfo + 2);
            UInt8 blue = *(pixelInfo + 1);
            totalR+=red;
            totalB+=blue;
            totalG+=green;
            Xwidth++;
        }
    }
    NSLog(@"Average RED:%d",totalR/Xwidth);
    NSLog(@"Average BLUE:%d",totalB/Xwidth);
    NSLog(@"Average GREEN:%d",totalG/Xwidth);
    
    return  [self checkTodayHealth:totalR/Xwidth blue:totalB/Xwidth Blue:totalG/Xwidth];
}

@end
