//
//  AbsenceViewController.m
//  iHBNU
//
//  Created by 孙恺 on 15/11/5.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "AbsenceViewController.h"
#import <DateTools/DateTools.h>

@interface AbsenceViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *fullScreenView;
@property (weak, nonatomic) IBOutlet UIView *absenceView;
@property (weak, nonatomic) IBOutlet UINavigationBar *naviBar;

@property (weak, nonatomic) IBOutlet UISegmentedControl *absenceTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *parentsPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextView *resonTextView;

@property (strong, nonatomic) UIDatePicker *datePicker0;
@property (strong, nonatomic) UIDatePicker *datePicker1;

@end

@implementation AbsenceViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startTimeTextField.delegate = self;
    self.endTimeTextField.delegate = self;
    
    [self.startTimeTextField setTextAlignment:NSTextAlignmentCenter];
    [self.endTimeTextField setTextAlignment:NSTextAlignmentCenter];
    
    self.datePicker0 = [[UIDatePicker alloc] init];
    [self.datePicker0 addTarget:self action:@selector(dateChange0:) forControlEvents:UIControlEventValueChanged];
    
    self.datePicker1 = [[UIDatePicker alloc] init];
    [self.datePicker1 addTarget:self action:@selector(dateChange1:) forControlEvents:UIControlEventValueChanged];
    
    [self.startTimeTextField setInputView:self.datePicker0];
    [self.endTimeTextField setInputView:self.datePicker1];
    
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

#pragma mark - DatePicker date changed

- (void)dateChange0:(id)sender {
    [self.startTimeTextField setText:[((UIDatePicker *)sender).date formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss" timeZone:[NSTimeZone timeZoneWithName:@"GMT+0800"]]];
}

- (void)dateChange1:(id)sender {
    [self.endTimeTextField setText:[((UIDatePicker *)sender).date formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss" timeZone:[NSTimeZone timeZoneWithName:@"GMT+0800"]]];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField setText:[((UIDatePicker *)textField.inputView).date formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss" timeZone:[NSTimeZone timeZoneWithName:@"GMT+0800"]]];
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
