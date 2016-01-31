//
//  NSDate+SchoolWeek.h
//  iHBNU
//
//  Created by 孙恺 on 16/1/31.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SchoolWeek)

+ (NSDate *)semesterBeginning;
+ (NSDate *)semesterEnding;

+ (NSUInteger)semesterWeeksCount;
+ (NSUInteger)semesterDaysCount;

@end
