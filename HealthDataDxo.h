//
//  HealthFacade.h
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthEntity.h"
#import "HealthDto.h"

//dtoとentityの間の変換を行う

@interface HealthDataDxo : NSObject

+(HealthEntity *)createHealthEntity:(HealthDto *)dto;
+(HealthDto *)createHealthDto:(HealthEntity *)entity;

@end
