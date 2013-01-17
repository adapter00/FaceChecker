//
//  HealthEntity.m
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthEntity.h"
#import "DateFormatter.h"

@implementation HealthEntity

@synthesize healthStatus;
@synthesize red;
@synthesize blue;
@synthesize green;
@synthesize recordDate;

-(id)init{
    if (self=[super init]) {
        if (recordDate==nil) {
            NSDate *date=[[NSDate alloc] init];
            NSString *dateString=[DateFormatter dateFormatter:date];
            recordDate=dateString;    
        }
        
    }
return  self;
}

@end
