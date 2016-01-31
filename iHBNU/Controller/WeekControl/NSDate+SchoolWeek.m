//
//  NSDate+SchoolWeek.m
//  iHBNU
//
//  Created by 孙恺 on 16/1/31.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "NSDate+SchoolWeek.h"
#import <DateTools/DateTools.h>

@implementation NSDate (SchoolWeek)

+ (NSDate *)semesterBeginning {
    // todo: Replace by real data.
    return [NSDate dateWithYear:2016 month:1 day:11];
}

+ (NSUInteger)semesterWeeksCount {
    // todo: Replace by real data.
    return 20;
}

+ (NSDate *)semesterEnding {
    // Fake data
    return [[self semesterBeginning] dateByAddingWeeks:[self semesterWeeksCount]];
}

+ (NSUInteger)semesterDaysCount {
    return [self semesterWeeksCount] * 7;
}

@end
