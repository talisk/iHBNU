//
//  DeviceToolbox.m
//  iHBNU
//
//  Created by 孙恺 on 15/10/6.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "DeviceToolbox.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation DeviceToolbox

+ (void)vibrate {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
