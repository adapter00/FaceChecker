//
//  TestHealthEntity.m
//  Face
//
//  Created by 前田 恭男 on 12/12/18.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "HealthEntity.h"


@interface TestHealthEntity : SenTestCase

@end


@implementation TestHealthEntity

-(void)testInit{

    NSNumber *red=[NSNumber numberWithInt:100];
    NSNumber *blue=[NSNumber numberWithInt:110];
    NSNumber *green=[NSNumber numberWithInt:120];
    
    HealthEntity *entity=[[HealthEntity alloc] init];
    entity.red=red;
    entity.green=green;
    entity.blue=blue;
    
    
    
    
    STAssertEqualObjects(entity.red,red,@"red obj midd" );
    STAssertEqualObjects(entity.green,green,@"green obj midd" );
    STAssertEqualObjects(entity.blue,blue,@"blue obj midd" );
    
}

@end
