//
//  CollectionViewCell.m
//  News
//
//  Created by 国栋 on 16/2/24.
//  Copyright © 2016年 GD. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
{
    NSData *imageData;
}
@synthesize image,title,task;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        image=[UIImageView new];
        [self addSubview:image];
        
        title=[UILabel new];
        title.numberOfLines=0;
        [self addSubview:title];
    }
    return self;
}
-(void)sizeToFit
{
    image.frame=self.bounds;
    title.frame=CGRectMake(0, 10, self.frame.size.width, 20);
    [title sizeToFit];
}
-(void)setImageURL:(NSString *)imageURL
{
    NSLog(@"下载图片：%@  task:%@",imageURL,task);
    if (task!=nil) {
        [task resume];
        NSLog(@"重新下载");
    }
    else
    {
        task=[[NSURLSession sharedSession]dataTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            imageData=data;
            [self performSelectorOnMainThread:@selector(didLoadImage) withObject:nil waitUntilDone:NO];
            task=nil;
        }];
    }
    [task resume];
}
-(void)didLoadImage
{
    NSLog(@"图片下载完成");
    self.image.image=[UIImage imageWithData:imageData];
}
-(void)endDisplay
{
    if (task!=nil) {
        NSLog(@"放弃下载");
        [task suspend];
    }
}
@end
