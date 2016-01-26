//
//  CourseTime.h
//  iHBNU
//
//  Created by 孙恺 on 16/1/25.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseTime : NSObject

@property (nonatomic, strong) NSNumber *weekday; // 星期几 1,2,3,4,5,6,7
@property (nonatomic, strong) NSArray<NSNumber *> *sequence; // 第几节课 1,2,3,4,5,6,7,8,9,10
@property (nonatomic, strong) NSNumber *startWeek; // 开始周 1,2,3,4,5,6,7...
@property (nonatomic, strong) NSNumber *endWeek; // 结束周 1,2,3,4,5,6,7...

@property BOOL oddWeek;
@property BOOL evenWeek;

@end
