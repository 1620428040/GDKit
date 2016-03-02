//
//  GDClient.m
//  GDConnect
//
//  Created by 国栋 on 16/1/15.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDClient.h"

@implementation GDClient

@synthesize socket;

+(GDClient*)connectToIP:(NSString*)theIP port:(unsigned int)thePort delegate:(id<GDConnectDelegate>)theDelegate
{
    GDClient *new=[[self alloc]init];
    new.delegate=theDelegate;
    new.socket=[new createServerSocketWithIP:theIP port:thePort];
    return [new connect];
}
-(GDClient*)connect
{
    struct sockaddr_in server_addr=socket.adress;
    if (connect(socket.socket, (struct sockaddr *)&server_addr, sizeof(struct sockaddr_in))==0)
    {
        [self startReceive:socket];
        return self;
    }
    else
    {
        NSLog(@"连接失败");
        return nil;
    }
}
-(BOOL)sendMessage:(NSString*)theMessage
{
    return [self sendMessageWith:socket message:theMessage];
}

@end
