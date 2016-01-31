//
//  DailyTableViewCell.m
//  iHBNU
//
//  Created by 孙恺 on 15/11/4.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "DailyTableViewCell.h"

@interface DailyTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation DailyTableViewCell

- (void)setCourseName:(NSString *)course locateName:(NSString *)locate timeText:(NSString *)timeText {
    [self.courseNameLabel setText:course];
    [self.locateLabel setText:locate];
    [self.timeLabel setText:timeText];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
