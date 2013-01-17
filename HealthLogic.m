//
//  HealthLogic.m
//  Face
//
//  Created by 前田 恭男 on 12/12/14.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthLogic.h"
#import "HealthDto.h"
#import "HealthCalLogic.h"


//健康に関するロジック

@implementation HealthLogic

-(int)checkTodayHealth :(HealthDto *)dto :(NSMutableArray *)allData{
    HealthCalLogic *calLogic=[[HealthCalLogic alloc] init];
    int healthStatus=[calLogic compareToday:dto AllData:allData];
    return healthStatus;
}



@end
