//
//  HealthDto.m
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthDto.h"

@implementation HealthDto

@synthesize red;
@synthesize blue;
@synthesize green;
@synthesize healthStatus;
@synthesize recordDate;

-(id)initWithRGB :(int)r  green:(int)g blue:(int)b{
    
    if (self = [super init]) {
        red=r;
        blue=b;
        green=g;
        healthStatus=0;
        recordDate=[[NSDate alloc] init];
    }
    
    return self;
}

@end
