//
//  CourseManager.h
//  iHBNU
//
//  Created by 孙恺 on 16/1/23.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@interface CourseManager : NSObject

+ (instancetype)sharedInstance;
- (Course *)fetchCourse;

@end
