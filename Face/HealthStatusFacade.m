//
//  HealthStatusManager.m
//  Face
//
//  Created by 前田 恭男 on 12/12/14.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthStatusFacade.h"
#import "PhotoColorLogic.h"
#import "HealthDto.h"
#import "HealthLogic.h"
#import "HealthDatabaseHelp.h"

enum  {
    MOUTH_POS = 0,
    RIGHTEYE_POS=1,
    LEFTEYE_POS = 2,
};

@implementation HealthStatusFacade


//本日の健康状態を知るメソッド


-(int)checkTodayHealth :(NSArray *)pointArray image:(UIImage *)image{
    CGPoint mouthPos=[[pointArray objectAtIndex:MOUTH_POS] CGPointValue];
    CGPoint leftPos=[[pointArray objectAtIndex:LEFTEYE_POS] CGPointValue];
    CGPoint rightpos=[[pointArray objectAtIndex:RIGHTEYE_POS] CGPointValue];
    PhotoColorLogic *pLogic=[[PhotoColorLogic alloc] init];
    NSArray *todayRGB=[pLogic calColorAve:mouthPos leftEye:leftPos rightEye:rightpos image:image];
    
    //dto作成
    HealthDto *dto=[[HealthDto alloc] initWithRGB:[[todayRGB objectAtIndex:0]intValue] green:[[todayRGB objectAtIndex:1]intValue] blue:[[todayRGB objectAtIndex:2]intValue]];
    
    HealthDatabaseHelp *dbHelper=[[HealthDatabaseHelp alloc] init];
    
    //dbに登録されているデータの所得
    NSMutableArray *allData=[dbHelper selectAllData];
    
    
    //健康状態の所得
    HealthLogic *hLogic=[[HealthLogic alloc] init];
    int healthStatus=[hLogic checkTodayHealth:dto :allData];
    
    
    //今日の状態をdbに登録
    dto.healthStatus=healthStatus;
    [dbHelper insertDatabase:dto];
    
    return healthStatus;
    
}

-(void)deleteAllData{

    HealthDatabaseHelp *dbHelp=[[HealthDatabaseHelp alloc]init];
    [dbHelp deleteAllData];
}

@end
