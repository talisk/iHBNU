//
//  CourseManager.m
//  iHBNU
//
//  Created by 孙恺 on 16/1/23.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "Request.h"

#import "SVProgressHUD.h"

#import "CourseManager.h"
#import "Course.h"
#import "User.h"
#import "HMFileManager.h"

#import "Course.h"
#import "CoursePackage.h"

#import "LoginViewController.h"

@interface CourseManager ()

@property (nonatomic, strong) User *userModel;

@end

@implementation CourseManager

- (Course *)fetchCourse {
    
    self.userModel = [HMFileManager getObjectByFileName:@"userModel"];
    
    if (self.userModel && self.userModel.beizhu.length && self.userModel.userid.length) {
        NSArray *keyArray = @[@"username",@"beizhu",@"choose"];
        // choose: 1teacher, 0student
        
        NSArray *valueArray = @[self.userModel.userid, self.userModel.beizhu, [[NSUserDefaults standardUserDefaults] boolForKey:@"isTeacher"]?@"1":@"0"];
        
        NSString *urlString = @"http://115.29.40.230:8080/olschool/UserClass";
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray];
        
        [Request requestGETWithRequestURL:urlString WithParameter:dic WithReturnValeuBlock:^(id returnValue) {
            
//            NSLog(@"%@",returnValue);
            
            if ([(NSArray *)returnValue count] == 0) {
                NSLog(@"无数据");
                [SVProgressHUD showErrorWithStatus:@"未查询到数据" maskType:SVProgressHUDMaskTypeGradient];
            } else if ([(NSArray *)returnValue count] == 1) {
                if ([returnValue[@"message"] isEqualToString:@"empty"]) {
                    NSLog(@"无数据");
                    [SVProgressHUD showErrorWithStatus:@"未查询到数据" maskType:SVProgressHUDMaskTypeGradient];
                } else { // 返回值为nothing
                    // todo: 令牌过期
                    NSLog(@"无数据");
                    
                    LoginViewController *lvc = [[LoginViewController alloc] init];
                    
                    [[[UIApplication sharedApplication].windows firstObject].rootViewController presentViewController:lvc animated:YES completion:nil];
                    
                    [SVProgressHUD showErrorWithStatus:@"请重新登录" maskType:SVProgressHUDMaskTypeGradient];
                }
            } else if ([(NSArray *)returnValue count]) {
            
                NSError *mtlError;
                
                NSMutableArray<Course *> *courseArray = [NSMutableArray array];
                
                for (NSDictionary *courseDic in (NSArray *)returnValue) {
                    Course *courseModel = [MTLJSONAdapter modelOfClass:Course.class fromJSONDictionary:courseDic error:&mtlError];
                    
                    if (mtlError) {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"发生错误:%@",mtlError.description] maskType:SVProgressHUDMaskTypeGradient];
                        NSLog(@"%@",mtlError.description);
                    } else {
                        [courseArray addObject:courseModel];
//                        NSLog(@"Add new model: %@",courseModel);
                    }
                }
                
                [HMFileManager saveObject:courseArray byFileName:@"courseModel"];
                NSLog(@"保存成功");
                
                [self.delegate didFetchCoursesData:[NSArray arrayWithArray:courseArray]];
                
                NSMutableArray<CoursePackage *> *coursePackageArray = [NSMutableArray array];
                
                for (Course *course in courseArray) {
                    
                    CoursePackage *coursePackage = [[CoursePackage alloc] init];
                    
                    /**
                     *  Public variable
                     */
                    if (course.courseid) {
                        coursePackage.courseid = course.courseid;
                    }
                    if (course.courseName) {
                        coursePackage.courseName = course.courseName;
                    }
                    if (course.semester) {
                        [course.semester isEqualToString:@"1\r"]?(coursePackage.semester = @"1"):(coursePackage.semester = @"2");
                    }
                    if (course.year) {
                        coursePackage.year = course.year;
                    }
                    
                    if (course.classroom) {
                        coursePackage.classroom = [course.classroom componentsSeparatedByString:@";"];
                    }
                    if (course.courseTimes) {
                        NSArray *timeSubstrings = [course.courseTimes componentsSeparatedByString:@";"];
                        for (NSString *timeSubstring in timeSubstrings) {
                            CourseTime *courseTime = [[CourseTime alloc] init];
                            NSError *error = NULL;
                            /**
                             *  timeSubstring Example
                             *  周三第7,8节{第15-15周|单周}
                             *  周二第9,10节{第5-13周}
                             */
                            
                            // 节做分割切成两个字符串
                            NSArray *jieSubstring = [timeSubstring componentsSeparatedByString:@"节"];
                            
                            // Weekday Array.
                            NSArray *chineseWeekdays = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
                            NSRegularExpression *weekdayRegEx = [NSRegularExpression
                                                                 regularExpressionWithPattern:@"周.第"
                                                                 options:NSRegularExpressionCaseInsensitive
                                                                 error:&error];
                            if (!error) {
                                NSTextCheckingResult *weekResult = [weekdayRegEx firstMatchInString:jieSubstring[0]
                                                                                        options:0
                                                                                          range:NSMakeRange(0, [jieSubstring[0] length])];
                                if (weekResult) {
                                    NSString *chineseWeekdayResult = [timeSubstring substringWithRange:NSMakeRange(weekResult.range.location+1, 1)];
                                    
                                    for (int i=0; i<7; ++i) {
                                        if ([chineseWeekdays[i] isEqualToString:chineseWeekdayResult]) {
                                            courseTime.weekday = [NSNumber numberWithInt:i+1];
                                            break;
                                        }
                                    }
                                }
                            }
                            
                            // Lesson Array.
                            if ([jieSubstring[0] rangeOfString:@","].location != NSNotFound) {
                                NSArray *lessonStrs = [jieSubstring[0] componentsSeparatedByString:@","];
                                NSString *firstLessonStr = [lessonStrs[0] substringFromIndex:3];
                                NSString *secondLessonStr = lessonStrs[1];
//                                NSLog(@"%@ | %@", firstLessonStr, secondLessonStr);
                                courseTime.sequence = @[[NSNumber numberWithInteger:firstLessonStr.integerValue], [NSNumber numberWithInteger:secondLessonStr.integerValue]];
                            } else {
                                courseTime.sequence = @[[NSNumber numberWithInteger:[jieSubstring[0] substringFromIndex:3].integerValue]];
                            }
                            
                            // 单双周|分割
                            if ([jieSubstring[1] rangeOfString:@"|"].location != NSNotFound) {
                                NSArray *parityStrs = [jieSubstring[1] componentsSeparatedByString:@"|"];
                                
                                // 单双周
                                if ([[parityStrs[1] substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"单"]) {
                                    courseTime.oddWeek = YES;
                                    courseTime.evenWeek = NO;
                                } else {
                                    courseTime.oddWeek = NO;
                                    courseTime.evenWeek = YES;
                                }
                                
                                NSArray *dashStrs = [jieSubstring[1] componentsSeparatedByString:@"-"];
                                courseTime.startWeek = [NSNumber numberWithInteger:[dashStrs[0] substringFromIndex:2].integerValue];
                                courseTime.endWeek = [NSNumber numberWithInteger:[dashStrs[1] substringWithRange:NSMakeRange(0, [dashStrs[1] length]-1)].integerValue];
                            } else {
                                // 单双周均有
                                courseTime.oddWeek = YES;
                                courseTime.evenWeek = YES;
                                
                                NSArray *dashStrs = [jieSubstring[1] componentsSeparatedByString:@"-"];
                                courseTime.startWeek = [NSNumber numberWithInteger:[dashStrs[0] substringFromIndex:2].integerValue];
                                courseTime.endWeek = [NSNumber numberWithInteger:[dashStrs[1] substringWithRange:NSMakeRange(0, [dashStrs[1] length]-2)].integerValue];
                            }
                            
                            [coursePackage.courseTimes addObject:courseTime];
//                            NSLog(@"%@",coursePackage.courseTimes[0]);
                        }
                    }

                    /**
                     *  Student's variable
                     */
                    if (course.studentid) {
                        coursePackage.studentid = course.studentid;
                    }
                    
                    /**
                     *  Teacher's variable
                     */
                    if (course.teacherid) {
                        coursePackage.teacherid = course.teacherid;
                    }
                    if (course.courseProperty) {
                        coursePackage.courseProperty = course.courseProperty;
                    }
                    if (course.academy) {
                        coursePackage.academy = course.academy;
                    }
                    if (course.courseCode) {
                        coursePackage.courseCode = course.courseCode;
                    }
                    if (course.studentCount) {
                        coursePackage.studentCount = [NSNumber numberWithInteger:course.studentCount.integerValue];
                    }
                    if (course.classes) {
                        coursePackage.classes = [course.classes componentsSeparatedByString:@";"];
                    }
                    
                    [coursePackageArray addObject:coursePackage];
                    
                }
                
//                NSLog(@"%@", coursePackageArray.description);
                [HMFileManager saveObject:coursePackageArray byFileName:@"coursePackage"];
                [self.delegate didGetCoursePackages:[NSArray arrayWithArray:coursePackageArray]];
                
            }
            
        } WithErrorCodeBlock:^(id errorCode) {
            NSLog(@"%@",errorCode);
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"发生错误:%@",errorCode] maskType:SVProgressHUDMaskTypeGradient];
        } WithFailureBlock:^{
            NSLog(@"网络异常");
            [SVProgressHUD showErrorWithStatus:@"网络异常" maskType:SVProgressHUDMaskTypeGradient];
        }];
        
    }
    
    return nil;
}

+ (instancetype)sharedInstance {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
