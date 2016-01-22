//
//  Request.h
//  iHBNU
//
//  Created by 孙恺 on 15/11/1.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(BOOL netConnetState);

@interface Request : NSObject

#pragma 监测网络的可链接性
+ (BOOL)netWorkReachabilityWithURLString:(NSString *) strUrl;

#pragma POST请求
+ (void)requestPOSTWithRequestURL:(NSString *)requestURLString
                    WithParameter:(NSDictionary *)parameter
             WithReturnValeuBlock:(ReturnValueBlock)block
               WithErrorCodeBlock:(ErrorCodeBlock)errorBlock
                 WithFailureBlock:(FailureBlock)failureBlock;

#pragma GET请求
+ (void)requestGETWithRequestURL:(NSString *)requestURLString
                   WithParameter:(NSDictionary *)parameter
            WithReturnValeuBlock:(ReturnValueBlock)block
              WithErrorCodeBlock:(ErrorCodeBlock)errorBlock
                WithFailureBlock:(FailureBlock)failureBlock;

@end