//
//  GDTB_NViewController.m
//  GDFW
//
//  Created by 国栋 on 15/12/14.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "GDTB_NViewController.h"

@interface GDTB_NViewController ()

@end

@implementation GDTB_NViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addChildViewController:(UIViewController *)childController title:(NSString *)title tabBarTitle:(NSString *)tabBarTitle tabBarImage:(UIImage *)tabBarImage
{
    UINavigationController *nc=[UINavigationController new];
    nc.title=tabBarTitle;
    float scale=tabBarImage.size.height/30;
    UIImage *im=[UIImage imageWithCGImage:tabBarImage.CGImage scale:scale orientation:UIImageOrientationUp];
    nc.tabBarItem.image=[im imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childController.title=title;
    [nc addChildViewController:childController];
    
    [self addChildViewController:nc];
}

@end
