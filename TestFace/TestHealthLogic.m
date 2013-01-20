//
//  TestHealthLogic.m
//  Face
//
//  Created by 前田 恭男 on 12/12/18.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//


#import <SenTestingKit/SenTestingKit.h>
#import "HealthEntity.h"
#import "HealthLogic.h"
#import "HealthDto.h"

@interface TestHealthLogic : SenTestCase

@end

enum  {
    BAD_STATUS = 3,
    NORMAL_STATUS = 2,
    GODD_STATUS=1,
};



@implementation TestHealthLogic
-(void)testCheckTodayHealth{
//    
//    NSNumber *redNumer=[NSNumber numberWithInt:100];
//    NSNumber *greenNumer=[NSNumber numberWithInt:100];
//    NSNumber *blueNumber=[NSNumber numberWithInt:100];
//    NSNumber *testHealthStatus=[NSNumber numberWithInt:1];
//    NSDate *date=[NSDate date];
//    HealthEntity *entity1=[[HealthEntity alloc] init];
//    entity1.red=redNumer;
//    entity1.green=greenNumer;
//    entity1.blue=blueNumber;
//    entity1.healthStatus=testHealthStatus;
//    entity1.recordDate=date;
//    
//    HealthEntity *entity2=[[HealthEntity alloc] init];
//    entity2.red=redNumer;
//    entity2.green=greenNumer;
//    entity2.blue=blueNumber;
//    entity2.healthStatus=testHealthStatus;
//    entity2.recordDate=date;
//    
//    
//    NSMutableArray *targetArray=[NSMutableArray arrayWithObjects:entity1,entity2, nil];
//    HealthDto *badDto=[[HealthDto alloc] initWithRGB:200 green:200 blue:200];
//    HealthLogic *hLogic=[[HealthLogic alloc] init];
//    int testBadHeath=[hLogic checkTodayHealth:badDto :targetArray];
//    
//    STAssertEquals(BAD_STATUS, testBadHeath,@"this val is missed!");
//    
//    HealthDto *normalDto=[[HealthDto alloc] initWithRGB:100 green:120 blue:90];
//    int testNormalHeath=[hLogic checkTodayHealth:normalDto :targetArray];
//    STAssertEquals(NORMAL_STATUS, testNormalHeath,@"this val is missed!");
//    
//    HealthDto *goodStatus=[[HealthDto alloc] initWithRGB:100 green:90 blue:90];
//    int testGoodStatus=[hLogic checkTodayHealth:goodStatus :targetArray];
//    STAssertEquals(GODD_STATUS, testGoodStatus,@"this val is missed!");
}


@end
