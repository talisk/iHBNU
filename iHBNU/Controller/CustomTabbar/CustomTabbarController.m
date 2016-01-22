//
//  CustomTabbarController.m
//  自定义tabbar
//
//  Created by Hanguoxiang on 15-1-28.
//  Copyright (c) 2015年 zhangyuanyuan. All rights reserved.
//

#import "CustomTabbarController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define EACH_W(A) ([UIScreen mainScreen].bounds.size.width/A)
#define EACH_H (self.tabBar.bounds.size.height)
#define BTNTAG 10000

#import "HomeViewController.h"
#import "UserViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"

@interface CustomTabbarController ()

@property (nonatomic, strong) NSMutableArray *viewControllerMutableArray;

@end

@implementation CustomTabbarController
{
    UIButton *_button;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
            }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self initControllers];
    [self creatTabbar:self.viewControllers.count];
    [self initControllers];
}
#pragma mark - 如果想添加控制器到tabbar里面在这里面实例化就行
- (void)initControllers
{
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    [self addViewControllers:homeVC title:@"首页"];
    
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc]init];
    [self addViewControllers:discoverVC title:@"发现"];
    
    UserViewController *userVC = [[UserViewController alloc]init];
    [self addViewControllers:userVC title:@"我"];


    MoreViewController *moreVC = [[MoreViewController alloc]init];
    [self addViewControllers:moreVC title:@"更多"];

    //  照着上面添加控制球就行了
    
    NSLog(@"%lu",(unsigned long)self.viewControllerMutableArray.count);
}
#pragma  mark - 添加子控制器
- (void)addViewControllers:(UIViewController *)childController title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childController];
    childController.navigationItem.title = title;
    
    [nav.navigationBar setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f]];
    
    //  添加导航栏的背景颜色
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"sy2@2x"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];
}
- (void)creatTabbar:(NSInteger)ControllersNum
{
    //  只需要该图片名字就行
    NSArray * normImage = @[@"fx9@2x",@"gd9@2x",@"fx11@2x",@"fx12@2x"];
    //  只需修改选中图片的名字
    NSArray * selectImage = @[@"sy11@2x",@"fx10@2x",@"wd13@2x",@"gd11@2x"];
    UIImageView *tabbar = [[UIImageView alloc]initWithFrame:self.tabBar.frame];
    tabbar.backgroundColor =  [UIColor whiteColor];
    tabbar.userInteractionEnabled = YES;
    for(int i = 0;i<self.viewControllers.count;i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(EACH_W(self.viewControllers.count)*i, 0, EACH_W(self.viewControllers.count), EACH_H);
        [btn setImage:[UIImage imageNamed:normImage[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectImage[i]] forState:UIControlStateSelected];
        btn.tag = BTNTAG+i;
        [tabbar addSubview:btn];
        if(btn.tag==BTNTAG)
        {
            [self btnSelect:btn];
        }
        [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:tabbar];
    
}
- (void)btnSelect:(UIButton *)sender
{
    NSLog(@"被点了");
    _button.selected =NO ;
    sender.selected = YES;
    _button = sender;
    self.selectedIndex = sender.tag-BTNTAG;
}
@end
