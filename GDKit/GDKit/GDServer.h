//
//  GDServer.h
//  GDConnect
//
//  Created by 国栋 on 16/1/15.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDConnect.h"

@interface GDServer : GDConnect

@property GDSocket *socket;//服务端的套接字(未连接的)
@property NSMutableArray<GDSocket*> *clientList;//客户端列表

/**
 *注释：在本机上启动服务器端，需要指定端口和接收信息的对象
 */
+(GDServer*)startServerWithPort:(unsigned int)thePort delegate:(id<GDConnectDelegate>)theDelegate;

@end
