//
//  GDTools.h
//  聊天
//
//  Created by 国栋 on 15/12/24.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    x=0,
    y=1,
    width=2,
    height=3,
}KeyOfRect;

@interface GDTools : UIView

+(void)printRect:(CGRect)rect;
+(void)printPoint:(CGPoint)point;
+(void)printSize:(CGSize)size;
+(void)changeFrame:(UIView*)theView key:(KeyOfRect)key add:(float)value;

@end
