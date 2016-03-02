//
//  ImageCut.m
//  图形切割
//
//  Created by 国栋 on 15/12/9.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "ImageCut.h"

@interface ImageCut ()


@end

ImageCut *shareImageCut;

@implementation ImageCut
@synthesize original,images,size,number,border,color;

+(id)share
{
    if (shareImageCut==nil) {
        shareImageCut=[[self alloc]init];
    }
    return shareImageCut;
}
-(id)init
{
    if (self=[super init])
    {
        original=[UIImage new];
        size=CGSizeMake(100, 100);
        number=CGSizeMake(3, 3);
        border=1;
        color=[UIColor blackColor];
    }
    return self;
}
-(NSMutableArray*)cutImageByLine
{
    CGSize cellsize=CGSizeMake(size.width/number.width, size.height/number.height);
    images=[NSMutableArray array];
    for (int y=0; y<number.height; y++) {
        for (int x=0; x<number.width; x++) {
            UIGraphicsBeginImageContextWithOptions(cellsize, NO, 1);
            [original drawInRect:CGRectMake(-cellsize.width*x, -cellsize.height*y, size.width, size.height)];
            CGContextRef con=UIGraphicsGetCurrentContext();
            CGContextAddRect(con, CGRectMake(0, 0, cellsize.width, cellsize.height));
            CGContextSetLineWidth(con, border);
            CGContextSetStrokeColorWithColor(con, color.CGColor);
            CGContextStrokePath(con);
            [images addObject:UIGraphicsGetImageFromCurrentImageContext()];
        }
    }
    return images;
}
-(NSMutableArray*)cutImageMode1
{
    CGSize cellsize=CGSizeMake(size.width/number.width, size.height/number.height);
    NSLog(@"size  %f %f",cellsize.width,cellsize.height);
    images=[NSMutableArray array];
    for (int y=0; y<number.height; y++) {
        for (int x=0; x<number.width; x++) {
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(cellsize.width*2, cellsize.height*2), NO, 1);
            
            CGContextRef con=UIGraphicsGetCurrentContext();
            CGContextMoveToPoint(con, cellsize.width*0.5, cellsize.height*0.5);
            
            //上边界
            if (y==0) {
                CGContextAddLineToPoint(con, cellsize.width*1.5, cellsize.height*0.5);
            }
            else
            {
                CGContextAddLineToPoint(con, cellsize.width*0.75, cellsize.height*0.5);
                for (int i=cellsize.width*0.75; i<=cellsize.width*1.25; i++) {
                    CGContextAddLineToPoint(con, i, cellsize.width*0.5+sqrt(cellsize.width*0.25*cellsize.width*0.25-(i-cellsize.width)*(i-cellsize.width)));
                }
                CGContextAddLineToPoint(con, cellsize.width*1.5, cellsize.height*0.5);
            }
            
            //右边界
            if (x==number.width-1) {
                CGContextAddLineToPoint(con, cellsize.width*1.5, cellsize.height*1.5);
            }
            else
            {
                CGContextAddLineToPoint(con, cellsize.width*1.5, cellsize.height*0.75);
                for (int i=cellsize.height*0.75; i<=cellsize.height*1.25; i++) {
                    CGContextAddLineToPoint(con, cellsize.height*1.5+sqrt(cellsize.height*0.25*cellsize.height*0.25-(i-cellsize.height)*(i-cellsize.height)), i);
                }
                CGContextAddLineToPoint(con, cellsize.width*1.5, cellsize.height*1.5);
            }
            
            //下边界
            if (y==number.height-1) {
                CGContextAddLineToPoint(con, cellsize.width*0.5, cellsize.height*1.5);
            }
            else
            {
                CGContextAddLineToPoint(con, cellsize.width*1.25, cellsize.height*1.5);
                for (int i=cellsize.width*1.25; i>=cellsize.width*0.75; i--) {
                    CGContextAddLineToPoint(con, i, cellsize.width*1.5+sqrt(cellsize.width*0.25*cellsize.width*0.25-(i-cellsize.width)*(i-cellsize.width)));
                }
                CGContextAddLineToPoint(con, cellsize.width*0.5, cellsize.height*1.5);
            }
            
            //左边界
            if (x==0) {
                CGContextAddLineToPoint(con, cellsize.width*0.5, cellsize.height*0.5);
            }
            else
            {
                CGContextAddLineToPoint(con, cellsize.width*0.5, cellsize.height*1.25);
                for (int i=cellsize.height*1.25; i>=cellsize.height*0.75; i--) {
                    CGContextAddLineToPoint(con, cellsize.height*0.5+sqrt(cellsize.height*0.25*cellsize.height*0.25-(i-cellsize.height)*(i-cellsize.height)), i);
                }
                CGContextAddLineToPoint(con, cellsize.width*0.5, cellsize.height*0.5);
            }
            
            CGPathRef path=CGContextCopyPath(con);
            CGContextClip(con);
            [original drawInRect:CGRectMake(cellsize.width*0.5-cellsize.width*x, cellsize.height*0.5-cellsize.height*y, size.width, size.height)];
            
            
            CGContextAddPath(con, path);
            CGContextSetLineWidth(con, border);
            CGContextSetStrokeColorWithColor(con, color.CGColor);
            CGContextStrokePath(con);
            
            [images addObject:UIGraphicsGetImageFromCurrentImageContext()];
        }
    }
    
    return images;
}

@end
