//
//  ViewBuilder.m
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "ViewBuilder.h"

@implementation ViewBuilder

+(UIImageView *)createImageView:(UIImage *)image{
    CGRect rect= CGRectMake(0, 0,[[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [image drawInRect:rect];
    
    UIImage *createImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imageView=[[UIImageView alloc] initWithImage:createImage];
    
    return  imageView;
}

+(UIImage *)resizeImage:(UIImage *)image{
    CGRect rect= CGRectMake(0, 0,[[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [image drawInRect:rect];
    
    UIImage *createImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return createImage;
}


@end
