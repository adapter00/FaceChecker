//
//  FrameRectView.h
//  Face
//
//  Created by 前田 恭男 on 13/02/06.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrameRectView : UIView{
@private 
    CGFloat centerY;
    CGRect targetFrameRect;
    
    
    UIColor *stroleColor;
    UIColor *fillColor;
    
    //for dragging
    CGPoint dragStrartPoint;
    NSInteger directX;
    NSInteger directY;
}

//Initializer
-(id)initWithFrame:(CGRect)frame withCenterY:(CGFloat)y;

//Get target frame recct

@property (readonly)CGRect targetFrameRect;






@end
