//
//  UserViewController.m
//  iHBNU
//
//  Created by 孙恺 on 15/10/6.
//  Copyright © 2015年 sunkai. All rights reserved.
//

#import "UserViewController.h"
#import "OTCover.h"

@interface UserViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic)  OTCover *otcoverView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fakeKeyArraySet];
    [self fakeValueArraySet];
    
    [self otcoverSet];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fake Data

- (void)fakeKeyArraySet {
    self.userDataSourceKeyArray = [NSArray arrayWithObjects:@"姓名", @"学号", @"学院", @"专业", @"班级", nil];
}

- (void)fakeValueArraySet {
    self.userDataSourceValueArray = [NSArray arrayWithObjects:@"孙恺", @"2013115010148", @"计算机科学与技术学院", @"计算机科学与技术", @"1301", nil];
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
    return [UIScreen mainScreen].bounds.size.height/6.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userDataSourceKeyArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    [cell.textLabel setText:self.userDataSourceKeyArray[indexPath.row]];
    [cell.detailTextLabel setText:self.userDataSourceValueArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self.otcoverView.tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
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
