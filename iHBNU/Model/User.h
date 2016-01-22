//
//  User.h
//  iHBNU
//
//  Created by 孙恺 on 15/10/5.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface User : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, strong) NSNumber *majorid;
@property (nonatomic, copy) NSString *myclass;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, strong) NSNumber *schoolid;
@property (nonatomic, strong) NSNumber *permissionId;
@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *beizhu;

@property (nonatomic, copy) NSString *bigbossId;
@property (nonatomic, copy) NSString *bossId;

@end
