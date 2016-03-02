//
//  GDConnect.m
//  GDServer
//
//  Created by 国栋 on 16/1/13.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDConnect.h"

@implementation GDConnect

-(GDSocket*)createServerSocketWithIP:(NSString *)theIP port:(unsigned int)thePort
{
    //创建 服务器 信息
    struct sockaddr_in socket_address;
    socket_address.sin_len=sizeof(struct sockaddr_in);
    socket_address.sin_family=AF_INET;
    socket_address.sin_port=htons(thePort);
    socket_address.sin_addr.s_addr=inet_addr([theIP cStringUsingEncoding:NSUTF8StringEncoding]);
    bzero(&(socket_address.sin_zero), 8);
    
    //创建 套接字
    int new_socket=socket(AF_INET, SOCK_STREAM, 0);
    if (new_socket==-1) {
        NSLog(@"创建socket失败");
        return nil;
    }
    else
    {
        NSLog(@"socket创建成功，端口：%d",thePort);
    }
    
    GDSocket *new=[GDSocket new];
    new.socket=new_socket;
    new.adress=socket_address;
    return new;
}
-(BOOL)sendMessageWith:(GDSocket*)socket message:(NSString*)theMessage;
{
    long length=[theMessage length];
    if(send(socket.socket,[theMessage UTF8String],length,0))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)startReceive:(GDSocket *)theSocket
{
    [self performSelectorInBackground:@selector(receive:) withObject:theSocket];
}
-(void)receive:(GDSocket*)theSocket
{
    int client_socket=theSocket.socket;
    //NSLog(@"开始接收消息");
    //char received[1024];
    //bzero(received, 1024);
    char data[1024];
    bzero(data, 1024);
    long length=recv(client_socket, data, 1024, 0);//等待接收消息，参数是:套接字，缓存区，长度限制，flag
    //NSLog(@"收到长度为%ld",len);
    if (length==-1) {
        return;
    }
    data[length]='\0';
    
    //如果是"EndClient"就结束连接
    if (strcmp(data, "EndClient")==0) {
        [self close:theSocket];
        NSLog(@"对方结束连接！");
        return;
    }
    
    NSString *mess=[NSString stringWithUTF8String:data];
    //[NSString stringWithCString:data encoding:NSUTF8StringEncoding];
    //NSLog(@"收到消息：%@",mess);
    [self.delegate receivedMessage:mess source:theSocket];
    
    [self receive:theSocket];
}
-(BOOL)close:(GDSocket *)theSocket
{
    if(shutdown(theSocket.socket, SHUT_RDWR)==0)
    {
        return YES;
    }
    else return NO;
}
@end
