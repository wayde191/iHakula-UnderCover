//
//  NSDate+iHAddition.m
//  iHakula
//
//  Created by Wayde Sun on 12/6/12.
//  Copyright (c) 2012 iHakula. All rights reserved.
//

#import "NSDate+iHAddition.h"

@implementation NSDate (iHAddition)

+ (NSString *) timeStringWithInterval:(NSTimeInterval)time{
    
    int distance = [[NSDate date] timeIntervalSince1970] - time;
    NSString *string;
    if (distance < 1){//avoid 0 seconds
        string = @"刚刚";
    }
    else if (distance < 60) {
        string = [NSString stringWithFormat:@"%d秒前", (distance)];
    }
    else if (distance < 3600) {//60 * 60
        distance = distance / 60;
        string = [NSString stringWithFormat:@"%d分钟前", (distance)];
    }
    else if (distance < 86400) {//60 * 60 * 24
        distance = distance / 3600;
        string = [NSString stringWithFormat:@"%d小时前", (distance)];
    }
    else if (distance < 604800) {//60 * 60 * 24 * 7
        distance = distance / 86400;
        string = [NSString stringWithFormat:@"%d天前", (distance)];
    }
    else if (distance < 2419200) {//60 * 60 * 24 * 7 * 4
        distance = distance / 604800;
        string = [NSString stringWithFormat:@"%d周前", (distance)];
    }
    else {
        NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }
        string = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(time)]];
        [dateFormatter release];
        
    }
    return string;
}

- (NSString *)stringWithSeperator:(NSString *)seperator{
	return [self stringWithSeperator:seperator includeYear:YES];
}

// Return the formated string by a given date and seperator.
+ (NSDate *)dateWithString:(NSString *)str formate:(NSString *)formate{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Set timezone, hard code for Swiden : Europe/Stockholm
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
	[formatter setDateFormat:formate];
	NSDate *date = [formatter dateFromString:str];
	[formatter release];
    
	return date;
}

+ (BOOL)isLaterThanToday:(NSString *)dateString withFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:format];
    
    NSDate *today = [NSDate date];
    NSString *todayStr = [formatter stringFromDate:today];
    [formatter release];
    
    if (1 == [dateString compare:todayStr]) {
        return YES;
    }
    
    return NO;
}

- (NSString *)stringWithFormat:(NSString*)format {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:format];
	NSString *string = [formatter stringFromDate:self];
	[formatter release];
	return string;
}

// Return the formated string by a given date and seperator, and specify whether want to include year.
- (NSString *)stringWithSeperator:(NSString *)seperator includeYear:(BOOL)includeYear{
	if( seperator==nil ){
		seperator = @"-";
	}
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	if( includeYear ){
		[formatter setDateFormat:[NSString stringWithFormat:@"yyyy%@MM%@dd",seperator,seperator]];
	}else{
		[formatter setDateFormat:[NSString stringWithFormat:@"MM%@dd",seperator]];
	}
	NSString *dateStr = [formatter stringFromDate:self];
	[formatter release];
	
	return dateStr;
}

// return the date by given the interval day by today. interval can be positive, negtive or zero.
+ (NSDate *)relativedDateWithInterval:(NSInteger)interval{
	return [NSDate dateWithTimeIntervalSinceNow:(24*60*60*interval)];
}

// return the date by given the interval day by given day. interval can be positive, negtive or zero.
- (NSDate *)relativedDateWithInterval:(NSInteger)interval{
	NSTimeInterval givenDateSecInterval = [self timeIntervalSinceDate:[NSDate relativedDateWithInterval:0]];
	return [NSDate dateWithTimeIntervalSinceNow:(24*60*60*interval+givenDateSecInterval)];
}

- (NSString *)weekday{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:locale];
    [locale release];
    
	NSString *weekdayStr = nil;
	[formatter setDateFormat:@"c"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    // That's europe week order
	NSInteger weekday = [[formatter stringFromDate:self] integerValue];
	if( weekday == 1 ){
		weekdayStr = @"Sön";
	}else if( weekday == 2 ){
		weekdayStr = @"Mån";
	}else if( weekday == 3 ){
		weekdayStr = @"Tis";
	}else if( weekday == 4 ){
		weekdayStr = @"Ons";
	}else if( weekday == 5 ){
		weekdayStr = @"Tor";
	}else if( weekday == 6 ){
		weekdayStr = @"Fre";
	}else if( weekday == 7 ){
		weekdayStr = @"Lör";
	}
	[formatter release];
    
	return weekdayStr;
}

- (NSString *)day {
    NSArray *dateArray = [[[self description] substringToIndex:10] componentsSeparatedByString:@"-"];
    return [dateArray objectAtIndex:2];
}

- (NSString *)month {
    NSArray *dateArray = [[[self description] substringToIndex:10] componentsSeparatedByString:@"-"];
    return [dateArray objectAtIndex:1];
}

- (NSString *)year {
    NSArray *dateArray = [[[self description] substringToIndex:10] componentsSeparatedByString:@"-"];
    return [dateArray objectAtIndex:0];
}


@end
