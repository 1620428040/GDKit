//
//  GDTB_NViewController.h
//  GDFW
//
//  Created by 国栋 on 15/12/14.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDTB_NViewController : UITabBarController

-(void)addChildViewController:(UIViewController *)childController title:(NSString*)title tabBarTitle:(NSString*)tabBarTitle tabBarImage:(UIImage*)tabBarImage;

@end

