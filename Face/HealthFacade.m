//
//  HealthFacade.m
//  Face
//
//  Created by 前田 恭男 on 12/12/13.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthFacade.h"
#import "HealthDataDao.h"
#import "HealthDto.h"
#import "HealthDataDxo.h"

@interface HealthFacade(){
    int redAverage;
    int blueAverage;
    int greenAverage;
    int totcdalR;
    int totalG;
    int totalB;
}

@end

@implementation HealthFacade



//RGB値の比較によってポイントをつけていく
-(int)compareToday:(HealthDto *)dto{
    [self selectAllData];
    int point=0;
    if ([self isMoreThanRed:dto.red]) {
        point++;
    }
    if ([self isMoreThanGreen:dto.green]) {
        point+=10;
    }
    if ([self isMoreThanBlue:dto.blue]) {
        point+=15;
    }
    int healthStatus=[self checkHealth:point];
    NSLog(@"healthPoint:%d",healthStatus);
    return  healthStatus;
}


//ポイントによって健康状態チェック
-(int)checkHealth:(int)healthPoint{
    int healthStatus=0;
    if (healthPoint>0 && healthPoint<=10) {
        healthStatus=1;
    }
    else if (healthPoint>10 && healthPoint<=20){
        healthStatus=2;
    }
    else if (healthPoint>20 && healthPoint<=25){
        healthStatus=3;
    }
    return healthStatus;
}




//すべてのRGB値の所得

#pragma mark TODO:これは別の場所に動かしておくべき？？
-(void)selectAllData{
    totalB=0;
    totalG=0;
    totalR=0;
    HealthDataDao *dao=[[HealthDataDao alloc] init];
    NSMutableArray *allData=[dao selectAllData];
    int count=0;
    for (int i=0;i<allData.count; i++) {
        HealthEntity *entity=[allData objectAtIndex:i];
        HealthDto *dto=[HealthDataDxo  createHealthDto:entity];
        
        totalB+=dto.blue;
        totalG+=dto.green;
        totalR+=dto.red;
        count++;
    }
    [self averageHealthColor:count];
}

-(void)averageHealthColor :(int)count{
    redAverage=0;
    blueAverage=0;
    greenAverage=0;
    
    
    if (totalR<0&&totalG<0&&totalB<0) {
        redAverage=(int)totalR/count;
        blueAverage=(int)totalB/count;
        greenAverage=(int)totalG/count;
    }
    else{
        redAverage=1;
        blueAverage=1;
        greenAverage=1;
    }
    
}



//各RGB値の比較
-(BOOL)isMoreThanRed :(int)todayRed{
    BOOL moreThanToday=FALSE;
    if (redAverage >=todayRed) {
        moreThanToday=TRUE;
    }
    return moreThanToday;
}

-(BOOL)isMoreThanGreen :(int)todayGreen{
    BOOL moreThanToday=FALSE;
    if (greenAverage >=todayGreen) {
        moreThanToday=TRUE;
    }
    return moreThanToday;
}

-(BOOL)isMoreThanBlue :(int)todayBlue{
    BOOL moreThanToday=FALSE;
    if (blueAverage >=todayBlue) {
        moreThanToday=TRUE;
    }
    return moreThanToday;
}



@end
