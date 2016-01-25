//
//  User.m
//  iHBNU
//
//  Created by 孙恺 on 15/10/5.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "User.h"

@implementation User

///**
// *  Public variable.
// */
//@property (nonatomic, copy) NSString *beizhu;
//@property (nonatomic, copy) NSString *beizhu1;
//
//@property (nonatomic, copy) NSString *birthday;
//@property (nonatomic, copy) NSString *userid;
//@property (nonatomic, strong) NSNumber *collegeid;
//@property (nonatomic, strong) NSNumber *majorid;
//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *sex;
//@property (nonatomic, copy) NSString *tel;
//@property (nonatomic, copy) NSString *qq;
//@property (nonatomic, strong) NSNumber *schoolid;
//@property (nonatomic, strong) NSNumber *permissionId;
//
///**
// *  student variable.
// */
//@property (nonatomic, copy) NSString *bigbossId;
//@property (nonatomic, copy) NSString *bossId;
//@property (nonatomic, copy) NSString *myclass;
//
//@property (nonatomic, copy) NSString *message;

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"beizhu" : @"beizhu",
             @"beizhu1" : @"beizhu1",
             
             @"birthday" : @"birthday",
             @"userid" : @"id",
             @"collegeid" : @"collegeId",
             @"majorid" : @"majorId",
             @"schoolid" : @"schoolId",
             @"permissionid" : @"permissionsId",
             @"name" : @"name",
             @"sex" : @"sex",
             @"tel" : @"tel",
             @"qq" : @"qq",
             
             @"bigbossId" : @"bigboosId",
             @"bossId" : @"bossId",
             @"myclass" : @"myclass",
             
             @"message" : @"message"
             };
}

@end
