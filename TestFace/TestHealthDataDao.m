//
//  TestLogic.m
//  Face
//
//  Created by 前田 恭男 on 12/12/17.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//


#import <SenTestingKit/SenTestingKit.h>
#import "HealthEntity.h"
#import "HealthDataDao.h"

@interface HealthDataDao ()

@property FMDatabase *db;

@end



@interface TestHealthDataDao : SenTestCase{

    HealthDataDao *dao;
}

@end

@implementation TestHealthDataDao

- (void)setUp
{
    [super setUp];
    //dao=[[MockDao alloc] init];
    dao=[[HealthDataDao alloc] init];
    NSString *directory = [[NSFileManager defaultManager] currentDirectoryPath];
    NSString *path = [directory stringByAppendingPathComponent:@"UnitTests/"];
    NSString *Apath = [path stringByAppendingPathComponent:@"Test.sqlite"];
    
    NSLog(@"path:%@",Apath);
    //テーブルが存在しないときはここで生成しておく
    dao.db= [FMDatabase databaseWithPath:Apath];


}

-(void)testDaoInit{
    
    STAssertNotNil(dao,@"dao is nil");
}
-(void)testDaoInsert{
    HealthEntity *expectedEntity=[[HealthEntity alloc] init];
    expectedEntity.red=[NSNumber numberWithInt:100];
    expectedEntity.green=[NSNumber numberWithInt:110];
    expectedEntity.blue=[NSNumber numberWithInt:120];
    expectedEntity.healthStatus=[NSNumber numberWithInt:1];
    
    [dao insertColum:expectedEntity];
    NSMutableArray *testaArray=[dao selectAllData];
    HealthEntity *resultEntity=[testaArray lastObject];
    NSLog(@"test%d",testaArray.count);
    STAssertEquals([resultEntity.red intValue], [expectedEntity.red intValue],@"not equal");
    
}

- (void)tearDown
{
    // Tear-down code here.
    [dao deleteAllData];
    [super tearDown];
}


@end

