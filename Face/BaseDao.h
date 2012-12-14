//
//  HealthDao.h
//  Face
//
//  Created by 前田 恭男 on 12/12/13.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
#import "FMDatabase.h"


@protocol BaseDao <NSObject>
-(void)deleteColum :(BaseEntity *)entity;
-(void)insertColum :(BaseEntity *)entity;
-(NSMutableArray *)selectAllData;



@end
