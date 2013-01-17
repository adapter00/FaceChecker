//
//  DateFormatter.m
//  Face
//
//  Created by takao maeda on 2012/12/11.
//  Copyright (c) 2012年 前田 恭男. All rights reserved.
//

#import "DateFormatter.h"
#import "CommonString.h"

@implementation DateFormatter

+(NSString *)dateFormatter:(NSDate *)recordDate{
    if (recordDate !=nil) {
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:DAY_FOROMAT]; 
        
        return  [formatter stringFromDate:recordDate];
    }
    return nil;
}

+(NSDate *)stringFormatterWithDate:(NSString *)dateString{
    if (dateString !=nil) {
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:DAY_FOROMAT]; 
        NSDate *date=[formatter dateFromString:dateString];
        return date;
    }
    return nil;
}


@end
