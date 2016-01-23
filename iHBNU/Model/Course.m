//
//  Course.m
//  iHBNU
//
//  Created by 孙恺 on 16/1/23.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "Course.h"

@implementation Course

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"beizhu" : @"beizhu",
             @"beizhu1" : @"beizhu1",
             
             @"userid" : @"id",
             @"courseName" : @"kcm",
             @"venue" : @"skdd",
             @"courseSessionString" : @"sksj",
             @"selectionid" : @"xkkh",
             @"year" : @"xn",
             @"semester" : @"xq"
             };
}

@end
