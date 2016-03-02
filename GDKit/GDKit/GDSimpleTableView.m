//
//  GDSimpleTableView.m
//  GDSimpleTableView
//
//  Created by 国栋 on 16/1/12.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDSimpleTableView.h"

@interface GDSimpleTableView()<UITableViewDataSource,UITableViewDelegate>

@property id<GDSimpleTableViewDelegate>trueDelegate;
@property UIRefreshControl *refresh;
@property float height;

@end

@implementation GDSimpleTableView
@synthesize data,trueDelegate,refresh,height;

+(GDSimpleTableView *)createWithFrame:(CGRect)frame data:(NSMutableArray *)theData delegate:(id<GDSimpleTableViewDelegate>)theDelegate
{
    GDSimpleTableView *tableView=[[self alloc]initWithFrame:frame];
    tableView.delegate=tableView;
    tableView.dataSource=tableView;
    tableView.trueDelegate=theDelegate;
    tableView.data=theData;
    tableView.height=44;
    
    //创建刷新控制器
    tableView.refresh=[[UIRefreshControl alloc]init];
    [tableView.refresh addTarget:tableView action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    tableView.refresh.attributedTitle=[[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [tableView addSubview:tableView.refresh];
    return tableView;
}

#pragma mark 基本设定
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [trueDelegate tableView:tableView cellForRowAtIndexPath:indexPath data:data[indexPath.row]];
}

//选择cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([trueDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:data:)]) {
        [trueDelegate tableView:tableView didSelectRowAtIndexPath:indexPath data:data[indexPath.row]];
    }
}

//对表视图的移动删除等操作
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [data removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    id move=[data objectAtIndex:fromIndexPath.row];
    [data removeObject:move];
    [data insertObject:move atIndex:toIndexPath.row];
    [tableView reloadData];
}

//下拉刷新的操作
-(void)refreshTableView
{
    if (refresh.refreshing)//检测是否在刷新中
    {
        refresh.attributedTitle=[[NSAttributedString alloc]initWithString:@"加载中..."];
    }
    if ([trueDelegate respondsToSelector:@selector(refreshData)]) {
        data=[trueDelegate refreshData];
    }
    [self reloadData];
    //数据更新后
    [refresh endRefreshing];//结束刷新的状态
    refresh.attributedTitle=[[NSAttributedString alloc]initWithString:@"下拉刷新"];//复原提示的文本
}
@end
