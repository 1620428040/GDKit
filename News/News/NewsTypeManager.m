//
//  NewsTypeManager.m
//  News
//
//  Created by 国栋 on 16/2/25.
//  Copyright © 2016年 GD. All rights reserved.
//

#import "NewsTypeManager.h"

NewsTypeManager *shareNewsTypeManager;

@implementation NewsTypeManager
@synthesize newsTypeList,delegate;

+(instancetype)share
{
    if (shareNewsTypeManager==nil) {
        shareNewsTypeManager=[[self alloc]init];
    }
    return shareNewsTypeManager;
}

-(instancetype)init
{
    if (self=[super init]) {
        
        //首先用缓存的列表
        NSData *data=[NSData dataWithContentsOfFile:NewsTypeListFile];
        newsTypeList=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (newsTypeList==nil) {
            newsTypeList=[NSMutableArray array];
        }
        
        //然后异步更新数据
        [self performSelectorInBackground:@selector(updataNewTypeList) withObject:nil];
    }
    return self;
}

-(void)updataNewTypeList
{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://apis.baidu.com/showapi_open_bus/channel_news/channel_news"]];
    [request setHTTPMethod: @"GET"];
    [request addValue:@"630fc84391eacf9743084e4ea36beb2f" forHTTPHeaderField:@"apikey"];
    
    NSURLSessionDataTask *task=[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data==nil) {
            return;
        }
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *arr=[[dict objectForKey:@"showapi_res_body"]objectForKey:@"channelList"];
        if (arr!=nil) {
            newsTypeList=[NSMutableArray array];
            for (NSDictionary *dict in arr) {
                NewsType *new=[NewsType new];
                new.name=[dict objectForKey:@"name"];
                new.channelId=[dict objectForKey:@"channelId"];
                [newsTypeList addObject:new];
            }
            [delegate refreshNewsTypeList];
            NSData *data=[NSKeyedArchiver archivedDataWithRootObject:newsTypeList];
            [data writeToFile:@"/Users/guodong/Desktop/other/News/News/NewsTypeList.plist" atomically:YES];
            //[table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
    }];
    [task resume];
}

@end
