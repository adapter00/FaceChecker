//
//  HealthDatabaseHelp.m
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthDatabaseHelp.h"
#import "HealthDataDxo.h"
#import "HealthDataDao.h"

@implementation HealthDatabaseHelp

-(void)insertDatabase:(HealthDto *)dto{
    HealthEntity *entity=[HealthDataDxo createHealthEntity:dto];
    HealthDataDao *dao=[[HealthDataDao alloc] init];
    [dao insertColum:entity];
}

-(NSMutableArray *)selectAllData{
    HealthDataDao *db=[[HealthDataDao alloc] init];
    NSMutableArray *entityData=[db selectAllData];
    return entityData;
}

@end
