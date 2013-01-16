//
//  HealthFacade.m
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "DateFormatter.h"
#import "HealthDataDxo.h"



@implementation HealthDataDxo

+(HealthEntity *)createHealthEntity:(HealthDto *)dto{
    HealthEntity *entity=[[HealthEntity alloc] init];
    entity.recordDate=[DateFormatter dateFormatter:dto.recordDate];
    entity.red=[NSNumber numberWithInt:dto.red];
    entity.blue=[NSNumber numberWithInt:dto.blue];
    entity.green=[NSNumber numberWithInt:dto.green];
    entity.healthStatus=[NSNumber numberWithInt:dto.healthStatus];
    
        return entity;
}

+(HealthDto *)createHealthDto:(HealthEntity *)entity{
    HealthDto *dto=[[HealthDto alloc] init];
    dto.recordDate=[DateFormatter stringFormatterWithDate:entity.recordDate];
    dto.red=[entity.red intValue];
    dto.blue=[entity.blue intValue];
    dto.green=[entity.green intValue];
    dto.healthStatus=[entity.healthStatus intValue];
    return dto;
}

@end
