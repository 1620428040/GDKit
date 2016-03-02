//
//  ImageCut.h
//  图形切割
//
//  Created by 国栋 on 15/12/9.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>

//切割图片所用的类，单例模式。能设置原始图片，大小，块数，边框等
@interface ImageCut : UIView

@property UIImage *original;//原始的图像
@property NSMutableArray *images;//存放切割后的图像
@property CGSize size;//将原始图像转化为此大小后进行切割
@property CGSize number;//要切割成几块，横*竖，整数
@property float border;//边框宽度
@property UIColor *color;//边框颜色

+(id)share;//单例模式，用此方法获取实例
-(NSMutableArray*)cutImageByLine;//用直线切割图像，用之前先设置参数，否则会用默认值
-(NSMutableArray*)cutImageMode1;//用预设的形状切割图像

@end
