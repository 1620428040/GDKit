//
//  NewsManager.h
//  News
//
//  Created by 国栋 on 16/2/25.
//  Copyright © 2016年 GD. All rights reserved.
//

#define NewsListFile @"/Users/guodong/Desktop/other/News/News/LatestNews.plist"

#import <Foundation/Foundation.h>
#import "News.h"

@protocol NewsManagerDelegate <NSObject>
@required
-(void)refreshNewsList;

@end
@interface NewsManager : NSObject

@property id<NewsManagerDelegate>delegate;
@property NSMutableArray<News*> *newsList;
@property NSURLSessionDataTask *downloadTask;
@property NSString *channelId;
@property int page;
@property BOOL isChangePage;//正在下载下一页
@property BOOL isCache;//正在使用缓存的数据

+(instancetype)share;
-(void)changeChannelId:(NSString*)newChannelId;
-(void)nextPage;

@end