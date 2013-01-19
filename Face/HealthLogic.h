//
//  HealthLogic.h
//  Face
//
//  Created by 前田 恭男 on 12/12/14.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthDto.h"


@interface HealthLogic : NSObject

//健康度を計測するためのロジック部分
//aaaaaaaaaaaaaaaaaaaaaaaaa
//aaaaaaaaaaaaaaaaaaaaaaaaaaaa


-(int)checkTodayHealth :(HealthDto *)dto :(NSMutableArray *)allData;

@end
