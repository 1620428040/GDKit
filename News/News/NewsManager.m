//
//  NewsManager.m
//  News
//
//  Created by 国栋 on 16/2/25.
//  Copyright © 2016年 GD. All rights reserved.
//

#import "NewsManager.h"

NewsManager *shareNewsManager;

@implementation NewsManager
@synthesize newsList,delegate,downloadTask,channelId,page,isChangePage,isCache;

+(instancetype)share
{
    if (shareNewsManager==nil) {
        shareNewsManager=[[self alloc]init];
    }
    return shareNewsManager;
}

-(instancetype)init
{
    if (self=[super init]) {
        
        newsList=[NSMutableArray array];
        
        //首先用缓存的列表
        NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:NewsListFile];
        [self objectWithDictionary:dict];
        isCache=YES;
        
        //然后异步更新数据
        channelId=@"5572a108b3cdc86cf39001cd";
        page=1;
        [self performSelectorInBackground:@selector(downloadWithCurrentParameter) withObject:nil];
    }
    return self;
}
-(void)changeChannelId:(NSString *)newChannelId
{
    [newsList removeAllObjects];
    [delegate refreshNewsList];
    page=1;
    channelId=newChannelId;
    [self downloadWithCurrentParameter];
}
-(void)nextPage
{
    if (isChangePage==YES) {
        return;
    }
    isChangePage=YES;
    page++;
    [self downloadWithCurrentParameter];
}
#pragma mark 下载管理
-(void)downloadWithCurrentParameter
{
    if (downloadTask!=nil) {
        [downloadTask cancel];
        downloadTask=nil;
        NSLog(@"取消下载");
    }
    
    NSString *urlStr=[NSString stringWithFormat:@"http://apis.baidu.com/showapi_open_bus/channel_news/search_news?channelId=%@&page=%d",channelId,page];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod: @"GET"];
    [request addValue:@"630fc84391eacf9743084e4ea36beb2f" forHTTPHeaderField:@"apikey"];
    
    //NSLog(@"url=%@",urlStr);
    
    downloadTask=[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            NSLog(@"nothing");
            return;
        }
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (isCache==YES) {
            [newsList removeAllObjects];
            isCache=NO;
        }
        [self objectWithDictionary:dict];
        [delegate refreshNewsList];
        [dict writeToFile:@"/Users/guodong/Desktop/other/News/News/LatestNews.plist" atomically:YES];
        //NSLog(@"加载结束%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        downloadTask=nil;
        isChangePage=NO;
    }];
    [downloadTask resume];
}
-(void)objectWithDictionary:(NSDictionary*)dict
{
    NSArray *dictArr=[[[dict objectForKey:@"showapi_res_body"]objectForKey:@"pagebean"]objectForKey:@"contentlist"];
    if (dictArr==nil||dictArr.count==0) {
        NSLog(@"没有获得更新。。。");
        return;
    }
    for (NSDictionary *current in dictArr) {
        News *new=[News new];
        new.channelId=[current objectForKey:@"channelId"];
        new.channelName=[current objectForKey:@"channelName"];
        new.desc=[current objectForKey:@"desc"];
        new.link=[current objectForKey:@"link"];
        new.pubDate=[current objectForKey:@"pubDate"];
        new.source=[current objectForKey:@"source"];
        new.title=[current objectForKey:@"title"];
        new.imageList=[NSMutableArray array];
        NSArray *imageurls=[current objectForKey:@"imageurls"];
        for (NSDictionary *curr in imageurls) {
            ImageInfo *imageInfo=[ImageInfo new];
            imageInfo.url=[curr objectForKey:@"url"];
            imageInfo.height=[curr objectForKey:@"height"];
            imageInfo.width=[curr objectForKey:@"width"];
            [new.imageList addObject:imageInfo];
        }
        [newsList addObject:new];
    }
}

@end
