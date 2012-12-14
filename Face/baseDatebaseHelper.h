//
//  baseDatebaseHelper.h
//  Face
//
//  Created by 前田 恭男 on 12/12/13.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDto.h"


//データベースの挙動を定義しておくプロトコルメソッド
@protocol baseDatebaseHelper <NSObject>

-(void)insertDatabase:(BaseDto *)dto;
-(NSMutableArray *)selectAllData;
-(NSMutableArray *)selectData:(NSString *)healthDate;


@end
