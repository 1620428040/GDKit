//
//  NewsTypeManager.h
//  News
//
//  Created by 国栋 on 16/2/25.
//  Copyright © 2016年 GD. All rights reserved.
//

#define NewsTypeListFile @"/Users/guodong/Desktop/other/News/News/NewsTypeList.plist"


#import <Foundation/Foundation.h>
#import "NewsType.h"

@protocol NewsTypeManagerDelegate <NSObject>
@required
-(void)refreshNewsTypeList;

@end

@interface NewsTypeManager : NSObject

@property id<NewsTypeManagerDelegate>delegate;
@property NSMutableArray<NewsType*> *newsTypeList;

+(instancetype)share;

@end
