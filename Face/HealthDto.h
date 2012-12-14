//
//  HealthDto.h
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDto.h"

@interface HealthDto :BaseDto

@property int healthStatus;
@property int red;
@property int blue;
@property int green;
@property NSDate *recordDate;

@end
