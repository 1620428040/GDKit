//
//  GDTools.m
//  聊天
//
//  Created by 国栋 on 15/12/24.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "GDTools.h"

@implementation GDTools

+(void)printRect:(CGRect)rect
{
    NSLog(@"rect:x=%f  y=%f width=%f height=%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
}
+(void)printPoint:(CGPoint)point
{
    NSLog(@"point:x=%f  y=%f",point.x,point.y);
}
+(void)printSize:(CGSize)size
{
    NSLog(@"size:width=%f height=%f",size.width,size.height);
}
+(void)changeFrame:(UIView*)theView key:(KeyOfRect)key add:(float)value
{
    CGRect rect=theView.frame;
    if (key==x)
    {
        rect.origin.x=rect.origin.x+value;
    }
    else if (key==y)
    {
        rect.origin.y=rect.origin.y+value;
    }
    else if (key==width)
    {
        rect.size.width=rect.size.width+value;
    }
    else if (key==height)
    {
        rect.size.height=rect.size.height+value;
    }
    theView.frame=rect;
}
@end
