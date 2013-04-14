//
//  PhotoColorLogic.h
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoColorLogic : NSObject

//画像に関するロジック

-(id)init;
-(NSArray *)calColorAve :(CGPoint)mouth leftEye:(CGPoint)leftEye rightEye:(CGPoint)rightEye image:(UIImage *)image;
-(NSArray *)createFacefeature:(UIImage *)image;


@end
