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

/**
 *  Public variable.
 */
@property (nonatomic, copy) NSString *beizhu;
@property (nonatomic, copy) NSString *beizhu1;

@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, strong) NSNumber *collegeid;
@property (nonatomic, strong) NSNumber *majorid;
@property (nonatomic, strong) NSNumber *schoolid;
@property (nonatomic, strong) NSNumber *permissionid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *qq;


/**
 *  Student variable.
 */
@property (nonatomic, copy) NSString *bigbossId;
@property (nonatomic, copy) NSString *bossId;
@property (nonatomic, copy) NSString *myclass;

@property (nonatomic, copy) NSString *message;

@end
