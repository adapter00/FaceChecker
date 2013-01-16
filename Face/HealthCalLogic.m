//
//  HealthFacade.m
//  Face
//
//  Created by 前田 恭男 on 12/12/13.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthCalLogic.h"
#import "HealthDataDao.h"
#import "HealthDto.h"
#import "HealthDataDxo.h"

enum  {
    RED_DTO = 1,
    GREEN_DTO = 2,
    BLUE_DTO=3,
};

enum  {
    GOOD_STATUS=1,
    NORMAL_STATUS = 2,
    WORTH_STATUS=3,
};


@implementation HealthCalLogic



//RGB値の比較によってポイントをつけていく
-(int)compareToday:(HealthDto *)dto AllData:(NSMutableArray *)allData{
    int redAverage=[self calAverageAllData:allData colorNum:RED_DTO];
    int blueAverage=[self calAverageAllData:allData colorNum:GREEN_DTO];
    int greenAverage=[self calAverageAllData:allData colorNum:BLUE_DTO];
    int point=0;
    //まずは今日の顔色が明らかに悪い
    if ([self checkTodayHealth:dto]) {
        point+=30;
        int healthStatus=[self setHealthStatus:point];
        return healthStatus;
    }
    //その後今までの値と比べる
    if ([self compareTodayRGB:dto.red Average:redAverage]) {
        point++;
        NSLog(@"RED POINT");
    }
    if ([self compareTodayRGB:dto.green Average:greenAverage]) {
        point+=10;
        NSLog(@"GREEN POINT");
    }
    if ([self compareTodayRGB:dto.blue Average:blueAverage]) {
        point+=15;
        NSLog(@"BLUE POINT");
    }
    
    NSLog(@"point:%d",point);
    int healthStatus=[self setHealthStatus:point];
    
    return  healthStatus;
}


//ポイントによって健康状態チェック
-(int)setHealthStatus:(int)healthPoint{
    int healthStatus=0;
    if (healthPoint>=0 && healthPoint<=10) {
        healthStatus=GOOD_STATUS;
    }else if (healthPoint>10 && healthPoint<=20){
        healthStatus=NORMAL_STATUS;
    }else if (healthPoint>20 && healthPoint<=26){
        healthStatus=WORTH_STATUS;
    }else {
        NSLog(@"異常値");
    }
    NSLog(@"healthStatus:%d",healthStatus);
    return healthStatus;
}



//すべてのRGB値の所得
-(int)calAverageAllData :(NSMutableArray *)allData colorNum:(int)num {
    int total=0;
    for (int i=0;i<allData.count; i++) {
        HealthEntity *entity=[allData objectAtIndex:i];
        HealthDto *dto=[HealthDataDxo  createHealthDto:entity];
        total+=[self selectDtoColor:num Dto:dto];
        
    }
    
    int average=0;
    if (total>0) {
        average=total/allData.count;
    }
    //テスト用、データベースに何も無いときのものを作っておく
    else{
        average=0;
    }
    return average;
    
}


//dtoの取り出し
-(int)selectDtoColor:(int)num Dto:(HealthDto *)dto{
    int color=0;
    switch (num) {
        case RED_DTO:
            color=dto.red;
            break;
        case GREEN_DTO:
            color=dto.green;
            break;
        case BLUE_DTO:
            color=dto.blue;
            break;
            
        default:
            break;
    }
    return color;
}

//各RGB値の比較
-(BOOL)compareTodayRGB :(int)todayColor Average:(int)Average{
    BOOL moreThanToday=FALSE;
    if (Average <=todayColor) {
        moreThanToday=TRUE;
        NSLog(@"TODAY_COLOR IS HIGHER THAN");
    }
    return moreThanToday;
}


//本日の顔色をチェック
-(BOOL)checkTodayHealth :(HealthDto *)dto{
    if (dto.red<255 &&dto.blue < 220 && dto.green <240 ) {
        return NO;
    }
    return YES;
}



@end
