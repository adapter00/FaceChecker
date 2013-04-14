//
//  CommonString.h
//  Face
//
//  Created by 前田 恭男 on 13/01/16.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonString : NSObject

#define DAY_FOROMAT @"yyyy/MM/dd HH:mm"

//ALERT ERROR
#define ERROR_ALERT_DEVICE_TITLE @"This App Can't Use"
#define ERROR_ALERT_DEVICE_CAMERA @"このデバイスではカメラは使用出来ません"
#define ERROR_ALERT_DEVICE_LIBRARY @"このデバイスではフォトライブラリ−は使用出来ません"
#define ERROR_ALERT_NOFACE_TITLE @"NO FACE"
#define ERROR_ALERT_NOFACE_MESSAGE @"これは顔ではありません"
#define ERROR_ALERT_NOFACE_BUTTON_TITLE @"もう一度撮り直す"
#define DIAGNOSING @"診断中"

//HEALTH STATUS
#define HEALTH_STATUS_MESSAGE @"あなたの健康状態は%@\nになります"
#define HEALTH_STATUS_GOOD @"健康体です"
#define HEALTH_STATUS_SO_GOOD @"まぁ健康体です"
#define HEALTH_STATUS_BAD @"不健康さんです"
#define HEALTH_STATUS_ERROR @"不正確な値になっています"


//COMMON
#define NO_DATA @"NO DATA"
#define JAPANESE @"ja_JP"
#define COMMON_BACK @"戻る"


//HEALTH DATA DAO
#define CREATE_SQL @"CREATE TABLE IF NOT EXISTS healthData (id INTEGER PRIMARY KEY AUTOINCREMENT, recordDate TEXT , RED INTEGER , GREEN INTEGER , BLUE INTEGER, HEALTHSTATUS INTEGER);"
#define INSERT_SQL @"INSERT INTO healthData (recordDate,RED,GREEN,BLUE,HEALTHSTATUS) VALUES (?,?,?,?,?);"
#define SELECT_ALL_SQL @"SELECT recordDate,RED,GREEN,BLUE,HEALTHSTATUS FROM healthData;"
#define DELETE_ALL_DATA @"DELETE FROM healthData;"
#define HEALTH_DATA_NAME @"healthData.sqlite"


@end
