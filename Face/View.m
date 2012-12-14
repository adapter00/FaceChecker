//
//  View.m
//  Sample2
//
//  Created by 前田 恭男 on 12/11/28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "View.h"

@implementation View

-(void)drawRect:(CGRect)rect{
    [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] setFill];
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextFillEllipseInRect(context, rect);
}


-(void)Redraw:(int)atX atY:(int)atY{

}

@end
