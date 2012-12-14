//
//  Database.m
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "HealthDataDao.h"
#import "DateFormatter.h"
#import "FMDatabase.h"
#import "FMResultSet.h"


//SQL文
static NSString *const CREATE_SQL=@"CREATE TABLE IF NOT EXISTS healthData (id INTEGER PRIMARY KEY AUTOINCREMENT, recordDate TEXT , RED INTEGER , GREEN INTEGER , BLUE INTEGER, HEALTHSTATUS INTEGER);";

static NSString *const INSERT_SQL=@"INSERT INTO healthData (recordDate,RED,GREEN,BLUE,HEALTHSTATUS) VALUES (?,?,?,?,?)";

static NSString *const SELECT_ALL_SQL=@"SELECT * FROM healthData;";

//テーブルのカラム番号
enum COLUM_NUMBER {
    RECORD_DATE_COLUM = 1,
    RED_COLUM = 2,
    GREEN_COLUM=3,
    BLUE_COLUM=4,
    HEALTH_STATUS_COLUM=5
};

@interface HealthDataDao(){
    FMDatabase *db;
    NSString *sql;
}

@end

@implementation HealthDataDao

-(id)init{
    if (self =[super init]) {
        //テーブルが存在しないときはここで生成しておく
        
        NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
        NSString*   dir   = [paths objectAtIndex:0];
        db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"healthData.sqlite"]];
        
        sql = CREATE_SQL;
        [db open];
        [db executeUpdate:sql];
        [db close];
    }
    return self;
}

-(void)insertColum :(HealthEntity *)entity{
    sql =INSERT_SQL;
    [db open];
    NSString *recordDate=[DateFormatter dateFormatter:entity.recordDate];
    [db executeUpdate:sql,recordDate,entity.red,entity.green,entity.blue,entity.healthStatus];
    [db close];
}

-(NSMutableArray *)selectAllData{
    
    sql = SELECT_ALL_SQL;
    
    [db open];
    FMResultSet *results = [db executeQuery:sql];
    NSMutableArray* entityData   = [[NSMutableArray alloc] initWithCapacity:0];
    while( [results next] )
    {
        HealthEntity* entity  = [[HealthEntity alloc] init];
        entity.recordDate = [results dateForColumnIndex:RECORD_DATE_COLUM];
        entity.red   = [NSNumber numberWithInt:[results intForColumnIndex:RECORD_DATE_COLUM] ];
        entity.green =[NSNumber numberWithInt:[results intForColumnIndex:GREEN_COLUM] ];
        entity.blue =[NSNumber numberWithInt:[results intForColumnIndex:BLUE_COLUM] ];
        entity.healthStatus=[NSNumber numberWithInt:[results intForColumnIndex:HEALTH_STATUS_COLUM] ];
        [entityData addObject:entity];
    }
    [db close];
    return  entityData;
}





@end
