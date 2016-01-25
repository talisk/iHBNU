//
//  CoursePackage.h
//  iHBNU
//
//  Created by 孙恺 on 16/1/25.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseTime.h"

@interface CoursePackage : NSObject

/**
 *  Public variable.
 */
@property (nonatomic, copy) NSString *courseid;     // 课程标识
@property (nonatomic, copy) NSString *courseName;   // 课程名
@property (nonatomic, copy) NSString *year;         // 学年
@property (nonatomic, copy) NSString *semester;     // 学期
@property (nonatomic, strong) NSArray<NSString *> *classroom;       // 教室名数组
@property (nonatomic, strong) NSArray<CourseTime *> *courseTimes;   // 上课时间数组

/**
 *  Student's variable.
 */
@property (nonatomic, copy) NSString *studentid;    // 学生ID

/**
 *  Teacher's variable.
 */
@property (nonatomic, copy) NSString *teacherid;    // 教师ID
@property (nonatomic, copy) NSString *courseProperty;     // 课程属性
@property (nonatomic, copy) NSString *academy;      // 开课学院
@property (nonatomic, copy) NSString *courseCode;     // 课程属性
@property (nonatomic, strong) NSNumber *studentCount; // 学生数
@property (nonatomic, strong) NSArray<NSString *> *classes; // 班级

@end
