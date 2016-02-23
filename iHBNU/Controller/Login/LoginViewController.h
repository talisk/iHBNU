//
//  LoginViewController.h
//  iHBNU
//
//  Created by 孙恺 on 15/10/5.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, iHBNULoginErrorType) {
    iHBNUPasswordWrong,
    iHBNULoginNetworkError,
    iHBNUOtherError
};

@protocol LoginStateDelegate <NSObject>

@optional

- (void)didLoginSuccessfully;
- (void)didLoginFailedWithError:(NSError *)error;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, weak) id<LoginStateDelegate> delegate;

+ (instancetype)sharedInstance;

@end
