//
//  Course.h
//  iHBNU
//
//  Created by 孙恺 on 16/1/23.
//  Copyright © 2016年 sunkai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Course : MTLModel

@property (nonatomic, copy) NSString *beizhu;
@property (nonatomic, copy) NSString *beizhu1;

@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *courseName;
@property (nonatomic, copy) NSString *venue;
@property (nonatomic, copy) NSString *courseSessionString;
@property (nonatomic, copy) NSString *selectionid;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *semester;

@end
