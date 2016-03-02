//
//  GDContainerView.h
//  代码布局
//
//  Created by 国栋 on 16/2/27.
//  Copyright © 2016年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *注释：用于简单的，没有相互遮盖的界面布局
 */
@interface GDContainerView : UIView


/**
 *注释：设置内间距，默认：(10, 10, 10, 10)
 */
@property UIEdgeInsets edgeInsets;
/**
 *注释：设置行间距，列间距，默认：(10, 10)
 */
@property CGPoint insets;
/**
 *注释：排版模式，如果设定为YES，会为每个子视图添加随机颜色，默认：YES
 */
@property BOOL layoutMode;


/**
 *注释：初始化新的容器视图
 */
-(instancetype)initWithFrame:(CGRect)frame;
/**
 *注释：应用之前的设定，开始布局。一般情况下视图显示时会自动调用
 */
-(void)layoutSubviews;


/**
 *注释：跳到下一行
 */
-(void)newLine;
/**
 *注释：如果当前行有足够大的空隙，则保持在当前行
 */
-(void)keepInCurrentLine;
/**
 *注释：加入一段可以固定宽度的空隙
 */
-(void)addFixedSpaceWithWidth:(float)width;
/**
 *注释：加入一段可以自动调整的空隙，参数是同一行中插入多个空隙时的加权
 */
-(void)addFlexibleSpaceWithWeight:(int)weight;
/**
 *注释：添加新的子视图，并且给出相对大小(如果参数不大于1，则作为相对于容器的比例)或绝对大小，位置是自动调整的
 */
-(void)addSubview:(UIView *)view width:(float)width height:(float)height;

@end


@interface UIView (GDTools)
/**
 *注释：输出视图的Frame并且加个标题
 */
-(void)outputFrameWithTitle:(NSString*)title;

@end
