//
//  HealthStatusManager.h
//  Face
//
//  Created by 前田 恭男 on 12/12/14.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>


//Viewから健康状態を知るにはここを使用すること
@interface HealthStatusFacade : NSObject


-(id)init;
-(NSNumber *)checkTodayHealth :(UIImage *)image;
-(void)deleteAllData;
-(BOOL)isFace :(UIImage *)image;
@end
