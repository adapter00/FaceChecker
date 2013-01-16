//
//  HealthDatabaseHelp.h
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthDto.h"


//LogicとDaoの間にあるもの

@interface HealthDatabaseHelp : NSObject


-(void)insertDatabase:(HealthDto *)dto;
-(NSMutableArray *)selectAllData;
-(void)deleteAllData;
@end
