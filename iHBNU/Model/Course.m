//
//  Course.m
//  iHBNU
//
//  Created by 孙恺 on 16/1/23.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "Course.h"

@implementation Course

///**
// *  Public variable.
// */
//@property (nonatomic, copy) NSString *courseid;     // 课程标识
//@property (nonatomic, copy) NSString *courseName;   // 课程名
//@property (nonatomic, copy) NSString *year;         // 学年
//@property (nonatomic, copy) NSString *semester;     // 学期
//@property (nonatomic, copy) NSString *classroom;       // 教室名
//@property (nonatomic, copy) NSString *courseTimes;   // 上课时间
//
///**
// *  Student's variable.
// */
//@property (nonatomic, copy) NSString *studentid;    // 学生ID
//
///**
// *  Teacher's variable.
// */
//@property (nonatomic, copy) NSString *teacherid;    // 教师ID
//@property (nonatomic, copy) NSString *property;     // 课程属性
//@property (nonatomic, copy) NSString *academy;      // 开课学院
//@property (nonatomic, copy) NSString *courseCode;     // 课程属性
//@property (nonatomic, strong) NSNumber *studentCount; // 学生数
//@property (nonatomic, copy) NSString *classes; // 班级
//
//@property (nonatomic, copy) NSString *message;

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"beizhu" : @"beizhu",
             @"beizhu1" : @"beizhu1",
             
             @"courseid" : @"xkkh",
             @"courseName" : @"kcm",
             @"year" : @"xn",
             @"semester" : @"xq",
             @"classroom" : @"skdd",
             @"courseTimes" : @"sksj",
             
             @"studentid" : @"id",
             
             @"teacherid" : @"teaid",
             @"courseProperty" : @"kcxz",
             @"academy" : @"kkxy",
             @"courseCode" : @"kcdh",
             @"studentCount" : @"numpp",
             @"classes" : @"bj",
             
             @"message" : @"message"
             };
}

@end
