//
//  LoginViewController.m
//  iHBNU
//
//  Created by 孙恺 on 15/10/5.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "Request.h"

#import "SVProgressHUD.h"

#import "LoginViewController.h"
#import "ASTextField.h"
#import "DeviceToolbox.h"
#import "AFViewShaker.h"

#import "User.h"
#import "HMFileManager.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBTN;
@property (weak, nonatomic) IBOutlet ASTextField *userIDTextField;
@property (weak, nonatomic) IBOutlet ASTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self overallUISetting];
    [self textFieldAndLoginButtonSetting];
}

- (void)overallUISetting {
//    [self.view setBackgroundColor:[UIColor darkGrayColor]];
}

- (void)textFieldAndLoginButtonSetting {
    // set delegate
    self.userIDTextField.delegate = self;
    self.passwordTextField.delegate = self;
    

    
    [self.loginBTN setBackgroundColor:[UIColor lightGrayColor]];
    [self.loginBTN.layer setCornerRadius:10.0f];
    
    [self.userIDTextField setupTextFieldWithIconName:@"user_name_icon"];
    [self.passwordTextField setupTextFieldWithIconName:@"password_icon"];
    
    [self.userIDTextField setTag:0];
    [self.passwordTextField setTag:1];
}

- (IBAction)pressBTN:(id)sender {
    
    if (self.userIDTextField.text.length!=0&&self.passwordTextField.text.length!=0) {
        
        NSLog(@"%@,%@",self.userIDTextField.text,self.passwordTextField.text);
        
        NSArray *keyArray = @[@"username",@"password",@"choose"];
        // choose: 1teacher, 0student
        
        NSArray *valueArray = @[self.userIDTextField.text, self.passwordTextField.text, [NSString stringWithFormat:@"%li",self.segmentControl.selectedSegmentIndex]];
        
        NSString *urlString = @"http://115.29.40.230:8080/olschool/Denglu";
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray];
        
        
        [Request requestPOSTWithRequestURL:urlString WithParameter:dic WithReturnValeuBlock:^(id returnValue) {
            
            NSError *mtlError;
            User *userModel = [MTLJSONAdapter modelOfClass:User.class fromJSONDictionary:returnValue error:&mtlError];
            
            if (mtlError) {
                NSLog(@"%@",mtlError.description);
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"发生错误:%@",userModel.message] maskType:SVProgressHUDMaskTypeGradient];
            } else {
                if (!userModel.message.length) {
                    [[NSUserDefaults standardUserDefaults] setValue:userModel.beizhu forKey:@"loginkey"];
                    [HMFileManager saveObject:userModel byFileName:@"userModel"];
                    if (self.segmentControl.selectedSegmentIndex) {
                        // 教师帐号
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isTeacher"];
                    } else {
                        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isTeacher"];
                    }
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"loginkey"]);
                    
                    [SVProgressHUD showSuccessWithStatus:@"登录成功" maskType:SVProgressHUDMaskTypeGradient];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                } else if ([userModel.message isEqualToString:@"nothing"]) {
                    NSLog(@"帐号或密码错误");
                    [SVProgressHUD showErrorWithStatus:@"帐号或密码错误" maskType:SVProgressHUDMaskTypeGradient];
                } else {
                    NSLog(@"%@", userModel.message);
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"发生错误:%@",userModel.message] maskType:SVProgressHUDMaskTypeGradient];
                }
                
            }
            
            
        } WithErrorCodeBlock:^(id errorCode) {
            NSLog(@"%@",errorCode);
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"发生错误:%@",errorCode] maskType:SVProgressHUDMaskTypeGradient];
        } WithFailureBlock:^{
            NSLog(@"网络异常");
            [SVProgressHUD showErrorWithStatus:@"网络异常" maskType:SVProgressHUDMaskTypeGradient];
        }];
    } else {
        [self emptyTextField];
    }
}

- (void)emptyTextField {
    AFViewShaker *shaker = [[AFViewShaker alloc] initWithViewsArray:[NSArray arrayWithObjects:self.userIDTextField, self.passwordTextField, nil]];
    
    [DeviceToolbox vibrate];
    [shaker shake];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            [textField resignFirstResponder];
            [(ASTextField *)[self.view viewWithTag:1] becomeFirstResponder];
            break;
        case 1:
            [textField resignFirstResponder];
            [self pressBTN:self.loginBTN];
            break;
        default:
            NSLog(@"111");
            break;
    }
    
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
