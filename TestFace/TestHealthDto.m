//
//  TestHealthDto.m
//  Face
//
//  Created by 前田 恭男 on 12/12/18.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//


#import "HealthDto.h"
#import <SenTestingKit/SenTestingKit.h>

@interface TestHealthDto : SenTestCase

@end



@implementation TestHealthDto


-(void)testHealthDto{
    int red=100;
    int green=110;
    int blue=120;
    HealthDto *dto=[[HealthDto alloc] initWithRGB:red green:green blue:blue];
    STAssertEquals(dto.red,red, @"red is miss");
    STAssertEquals(dto.green,green, @"green is miss");
    STAssertEquals(dto.blue,blue, @"blue is miss");
    
}

@end
