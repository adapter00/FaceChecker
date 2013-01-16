//
//  ViewBuilder.h
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewBuilder : NSObject


//ロジックがない各ビューはここで作成すること

+(UIImageView *)createImageView:(UIImage *)image;
+(UIImage *)resizeImage:(UIImage *)image;
+(UIAlertView *)createAlert:(NSString *)titile Message:(NSString *)message buttonTitle:(NSString *)cancelButtonTitile delegate:(id)delegate;
+(UIActivityIndicatorView *)createIndicator :(UIView *)view Message:(NSString *)message;
+(UIButton *)createTranparentButton;

@end
