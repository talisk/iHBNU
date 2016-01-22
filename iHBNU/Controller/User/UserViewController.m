//
//  UserViewController.m
//  iHBNU
//
//  Created by 孙恺 on 15/10/6.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "UserViewController.h"
#import "OTCover.h"
#import "User.h"
#import "HMFileManager.h"

#import "LoginViewController.h"

@interface UserViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic)  OTCover *otcoverView;
@property (strong, nonatomic) User *userModel;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userModel = [HMFileManager getObjectByFileName:@"userModel"];
    
    [self keyArraySet];
    [self valueArraySet];
    
    [self otcoverSet];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"viewDidAppear");
    
    self.userModel = [HMFileManager getObjectByFileName:@"userModel"];
    [self valueArraySet];
    [self.otcoverView.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fake Data

- (void)keyArraySet {
    self.userDataSourceKeyArray = [NSArray arrayWithObjects:@"姓名", @"性别", @"出生日期", @"学号", @"学院班级", @"电话", @"QQ", nil];
}

- (void)valueArraySet {
    User *temp = self.userModel;

//    NSLog(@"%@",)
    self.userDataSourceValueArray = [NSArray arrayWithObjects:
                                     (temp.name.length?temp.name:@"无数据"),
                                     (temp.sex.length?temp.sex:@"无数据"),
                                     (temp.birthday.length?temp.birthday:@"无数据"),
                                     (temp.userid.length?temp.userid:@"无数据"),
                                     (temp.myclass.length?temp.myclass:@"无数据"),
                                     (temp.tel.length?temp.tel:@"无数据"),
                                     (temp.qq.length?temp.qq:@"无数据"),
                                     nil];
}

#pragma mark - OTCover Set

- (void)otcoverSet {
    self.otcoverView = [[OTCover alloc] initWithTableViewWithHeaderImage:[UIImage imageNamed:@"header2.png"] withOTCoverHeight:[UIScreen mainScreen].bounds.size.width];
    
    self.otcoverView.tableView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 0, self.tabBarController.tabBar.frame.size.height, 0);
    self.otcoverView.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 0, self.tabBarController.tabBar.frame.size.height, 0);
    
    self.otcoverView.tableView.delegate = self;
    self.otcoverView.tableView.dataSource = self;
    
    [self.view addSubview:self.otcoverView];
}

#pragma mark - TableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userDataSourceKeyArray.count+1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
    }
    
    if (indexPath.row == self.userDataSourceValueArray.count) {
        [cell.textLabel setText:@"注销帐号"];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell setBackgroundColor:[UIColor redColor]];
        [cell setUserInteractionEnabled:YES];
        [cell setSelected:NO];
    } else {
        [cell.textLabel setText:self.userDataSourceKeyArray[indexPath.row]];
        [cell.detailTextLabel setText:self.userDataSourceValueArray[indexPath.row]];
        [cell setUserInteractionEnabled:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self.otcoverView.tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    if (indexPath.row == self.userDataSourceKeyArray.count) {
        [self logout];
        
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
}

- (void)logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginkey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [HMFileManager removeAllFiles];
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
