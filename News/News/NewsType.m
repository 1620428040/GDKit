//
//  NewsType.m
//  News
//
//  Created by 国栋 on 16/2/19.
//  Copyright © 2016年 GD. All rights reserved.
//

#import "NewsType.h"

@implementation NewsType
@synthesize name,channelId;

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        name=[aDecoder decodeObjectForKey:@"name"];
        channelId=[aDecoder decodeObjectForKey:@"channelId"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:channelId forKey:@"channelId"];
}

@end
