//
//  DateFormatter.m
//  Face
//
//  Created by takao maeda on 2012/12/11.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

+(NSString *)dateFormatter:(NSDate *)recordDate{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH"];
    
    return  [formatter stringFromDate:recordDate];
}

@end
