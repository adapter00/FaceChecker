//
//  HealthDto.h
//  Face
//
//  Created by takao maeda on 2012/12/09.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HealthDto :NSObject

@property int healthStatus;
@property int red;
@property int blue;
@property int green;
@property NSDate *recordDate;

-(id)initWithRGB :(int)r  green:(int)g blue:(int)b;


@end
