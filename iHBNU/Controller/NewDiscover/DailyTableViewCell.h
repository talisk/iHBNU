//
//  DailyTableViewCell.h
//  iHBNU
//
//  Created by 孙恺 on 15/11/4.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *courseInfoDic;

- (void)setCourseName:(NSString *)course locateName:(NSString *)locate timeText:(NSString *)timeText;

@end
