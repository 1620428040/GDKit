//
//  GDClient.h
//  GDConnect
//
//  Created by 国栋 on 16/1/15.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDConnect.h"

@interface GDClient : GDConnect

@property GDSocket *socket;//用来连接的套接字

+(GDClient*)connectToIP:(NSString*)theIP port:(unsigned int)thePort delegate:(id<GDConnectDelegate>)theDelegate;
-(BOOL)sendMessage:(NSString*)theMessage;

@end
