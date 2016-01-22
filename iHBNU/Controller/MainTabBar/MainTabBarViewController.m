//
//  MainTabBarViewController.m
//  iHBNU
//
//  Created by 孙恺 on 15/10/9.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "MainTabBarViewController.h"

#import "HomeViewController.h"
#import "UserViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"

#import "WeekScheduleViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
//    [self addChildViewController:homeVC title:@"请假" iconName:@"i1"];
    
    WeekScheduleViewController *scheduleVC = [[WeekScheduleViewController alloc] initWithNibName:@"WeekScheduleViewController" bundle:[NSBundle mainBundle]];
//    [self addChildViewControllerWithoutNavigationBar:scheduleVC title:@"日程" iconName:nil];
    [self addChildViewController:scheduleVC title:@"日程" iconName:nil];
/*
 *  旧日程表
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc] initWithNibName:@"DiscoverViewController" bundle:[NSBundle mainBundle]];
    [self addChildViewController:discoverVC title:@"日程" iconName:@"i2"];
 */
    
    
    UserViewController *userVC = [[UserViewController alloc] initWithNibName:@"UserViewController" bundle:[NSBundle mainBundle]];
    [self addChildViewControllerWithoutNavigationBar:userVC title:@"我" iconName:@"i3"];
    
    MoreViewController *moreVC = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:[NSBundle mainBundle]];
    [self addChildViewController:moreVC title:@"更多" iconName:@"i4"];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title iconName:(NSString *)iconName {
    [childController.tabBarItem setImage:[UIImage imageNamed:iconName]];

    [childController setTitle:title];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    [nav.navigationBar setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f]];
    //  添加导航栏的背景颜色
    [self addChildViewController:nav];
}

- (void)addChildViewControllerWithoutNavigationBar:(UIViewController *)childController title:(NSString *)title iconName:(NSString *)iconName {
    [childController.tabBarItem setImage:[UIImage imageNamed:iconName]];
    [childController setTitle:title];
    
    [self addChildViewController:childController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
