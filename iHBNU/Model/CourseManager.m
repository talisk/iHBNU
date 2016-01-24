//
//  CourseManager.m
//  iHBNU
//
//  Created by 孙恺 on 16/1/23.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import "Request.h"

#import "SVProgressHUD.h"

#import "CourseManager.h"
#import "Course.h"
#import "User.h"
#import "HMFileManager.h"

@interface CourseManager ()

@property (nonatomic, strong) User *userModel;

@end

@implementation CourseManager

- (Course *)fetchCourse {
    
    self.userModel = [HMFileManager getObjectByFileName:@"userModel"];
    
    if (self.userModel && self.userModel.beizhu.length && self.userModel.userid.length) {
        NSArray *keyArray = @[@"username",@"beizhu",@"choose"];
        // choose: 1teacher, 0student
        
        NSArray *valueArray = @[self.userModel.userid, self.userModel.beizhu, @"0"];
        
        NSString *urlString = @"http://115.29.40.230:8080/olschool/UserClass";
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray];
        
        [Request requestGETWithRequestURL:urlString WithParameter:dic WithReturnValeuBlock:^(id returnValue) {
            
            if ([(NSArray *)returnValue count] == 1 || [(NSArray *)returnValue count] == 0) {
                NSLog(@"无数据");
                [SVProgressHUD showErrorWithStatus:@"未查询到数据" maskType:SVProgressHUDMaskTypeGradient];
            } else if ([(NSArray *)returnValue count]) {
            
                NSError *mtlError;
                
                NSMutableArray<Course *> *courseArray = [NSMutableArray array];
                
                for (NSDictionary *courseDic in (NSArray *)returnValue) {
                    Course *courseModel = [MTLJSONAdapter modelOfClass:Course.class fromJSONDictionary:courseDic error:&mtlError];
                    
                    if (mtlError) {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"发生错误:%@",mtlError.description] maskType:SVProgressHUDMaskTypeGradient];
                        NSLog(@"%@",mtlError.description);
                    } else {
                        [courseArray addObject:courseModel];
                        NSLog(@"Add new model: %@",courseModel);
                    }
                }
                
                [HMFileManager saveObject:courseArray byFileName:@"courseModel"];
                NSLog(@"保存成功");
                NSLog(@"%@",courseArray);
            }
            
        } WithErrorCodeBlock:^(id errorCode) {
            NSLog(@"%@",errorCode);
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"发生错误:%@",errorCode] maskType:SVProgressHUDMaskTypeGradient];
        } WithFailureBlock:^{
            NSLog(@"网络异常");
            [SVProgressHUD showErrorWithStatus:@"网络异常" maskType:SVProgressHUDMaskTypeGradient];
        }];
        
    }
    
    return nil;
}

+ (instancetype)sharedInstance {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
