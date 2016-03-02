//
//  NewsViewController.m
//  News
//
//  Created by 国栋 on 16/2/19.
//  Copyright © 2016年 GD. All rights reserved.
//
#define sw ([UIScreen mainScreen].bounds.size.width)
#define sh ([UIScreen mainScreen].bounds.size.height)
#define vw (self.frame.size.width)
#define vh (self.frame.size.height)

#import "NewsViewController.h"

@interface NewsViewController ()

@property SideView *sideView;
@property UITableView *table;
@property NSArray<News*>* newsList;
@property CollectionView *collection;
@property ListView *list;
@property int time;//视图切换的次数：0，1，2

@end

@implementation NewsViewController
@synthesize sideView,table,collection,list,newsList,time;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"类型" style:UIBarButtonItemStyleDone target:self action:@selector(openSideView)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"切换" style:UIBarButtonItemStyleDone target:self action:@selector(changeView)];
    [NewsTypeManager share].delegate=self;
    [NewsManager share].delegate=self;
    newsList=[NewsManager share].newsList;
    
    time=0;
    [self changeView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark 在列表模式和图片模式之间切换
-(void)changeView
{
    if (time<2) {
        time++;
    }
    if (collection==nil){
        [UIView animateWithDuration:0.5 animations:^{
            list.alpha=0;
        } completion:^(BOOL finished) {
            [list removeFromSuperview];
            list=nil;
            [self createCollectionView];
            [UIView animateWithDuration:0.5 animations:^{
                collection.alpha=1;
            }];
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            collection.alpha=0;
        } completion:^(BOOL finished) {
            [collection removeFromSuperview];
            collection=nil;
            [self createListView];
            [UIView animateWithDuration:0.5 animations:^{
                list.alpha=1;
            }];
        }];
    }
}
-(CGRect)mainViewFrame
{
    if (time==1) {
        return [UIScreen mainScreen].bounds;
    }
    else
    {
        return CGRectMake(0, 64, sw, sh-104);
    }
}
-(void)createListView
{
    list=[ListView createWithFrame:[self mainViewFrame] data:newsList delegate:self];
    [self.view addSubview:list];
}
-(void)createCollectionView
{
    collection=[CollectionView createWithFrame:[self mainViewFrame] data:newsList delegate:self];
    [self.view addSubview:collection];
}
#pragma mark 列表模式和图片模式通用的操作
-(void)tryRunBlockOnMainThread:(void(^)(void))block
{
    if ([NSThread isMainThread]==YES) {
        block();
    }
    else
    {
        [self performSelectorOnMainThread:@selector(runBlockOnMainThread:) withObject:block waitUntilDone:YES];
    }
    
}
-(void)runBlockOnMainThread:(void(^)(void))block
{
    block();
}
-(UIScrollView<MainDisplayProtocol>*)currentMainDisplayView
{
    if (collection!=nil) {
        return collection;
    }
    if (list!=nil) {
        return list;
    }
    return nil;
}
-(void)refreshNewsList
{
    [self tryRunBlockOnMainThread:^{
        [collection reloadData];
        [list reloadData];
    }];
}

#pragma mark MainDisplayDelegate
-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *details=[DetailsViewController new];
    details.currentNews=[NewsManager share].newsList[indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
}

#pragma mark 侧边栏-新闻类型列表
-(void)openSideView
{
    if (sideView==nil) {
        sideView=[[SideView alloc]initWithDelegate:self frame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-104)];
        [self.view addSubview:sideView];
    }
    [self.view bringSubviewToFront:sideView];
    [sideView touchButton];
}
-(UIView *)leftView
{
    table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, self.view.frame.size.height-64)];
    table.dataSource=self;
    table.delegate=self;
    return table;
}
#pragma mark 侧边栏上的表视图
-(void)refreshNewsTypeList
{
    [table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NewsTypeManager share].newsTypeList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    cell.textLabel.text=[NewsTypeManager share].newsTypeList[indexPath.row].name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [sideView touchButton];
    [[NewsManager share]changeChannelId:[NewsTypeManager share].newsTypeList[indexPath.row].channelId];
}


@end
