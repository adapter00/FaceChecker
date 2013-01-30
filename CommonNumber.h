//
//  CommonNumber.h
//  Face
//
//  Created by 前田 恭男 on 13/01/16.
//  Copyright (c) 2013年 前田 恭男. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonNumber : NSObject

//health_statusテーブルのカラム番号
enum COLUM_NUMBER {
    RECORD_DATE_COLUM = 0,
    RED_COLUM = 1,
    GREEN_COLUM = 2,
    BLUE_COLUM = 3,
    HEALTH_STATUS_COLUM = 4
};


//顔情報配列の格納順序
enum  FACE_POSITION{
    MOUTH_POS = 0,
    RIGHTEYE_POS = 1,
    LEFTEYE_POS = 2,
};


//色情報のポインタ
enum  {
    COLOR_POINTER = 4,
    RED_POINTER = 2,
    GREEN_POINTER = 1,
    BLUE_POINTER = 0,
};

//DTOの色の格納順序
enum  {
    RED_DTO = 1,
    GREEN_DTO = 2,
    BLUE_DTO = 3,
};

//HEALTH_STATUSの数字
enum  {
    GOOD_STATUS = 1,
    NORMAL_STATUS = 2,
    WORTH_STATUS = 3,
};

//HEALTH_POINT
enum {
    RED_POINT = 1,
    GREEN_POINT = 10,
    BLUE_POINT = 15,
    TODAY_POINT = 30,
};

//ポイントによる健康度

enum {
    GOOD_MIN = 1,
    GOOD_MAX = 10,
    NORMAL_MIN = 10,
    NORMAL_MAX = 20,
    WORTH_MIN = 20,
    WORHT_MAX = 26,
    
};


//顔色の許容範囲
enum {
    RED_MAX = 255,
    BLUE_MAX = 220,
    GREEN_MAX = 240,
};

@end
