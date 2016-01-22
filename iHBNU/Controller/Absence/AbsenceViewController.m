//
//  AbsenceViewController.m
//  iHBNU
//
//  Created by 孙恺 on 15/11/5.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "AbsenceViewController.h"

@interface AbsenceViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *fullScreenView;
@property (weak, nonatomic) IBOutlet UIView *absenceView;
@property (weak, nonatomic) IBOutlet UINavigationBar *naviBar;

@property (weak, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *absenceTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *parentsPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextView *resonTextView;

@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation AbsenceViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startTimeTextField.delegate = self;
    self.endTimeTextField.delegate = self;
    
    self.datePicker = [[UIDatePicker alloc] init];
    
    [self.startTimeTextField setInputView:self.datePicker];
    [self.endTimeTextField setInputView:self.datePicker];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.fullScreenView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *emptyTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    
    [self.naviBar addGestureRecognizer:emptyTap];
    [self.absenceView addGestureRecognizer:emptyTap];
    
    [self.resonTextView.layer setCornerRadius:5.0f];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: Web request
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSDateFormatter *dateFormtter=[[NSDateFormatter alloc] init];
    [dateFormtter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    [textField setText:[dateFormtter stringFromDate:self.datePicker.date]];
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
