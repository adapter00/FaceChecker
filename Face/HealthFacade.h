//
//  HealthFacade.h
//  Face
//
//  Created by 前田 恭男 on 12/12/13.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthDto.h"


//ここで顔色から健康状態を測る

@interface HealthFacade : NSObject


-(int)compareToday:(HealthDto *)dto;


@end
