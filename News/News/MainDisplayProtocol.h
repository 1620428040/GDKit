//
//  MainDisplayProtocol.h
//  News
//
//  Created by 国栋 on 16/2/26.
//  Copyright © 2016年 GD. All rights reserved.
//

#import <Foundation/Foundation.h>

//显示新闻的表视图和集合视图都要实现的方法
@protocol MainDisplayDelegate <NSObject>

-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

//视图控制器要实现的方法
@protocol MainDisplayProtocol <NSObject>

+(instancetype)createWithFrame:(CGRect)frame data:(NSArray*)array delegate:(id<MainDisplayDelegate>)theDelegate;

@end