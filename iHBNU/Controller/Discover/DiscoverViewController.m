//
//  DiscoverViewController.m
//  iHBNU
//
//  Created by 孙恺 on 15/10/6.
//  Copyright © 2015年 sunkai. All rights reserved.
//


#import "DiscoverViewController.h"

#define kWidth 100
#define kHeight 40
#define kCount 7
#import "HeadView.h"
#import "TimeView.h"
#import "MyCell.h"
#import "MeetModel.h"

#define screenWidth [UIScreen mainScreen].bounds.size

@interface DiscoverViewController () <UITableViewDataSource,UITableViewDelegate,MyCellDelegate>


@property (nonatomic,strong) UIView *myHeadView;
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) TimeView *timeView;
@property (nonatomic,strong) NSMutableArray *meets;
@property (nonatomic,strong) NSMutableArray *currentTime;

@end

@implementation DiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self oldTableViewSet];
    
}



#pragma mark - Time Table

-(void)initData
{
    self.meets=[NSMutableArray array];
    self.currentTime=[NSMutableArray array];
    for(int i=0;i<10;i++){
        
        MeetModel *meet=[[MeetModel alloc]init];
        meet.meetRoom=[NSString stringWithFormat:@"%03d",i];
        int currentTime=i*30+520;
        NSString *time=[NSString stringWithFormat:@"%d:%02d",currentTime/60,currentTime%60];
        meet.meetTime=time;
        [self.meets addObject:meet];
    }
}

- (void)oldTableViewSet {
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *tableViewHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kCount*kWidth, kHeight)];
    self.myHeadView=tableViewHeadView;
    
    for(int i=0;i<kCount;i++){
        
        HeadView *headView=[[HeadView alloc]initWithFrame:CGRectMake(i*kWidth, 0, kWidth, kHeight)];
        headView.num=[NSString stringWithFormat:@"%03d",i];
        headView.detail=@"查看会议室安排";
        headView.backgroundColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [tableViewHeadView addSubview:headView];
    }
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-self.myHeadView.frame.size.height) style:UITableViewStylePlain];
    tableView.contentSize = CGSizeMake(0, 0);
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.bounces=NO;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView=tableView;
    tableView.backgroundColor=[UIColor whiteColor];
    
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(kWidth*0.7, 0, self.view.frame.size.width-kWidth*0.7, [UIScreen mainScreen].bounds.size.height)];
    [myScrollView addSubview:tableView];
    myScrollView.bounces=NO;
    myScrollView.contentSize=CGSizeMake(kWidth*9,0);
    [self.view addSubview:myScrollView];
    
    self.timeView=[[TimeView alloc]initWithFrame:CGRectMake(0, 100, kWidth*0.7, kCount*(kHeight+kHeightMargin))];
    [self.view addSubview:self.timeView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    
    MyCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        
        cell=[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate=self;
        cell.backgroundColor=[UIColor grayColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [self.currentTime removeAllObjects];
    for(MeetModel *model in self.meets){
        
        NSArray *timeArray=[ model.meetTime componentsSeparatedByString:@":"];
        int min=[timeArray[0] intValue]*60+[timeArray[1] intValue];
        int currentTime=indexPath.row*30+480;
        if(min>currentTime&&min<currentTime+30){
            [self.currentTime addObject:model];
        }
    }
    cell.index=indexPath.row;
    cell.currentTime=self.currentTime;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.myHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return kHeight;
}
-(void)myHeadView:(HeadView *)headView point:(CGPoint)point
{
    CGPoint myPoint= [self.myTableView convertPoint:point fromView:headView];
    
    [self convertRoomFromPoint:myPoint];
}
-(void)convertRoomFromPoint:(CGPoint)ponit
{
    NSString *roomNum=[NSString stringWithFormat:@"%03d",(int)(ponit.x)/kWidth];
    int currentTime=(ponit.y-kHeight-kHeightMargin)*30.0/(kHeight+kHeightMargin)+510;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"clicked room"
                                                 message:[NSString stringWithFormat:@"time :%@ room :%@",[NSString stringWithFormat:@"%d:%02d",currentTime/60,currentTime%60],roomNum]
                                                delegate:nil
                                       cancelButtonTitle:@"cancel"
                                       otherButtonTitles:@"ok", nil];
    [alert show];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY= self.myTableView.contentOffset.y;
    CGPoint timeOffsetY=self.timeView.timeTableView.contentOffset;
    timeOffsetY.y=offsetY;
    self.timeView.timeTableView.contentOffset=timeOffsetY;
    if(offsetY==0){
        self.timeView.timeTableView.contentOffset=CGPointZero;
    }
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
