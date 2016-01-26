//
//  CourseTime.m
//  iHBNU
//
//  Created by 孙恺 on 16/1/25.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "CourseTime.h"

@implementation CourseTime

- (NSString *)description {
    return [NSString stringWithFormat:@"%@\n\tweekday:%@\n\tsequence:%@\n\tstartWeek:%@\n\tendWeek:%@\n\toddWeak:%i\n\tevenWeak:%i",[super description], self.weekday,self.sequence,self.startWeek,self.endWeek,self.oddWeek,self.evenWeek];
}

@end
