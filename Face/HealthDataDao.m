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

static NSString *const SELECT_ALL_SQL=@"SELECT recordDate,RED,GREEN,BLUE,HEALTHSTATUS FROM healthData";

static NSString *const DELETE_ALL_DATA=@"DELETE FROM healthData";

//DBファイル名

static NSString *const FILE_NAME=@"healthData.sqlite";

//テーブルのカラム番号
enum COLUM_NUMBER {
    RECORD_DATE_COLUM = 0,
    RED_COLUM = 1,
    GREEN_COLUM=2,
    BLUE_COLUM=3,
    HEALTH_STATUS_COLUM=4
};



@interface HealthDataDao (){
    NSString *sql;
}

@property FMDatabase *db;

@end


@implementation HealthDataDao
@synthesize db;

-(id)init{
    if (self =[super init]) {
        //テーブルが存在しないときはここで生成しておく
        
        NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
        NSString*   dir   = [paths objectAtIndex:0];
        NSLog(@"dir:%@",dir);
        db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:FILE_NAME]];
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
    [db executeUpdate:sql,entity.recordDate,entity.red,entity.green,entity.blue,entity.healthStatus];
    [db close];
    
    
}

-(NSMutableArray *)selectAllData{
    
    sql = SELECT_ALL_SQL;
    
    [db open];
    FMResultSet *results = [db executeQuery:sql];
    NSMutableArray* entityData   = [[NSMutableArray alloc] initWithCapacity:0];
    while( [results next] ){
        HealthEntity* entity  = [[HealthEntity alloc] init];
        entity.recordDate = [results stringForColumnIndex:RECORD_DATE_COLUM];
        entity.red   = [NSNumber numberWithInt:[results intForColumnIndex:RED_COLUM]];
        entity.green =[NSNumber numberWithInt:[results intForColumnIndex:GREEN_COLUM]];
        entity.blue =[NSNumber numberWithInt:[results intForColumnIndex:BLUE_COLUM]];
        entity.healthStatus=[NSNumber numberWithInt:[results intForColumnIndex:HEALTH_STATUS_COLUM] ];
        [entityData addObject:entity];
    }
    
    [db close];
    
    return  entityData;
}

-(void)deleteAllData{    
    
    sql=DELETE_ALL_DATA;
    [db open];
    if ([db open]) {
        [db executeUpdate:sql];    
    }    
    [db close];
    
}




@end
