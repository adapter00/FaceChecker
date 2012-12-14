//
//  PhotoColorLogic.h
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoColorLogic : NSObject

-(int)calColorAve :(CGPoint)start stop:(CGPoint)stop image:(UIImage *)image;

@end
