//
//  StartViewController.m
//  News
//
//  Created by 国栋 on 16/3/2.
//  Copyright © 2016年 GD. All rights reserved.
//

#import "StartViewController.h"
#import "GDKit/GDPageView.h"
#import "NewsViewController.h"

@interface StartViewController ()<GDPageViewDelegate>

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL isNotFirstTimeRun=[[NSUserDefaults standardUserDefaults]boolForKey:@"isNotFirstTimeRun"];
    
    //测试
    //isNotFirstTimeRun=NO;
    
    
    if (isNotFirstTimeRun==YES) {
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        image.image=[UIImage imageNamed:@"start3"];
        [self.view addSubview:image];
        
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(openNeswViewController) userInfo:nil repeats:NO];
    }
    else
    {
        GDPageView *pageView=[[GDPageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [pageView addPageWithTitle:nil image:[UIImage imageNamed:@"start1"] link:nil];
        [pageView addPageWithTitle:nil image:[UIImage imageNamed:@"start2"] link:nil];
        [pageView addPageWithTitle:nil image:[UIImage imageNamed:@"start3"] link:nil];
        [self.view addSubview:pageView];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isNotFirstTimeRun"];
    }
    
    // Do any additional setup after loading the view.
}
-(void)next
{
    [self openNeswViewController];
}
-(void)openNeswViewController
{
    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *start=[main instantiateViewControllerWithIdentifier:@"start"];
    //NewsViewController *newsVC=[NewsViewController new];
    [self presentViewController:start animated:YES completion:^{}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
