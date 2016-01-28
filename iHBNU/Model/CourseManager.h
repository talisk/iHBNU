//
//  CourseManager.h
//  iHBNU
//
//  Created by 孙恺 on 16/1/23.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Course, CoursePackage;

@protocol CourseManagerDelegate <NSObject>

@optional
- (void)didFetchCoursesData:(NSArray<Course *> *)courses;
- (void)didGetCoursePackages:(NSArray<CoursePackage *> *)coursePackages;

@end

@interface CourseManager : NSObject

@property (nonatomic, weak) id<CourseManagerDelegate> delegate;

+ (instancetype)sharedInstance;
- (Course *)fetchCourse;

@end
