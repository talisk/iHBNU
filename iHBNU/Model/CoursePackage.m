//
//  CoursePackage.m
//  iHBNU
//
//  Created by 孙恺 on 16/1/25.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "CoursePackage.h"

@implementation CoursePackage

- (NSString *)description {
    return [NSString stringWithFormat:@"\n\tcourseid:%@\n\tcourseName:%@\n\tyear:%@\n\tsemester:%@\n\tclassroom:%@\n\tcourseTimes:%@\n\tstudentid:%@\n\tteacherid:%@\n\tcourseProperty:%@\n\tacademy:%@\n\tcourseCode:%@\n\tstudentCount:%@\n\tclasses:%@",self.courseid,self.courseName,self.year,self.semester,self.classroom,self.courseTimes.description,self.studentid,self.teacherid,self.courseProperty,self.academy,self.courseCode,self.studentCount,self.classes];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.courseTimes = [NSMutableArray array];
    }
    return self;
}

@end
