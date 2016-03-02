//
//  DetailsViewController.m
//  News
//
//  Created by 国栋 on 16/2/25.
//  Copyright © 2016年 GD. All rights reserved.
//

#define sw ([UIScreen mainScreen].bounds.size.width)
#define sh ([UIScreen mainScreen].bounds.size.height)
#define vw (self.frame.size.width)
#define vh (self.frame.size.height)

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize currentNews;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//        
//    }];
    
    self.title=@"详情";
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"详情" style:UIBarButtonItemStyleDone target:self action:@selector(openWebPage)];
    
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, sw, sh)];
    //scroll.backgroundColor=[UIColor blueColor];
    [self.view addSubview:scroll];
    
    UIView *grayView=[UIView new];
    grayView.backgroundColor=[UIColor lightGrayColor];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, sw-80, 30)];
    titleLabel.text=currentNews.title;
    titleLabel.numberOfLines=0;
    [titleLabel sizeToFit];
    [grayView addSubview:titleLabel];
    
    grayView.frame=CGRectMake(20, 20, sw-40, titleLabel.frame.size.height+40);
    [scroll addSubview:grayView];
    
    UILabel *desc=[[UILabel alloc]initWithFrame:CGRectMake(20, grayView.frame.size.height+40, sw-40, 30)];
    desc.numberOfLines=0;
    desc.text=currentNews.desc;
    [desc sizeToFit];
    [scroll addSubview:desc];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openWebPage
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:currentNews.link]];
}

@end
