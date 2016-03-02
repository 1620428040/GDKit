//
//  GDConnect.h
//  GDServer
//
//  Created by 国栋 on 16/1/13.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDSocket.h"

@protocol GDConnectDelegate <NSObject>

/**
 *注释：用来异步接收收到的信息
 */
-(void)receivedMessage:(NSString*)theMessage source:(GDSocket*)theSource;

@end

//这是一个抽象类，是GDServer和GDClient的父类
@interface GDConnect : NSObject

@property id<GDConnectDelegate>delegate;

/**
 *注释：创建一个包含 服务器端地址和端口等信息 和一个空的套接字 的GDSocket对象
 */
-(GDSocket*)createServerSocketWithIP:(NSString*)theIP port:(unsigned int)thePort;
/**
 *注释：用连接好的套接字发送信息
 */
-(BOOL)sendMessageWith:(GDSocket*)socket message:(NSString*)theMessage;
/**
 *注释：开始用连接好的套接字接受信息，在新的线程创建循环
 */
-(void)startReceive:(GDSocket*)theSocket;
/**
 *注释：停止从指定的连接接收信息
 */
-(BOOL)close:(GDSocket*)theSocket;

@end