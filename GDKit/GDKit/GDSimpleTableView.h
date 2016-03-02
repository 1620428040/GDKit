//
//  GDSimpleTableView.h
//  GDSimpleTableView
//
//  Created by 国栋 on 16/1/12.
//  Copyright (c) 2016年 GD. All rights reserved.
//


//适合于单节的简单表视图
#import <UIKit/UIKit.h>

@protocol GDSimpleTableViewDelegate <NSObject>

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath data:(id)theData;

@optional
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath data:(id)theData;
-(NSMutableArray*)refreshData;

@end

@interface GDSimpleTableView : UITableView

@property NSMutableArray *data;

+(GDSimpleTableView*)createWithFrame:(CGRect)frame data:(NSMutableArray*)theData delegate:(id<GDSimpleTableViewDelegate>)theDelegate;

@end
