//
//  HealthFacade.h
//  Face
//
//  Created by 前田 恭男 on 12/12/13.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthDto.h"


//ロジックから受け取り複雑な処理を行う

@interface HealthCalLogic : NSObject


-(int)compareToday:(HealthDto *)dto AllData:(NSMutableArray *)allData;


@end
