//
//  ViewBuilder.h
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewBuilder : NSObject


//ロジックなものがない各ビューはここで作成すること

+(UIImageView *)createImageView:(UIImage *)image;
+(UIImage *)resizeImage:(UIImage *)image;

@end
