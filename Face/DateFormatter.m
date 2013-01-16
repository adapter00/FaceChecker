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
    if (recordDate !=nil) {
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"]; 
        
        return  [formatter stringFromDate:recordDate];
    }
    return 0;
}

+(NSDate *)stringFormatterWithDate:(NSString *)dateString{
    if (dateString !=nil) {
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"]; 
        NSDate *date=[formatter dateFromString:dateString];
        return date;
    }
    return 0;
}


@end
