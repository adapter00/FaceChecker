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
#import "CommonNumber.h"

@interface HealthStatusFacade (){
    PhotoColorLogic *pLogic;
    NSArray *pointArray;
}

@end

@implementation HealthStatusFacade

-(id)init{
    self=[super init];
    if (self) {
        pLogic=[[PhotoColorLogic alloc] init];
    }

    return self;
}

//本日の健康状態を知るメソッド


-(NSNumber *)checkTodayHealth :(UIImage *)image{
    
    //座標の所得
    CGPoint mouthPos=[[pointArray objectAtIndex:MOUTH_POS] CGPointValue];
    CGPoint leftPos=[[pointArray objectAtIndex:LEFTEYE_POS] CGPointValue];
    CGPoint rightpos=[[pointArray objectAtIndex:RIGHTEYE_POS] CGPointValue];
    NSArray *todayRGB=[pLogic calColorAve:mouthPos leftEye:leftPos rightEye:rightpos image:image];
    
    //dto作成
    HealthDto *dto=[[HealthDto alloc] initWithRGB:[[todayRGB objectAtIndex:0]intValue] green:[[todayRGB objectAtIndex:1]intValue] blue:[[todayRGB objectAtIndex:2]intValue]];
    
    HealthDatabaseHelp *dbHelper=[[HealthDatabaseHelp alloc] init];
    
    //dbに登録されているデータの所得
    NSMutableArray *allData=[dbHelper selectAllData];
    
    
    //健康状態の所得
    HealthLogic *hLogic=[[HealthLogic alloc] init];
    int healthStatus=[hLogic checkTodayHealth:dto :allData];
    NSNumber *healthStatusNumber=[NSNumber numberWithInt:healthStatus];
    
    
    //今日の状態をdbに登録
    dto.healthStatus=healthStatus;
    [dbHelper insertDatabase:dto];
    
    return healthStatusNumber;
    
}

-(BOOL)isFace :(UIImage *)image{
    //座標の所得
    pointArray=[pLogic createFacefeature:image];
    if (pointArray.count != 0) {
            NSLog(@"face attach");
        return YES;
    }
    return NO;
}

-(void)deleteAllData{

    HealthDatabaseHelp *dbHelp=[[HealthDatabaseHelp alloc]init];
    [dbHelp deleteAllData];
}

@end
