//
//  Database.h
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthEntity.h"
#import "BaseDao.h"

@interface HealthDataDao : NSObject


-(id)init;
-(void)insertColum :(HealthEntity *)entity;
-(NSMutableArray *)selectAllData;
-(void)deleteAllData;

@end
