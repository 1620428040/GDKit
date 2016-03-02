//
//  News.h
//  News
//
//  Created by 国栋 on 16/2/25.
//  Copyright © 2016年 GD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageInfo : NSObject

@property NSNumber *height;
@property NSNumber *width;
@property NSString *url;

@end

@interface News : NSObject

@property NSString *channelId;
@property NSString *channelName;
@property NSString *desc;
@property NSString *link;
@property NSString *pubDate;
@property NSString *source;
@property NSString *title;
@property NSMutableArray<ImageInfo*>*imageList;

@end
