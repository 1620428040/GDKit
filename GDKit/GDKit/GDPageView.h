//
//  GDPageView.h
//  GDFW
//
//  Created by 国栋 on 15/12/14.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GDPageViewDelegate <NSObject>

-(void)next;//用户点击下一步之后的操作

@end


@interface GDPageView : UIView

+(instancetype)createWithFrame:(CGRect)frame delegate:(id<GDPageViewDelegate>)theDelegate;
-(void)addPageWithTitle:(NSString*)theTitle image:(UIImage*)image link:(NSString*)link;

@end
