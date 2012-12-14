//
//  HealthEntity.m
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthEntity.h"

@implementation HealthEntity

@synthesize healthStatus;
@synthesize red;
@synthesize blue;
@synthesize green;
@synthesize recordDate;

-(id)init{
    if (self=[super init]) {
        NSDate *date=[[NSDate alloc] init];
        recordDate=date;
    }
return  self;
}

@end
