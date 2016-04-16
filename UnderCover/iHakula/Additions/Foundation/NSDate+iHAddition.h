//
//  NSDate+iHAddition.h
//  iHakula
//
//  Created by Wayde Sun on 12/6/12.
//  Copyright (c) 2012 iHakula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (iHAddition)

+ (NSString *)timeStringWithInterval:(NSTimeInterval) time;
+ (NSDate *)dateWithString:(NSString *)str formate:(NSString *)formate;
+ (NSDate *)relativedDateWithInterval:(NSInteger)interval;
+ (BOOL)isLaterThanToday:(NSString *)dateString withFormat:(NSString *)format;

- (NSString *)stringWithSeperator:(NSString *)seperator;
- (NSString *)stringWithFormat:(NSString*)format;
- (NSString *)stringWithSeperator:(NSString *)seperator includeYear:(BOOL)includeYear;
- (NSDate *)relativedDateWithInterval:(NSInteger)interval ;
- (NSString *)weekday;
- (NSString *)day;
- (NSString *)month;
- (NSString *)year;

@end
