//
//  User.m
//  iHBNU
//
//  Created by 孙恺 on 15/10/5.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "User.h"

@implementation User

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"userid" : @"id",
             @"majorid" : @"majorId",
             @"myclass" : @"myclass",
             
             @"name" : @"name",
             @"sex" : @"sex",
             @"birthday" : @"birthday",
             @"qq" : @"qq",
             @"schoolid" : @"schoolId",
             @"permissionId" : @"permissionsId",
             @"tel" : @"tel",
             
             @"beizhu" : @"beizhu",
             @"bigbossId" : @"bigboosId",
             @"bossId" : @"bossId",
             
             @"message" : @"message"
             };
}

@end
