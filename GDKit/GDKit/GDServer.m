//
//  GDServer.m
//  GDConnect
//
//  Created by 国栋 on 16/1/15.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDServer.h"

@implementation GDServer

@synthesize socket,clientList;

+(GDServer*)startServerWithPort:(unsigned int)thePort delegate:(id<GDConnectDelegate>)theDelegate
{
    GDServer *new=[[self alloc]init];
    new.delegate=theDelegate;
    new.socket=[new createServerSocketWithIP:@"127.0.0.1" port:thePort];
    new.clientList=[NSMutableArray array];
    return[new startServer];
}
-(GDServer*)startServer
{
    int server_socket=socket.socket;
    struct sockaddr_in server_address=socket.adress;
    
    if (bind(server_socket, (struct sockaddr*)&server_address, sizeof(server_address))==-1) {
        NSLog(@"绑定套接字失败");
        return nil;
    }
    //    else
    //    {
    //        NSLog(@"绑定套接字成功");
    //    }
    [self performSelectorInBackground:@selector(listen:) withObject:socket];
    return self;
}
-(void)listen:(GDSocket*)server
{
    int server_socket=server.socket;
    if(listen(server_socket, 5)==-1)
    {
        NSLog(@"监听失败");
        return;
    }
    //    else
    //    {
    //        NSLog(@"监听成功");
    //    }
    
    //空的 地址等信息 用来存放客户端的信息
    struct sockaddr_in client_address;
    socklen_t address_len;
    
    int client_socket=accept(server_socket, (struct sockaddr *)&client_address, &address_len);
    if (client_socket==-1) {
        NSLog(@"连接失败");
        return;
    }
    //    else
    //    {
    //        NSLog(@"连接成功");
    //    }
    
    //添加连接信息进数组，以保存
    GDSocket *new=[GDSocket new];
    new.socket=client_socket;
    [clientList addObject:new];
    
    //交给新的进程，不断的收发消息
    [self startReceive:new];
    
    [self listen:server];//继续监听
}

@end