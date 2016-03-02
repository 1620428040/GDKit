//
//  GDSocket.h
//  GDConnect
//
//  Created by 国栋 on 16/1/15.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>

//用来 储存，传递 套接字和服务器地址 的类
@interface GDSocket : NSObject

@property NSString *info;//附加的信息,可以用来标记连接
@property int socket;//套接字
@property struct sockaddr_in adress;//服务器地址

@end
