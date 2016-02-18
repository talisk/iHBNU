//
//  NSObject+Extension.m
//  iHBNU
//
//  Created by 孙恺 on 16/2/18.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

- (void)setUserInfo:(NSDictionary *)newUserInfo {
    objc_setAssociatedObject(self, @"userInfo", newUserInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, @"userInfo");
}

@end
