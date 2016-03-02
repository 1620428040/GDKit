//
//  GDKit.h
//  GDKit
//
//  Created by 国栋 on 16/3/2.
//  Copyright © 2016年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for GDKit.
FOUNDATION_EXPORT double GDKitVersionNumber;

//! Project version string for GDKit.
FOUNDATION_EXPORT const unsigned char GDKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <GDKit/PublicHeader.h>


#pragma make UI部分
#import "GDKit/GDCollectionView.h"//能同时滑动水平和竖直方向的CollectionView
#import "GDKit/GDSimpleTableView.h"//简单的，单节的表视图。有下拉刷新和动态高度
#import "GDKit/GDPageView.h"//图片轮播视图
#import "GDKit/GDSideView.h"//侧边栏
#import "GDKit/ImageCut.h"//切图的一个类
#import "GDKit/GDTB_NViewController.h"//直接设定视图控制器的TabBarController和NavigationController
#import "GDKit/GDTools.h"//调整，打印视图的frame的一些工具
#import "GDKit/GDContainerView.h"//能自动排版的容器视图，尚未完成
#import "GDKit/GDLoginView.h"//登录界面

#pragma mark 后台部分
#import "GDKit/GDRuntime.h"//对运行时机制相关函数的封装
#import "GDKit/GDTree.h"//树形存储结构
#import "GDKit/GDCoreTree.h"

//异步套接字，仍然有些问题，比如会丢失信息
#import "GDKit/GDServer.h"//套接字，服务器端
#import "GDKit/GDClient.h"//套接字，客户端


