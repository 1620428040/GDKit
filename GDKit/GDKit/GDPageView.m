//
//  GDPageView.m
//  GDFW
//
//  Created by 国栋 on 15/12/14.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "GDPageView.h"

@interface PageInfo : NSObject

@property NSString *title;
@property UIImage *image;
@property NSString *link;//链接，不需要加http://因为之后会加上。是指点击图片后，会打开的链接

@end

@implementation PageInfo

@end



@interface GDPageView()

@property NSMutableArray<PageInfo*> *pageList;//接收要展示的页面
@property UIPageControl *pageControl;//视图下面的点
@property UIImageView *imageView;
@property UIView *titleView;//标题栏
@property UILabel *title;//标题
@property UIView *lastPagePrompt;//最后一页上的提示
@property UIButton *promptButton;//提示的按钮
@property id<GDPageViewDelegate> delegate;//委托

@end


@implementation GDPageView

@synthesize pageControl,pageList,imageView,titleView,title,lastPagePrompt,promptButton;

+(instancetype)createWithFrame:(CGRect)frame delegate:(id<GDPageViewDelegate>)theDelegate
{
    GDPageView *new=[[self alloc]initWithFrame:frame];
    new.delegate=theDelegate;
    return new;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        CGSize size=self.frame.size;
        pageList=[NSMutableArray array];
        
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        imageView.backgroundColor=[UIColor lightGrayColor];
        [self addSubview:imageView];//为了不把其它的控件遮住，应该先添加图片
        
        
        pageControl=[[UIPageControl alloc]init];
        pageControl.frame=CGRectMake(0, size.height*0.9, size.width, size.height*0.1);
        pageControl.pageIndicatorTintColor=[UIColor blueColor];
        pageControl.currentPageIndicatorTintColor=[UIColor redColor];
        [pageControl addTarget:self action:@selector(valueChangedHandler) forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
        
        
        titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, 30)];
        titleView.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
        title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, 30)];
        title.textAlignment=NSTextAlignmentCenter;//UITextAlignmentCenter不推荐使用了
        [titleView addSubview:title];
        [self addSubview:titleView];
        
        
        promptButton=[[UIButton alloc]initWithFrame:CGRectMake(size.width*0.3, size.height*0.6, size.width*0.4, 30)];
        promptButton.backgroundColor=[UIColor blueColor];
        [promptButton setTitle:@"立即体验" forState:UIControlStateNormal];
        [promptButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [promptButton addTarget:self.delegate action:@selector(next) forControlEvents:UIControlEventTouchDown];
        
        UISwipeGestureRecognizer *leftSGR=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe)];
        leftSGR.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:leftSGR];
        
        UISwipeGestureRecognizer *rightSGR=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
        rightSGR.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rightSGR];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandler)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)addPageWithTitle:(NSString *)theTitle image:(UIImage *)image link:(NSString *)link
{
    PageInfo *newPage=[PageInfo new];
    newPage.title=theTitle;
    newPage.image=image;
    newPage.link=link;
    [pageList addObject:newPage];
    pageControl.numberOfPages=pageList.count;
}
-(void)pageForIndex:(long)index animationTransition:(UIViewAnimationTransition)transition
{
    if (index<0) {
        NSLog(@"已经是第一页了");
        return;
    }
    if (index==pageList.count)
    {
        NSLog(@"已经是最后一页了");
        return;
    }
    if (index==pageList.count-1)
    {
        if (lastPagePrompt!=nil) {
            [self addSubview:lastPagePrompt];
        }
        else if(promptButton!=nil)
        {
            [self addSubview:promptButton];
        }
    }
    else
    {
        [lastPagePrompt removeFromSuperview];
        [promptButton removeFromSuperview];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:transition forView:self cache:YES];
    
    PageInfo *pi=[pageList objectAtIndex:index];
    imageView.image=pi.image;
    title.text=pi.title;
    
    [UIView commitAnimations];
}
-(void)valueChangedHandler
{
    [self pageForIndex:pageControl.currentPage animationTransition:9];
}
-(void)leftSwipe
{
    [self pageForIndex:pageControl.currentPage+1 animationTransition:UIViewAnimationTransitionCurlUp];
    pageControl.currentPage+=1;
}

-(void)rightSwipe
{
    [self pageForIndex:pageControl.currentPage-1 animationTransition:UIViewAnimationTransitionCurlDown];
    pageControl.currentPage-=1;
}
-(void)tapHandler
{
    PageInfo *pi=[pageList objectAtIndex:pageControl.currentPage];
    if (pi.link==nil||[pi.link isEqualToString:@""]) {
        return;
    }
    if (![pi.link hasPrefix:@"http://"]) {
        pi.link=[NSString stringWithFormat:@"http://%@",pi.link];
    }
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:pi.link]];
}
-(void)drawRect:(CGRect)rect
{
    [self pageForIndex:0 animationTransition:9];
}
@end



