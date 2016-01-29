//
//  WeekScheduleViewController.m
//  iHBNU
//
//  Created by 孙恺 on 15/11/4.
//  Copyright © 2015年 sunkai. All rights reserved.
//

@import AFDateHelper;

#import "AbsenceViewController.h"
#import "DailyTableViewCell.h"
#import <JTCalendar/JTCalendar.h>
#import "WeekScheduleViewController.h"
#import "ZFModalTransitionAnimator.h"

#import "User.h"
#import "LoginViewController.h"
#import "HMFileManager.h"

#import "CourseManager.h"
#import "CourseTime.h"
#import "CoursePackage.h"

@interface WeekScheduleViewController ()<JTCalendarDelegate,UITableViewDataSource,UITableViewDelegate, CourseManagerDelegate>{
    NSMutableDictionary *_eventsByDate;
    
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    
    NSDate *_dateSelected;
    
    NSMutableArray *_datesSelected;
}

@property BOOL mutipleSelect;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) ZFModalTransitionAnimator *animator;

@property (strong, nonatomic) NSMutableArray *dailyDataArray;

@property (strong, nonatomic) UIBarButtonItem *goTodaySwitcherButtonItem;
@property (strong, nonatomic) UIBarButtonItem *askForLeaveButtonItem;
@property (strong, nonatomic) UIBarButtonItem *selectMutipleDayButtonItem;
@property (strong, nonatomic) UIBarButtonItem *weeklyModeSwitcherButtonItem;

@end

@implementation WeekScheduleViewController

#pragma mark - CourseManagerDelegate

- (void)didGetCoursePackages:(NSArray<CoursePackage *> *)coursePackages {
    // todo: refresh ui
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[[NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             [NSMutableArray array],
                                                             ]];
    
//    NSInteger
//    
    for (CoursePackage *course in coursePackages) {
        for (CourseTime *courseTime in course.courseTimes) {
            
        }
    }
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dailyDataArray.count;
    return 5;
}


- (DailyTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DailyTableViewCell";
    
    DailyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DailyTableViewCell" owner:self options:nil] lastObject];
    }
    [cell setCourseName:@"软件工程 - 童强" locateName:@"科教大厦9102" timeText:@"08:00-09:35"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    [self presentAskForLeaveViewController];
}

#pragma mark - Modal View

- (void)presentAskForLeaveViewController {
    AbsenceViewController *absenceVC = [[AbsenceViewController alloc] initWithNibName:@"AbsenceViewController" bundle:[NSBundle mainBundle]];
    absenceVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:absenceVC];
    self.animator.dragable = YES;
    self.animator.bounces = NO;
    self.animator.behindViewAlpha = 0.5f;
    self.animator.behindViewScale = 0.8f;
    self.animator.transitionDuration = 0.7f;
    self.animator.direction = ZFModalTransitonDirectionBottom;
    
    absenceVC.transitioningDelegate = self.animator;
    
    [absenceVC setTitle:@"请假"];
    [self presentViewController:absenceVC animated:YES completion:nil];
}



#pragma mark - Utils

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(!self){
        return nil;
    }
    
    self.title = @"日程";
    
    return self;
}

/*
 *  1. 今天
 *  2. 多选 -> 请假
 *  3. 单选展开日程 -> 时段请假
 *  4. 周视图
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[CourseManager sharedInstance] fetchCourse];
    
    // 登录判断
    NSString *loginKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginkey"];
    User *userModel = [HMFileManager getObjectByFileName:@"userModel"];
    
    NSLog(@"%@",loginKey);
    NSLog(@"%@",userModel);
    
    if (!loginKey.length || !userModel) {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
    }
    
    
    
//    JTCalendarMenuView *calendarTitleView = self.calendarMenuView;
//    
//    [self.calendarMenuView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[calendarTitleView]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(calendarTitleView)]];
    
    self.mutipleSelect = NO;
    _datesSelected = [[NSMutableArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.frame.size.height, 0)];
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.frame.size.height, 0)];
    
    self.dailyDataArray = [[NSMutableArray alloc] init];
    
    self.calendarManager = [[JTCalendarManager alloc] init];
    self.calendarManager.delegate = self;
    
    self.calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    
    [self.navigationItem setTitleView:self.calendarMenuView];
    
//    [self.navigationController.navigationBar addSubview:self.calendarMenuView];
//    [self.navigationController.navigationItem setTitleView:self.calendarMenuView];
//    [self.navigationItem setTitleView:self.calendarMenuView];
    
    // Generate random events sort by date using a dateformatter for the demonstration
    [self createRandomEvents];
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_todayDate];
    
    
    [self navigationItemsSet];

    
//    [self.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)navigationItemsSet {
    // weekly switcher
    self.weeklyModeSwitcherButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"周视图" style:UIBarButtonItemStylePlain target:self action:@selector(didChangeModeTouch)];
    
    // today
    self.goTodaySwitcherButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"今天" style:UIBarButtonItemStylePlain target:self action:@selector(didGoTodayTouch)];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:self.goTodaySwitcherButtonItem, self.weeklyModeSwitcherButtonItem, nil]];
    
    self.selectMutipleDayButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"多选" style:UIBarButtonItemStylePlain target:self action:@selector(didSwitchMutipleSelect)];
    self.askForLeaveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"请假" style:UIBarButtonItemStylePlain target:self action:@selector(didAskForLeave)];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:self.selectMutipleDayButtonItem, self.askForLeaveButtonItem, nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didAskForLeave {
    [self presentAskForLeaveViewController];
}

- (void)didSwitchMutipleSelect {
    self.mutipleSelect = !self.mutipleSelect;
    [_datesSelected removeAllObjects];
    _dateSelected = [[NSDate alloc] init];
    [_calendarManager reload];
    if (self.mutipleSelect) {
        [self.selectMutipleDayButtonItem setTitle:@"单选"];
        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:self.selectMutipleDayButtonItem, nil] animated:YES];
    } else {
        [self.selectMutipleDayButtonItem setTitle:@"多选"];
    }
    
}

// set today
- (void)didGoTodayTouch
{
    [_calendarManager setDate:_todayDate];
    _dateSelected = _todayDate;
    _datesSelected = [[NSMutableArray alloc] init];
    [_calendarManager reload];
}

// switch to weekly and monthly
- (void)didChangeModeTouch {
    [self.view layoutIfNeeded];
    
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    [self.weeklyModeSwitcherButtonItem setTitle:@"周视图"];
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
        [self.weeklyModeSwitcherButtonItem setTitle:@"月视图"];
    }
    
    [UIView animateWithDuration:0.5
                     animations:^{
                             self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected mutiple days
    else if([self isInDatesSelected:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected single day
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    if (self.mutipleSelect) {
        
        NSLog(@"mutipleSelect");
        if([self isInDatesSelected:dayView.date]){
            NSLog(@"unSelect");
            [_datesSelected removeObject:dayView.date];
            
            [UIView transitionWithView:dayView
                              duration:.3
                               options:0
                            animations:^{
                                dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                                [_calendarManager reload];
                            } completion:nil];
        }
        else{
            NSLog(@"select");
            [_datesSelected addObject:dayView.date];
            
            dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
            [UIView transitionWithView:dayView
                              duration:.3
                               options:0
                            animations:^{
                                dayView.circleView.transform = CGAffineTransformIdentity;
                                [_calendarManager reload];
                            } completion:nil];
        }
        
        if (_datesSelected.count!=0) {
            NSLog(@"array.count:%lu",(unsigned long)_datesSelected.count);
            [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:self.selectMutipleDayButtonItem, self.askForLeaveButtonItem, nil] animated:YES];
        } else {
            NSLog(@"array.count:%lu",(unsigned long)_datesSelected.count);
            [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:self.selectMutipleDayButtonItem, nil] animated:YES];
        }
        
    } else {
        
        _dateSelected = dayView.date;
        
        // Animation for the circleView
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            dayView.circleView.transform = CGAffineTransformIdentity;
                            [_calendarManager reload];
                        } completion:nil];
    }
    
    
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}



#pragma mark - Date selection

- (BOOL)isInDatesSelected:(NSDate *)date
{
    for(NSDate *dateSelected in _datesSelected){
        if([_calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}

#pragma mark - Fake data

- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
        
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-2];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:2];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}

@end
