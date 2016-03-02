//
//  GDContainerView.m
//  代码布局
//
//  Created by 国栋 on 16/2/27.
//  Copyright © 2016年 GD. All rights reserved.
//

#import "GDContainerView.h"



#pragma mark 私有类

typedef enum
{
    addSubview=0,
    newLine=1,
    keepInCurrentLine=2,
    
}GDContainerViewOperateType;

@interface GDContainerViewOperate : NSObject

@property GDContainerViewOperateType type;
@property UIView *subview;
@property CGRect frame;
@property CGSize size;
@property float width,height;
@property int weight;

@end


@implementation GDContainerViewOperate

@end



@interface GDPoint : NSObject

@property float x,y,lon;//lon是在当前点插入，能容纳的最大长度

@end


@implementation GDPoint

+(instancetype)createWithX:(float)theX y:(float)theY
{
    GDPoint *new=[self new];
    new.x=theX;
    new.y=theY;
    return new;
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"x=%f y=%f",self.x,self.y];
}

@end



@interface GDContainerView ()

@property BOOL isNewLine,isKeepInCurrentLine;//是否从新的一行开始
@property float currentX,currentY;//当前布局到的位置
@property float nextY;//下一行开始的Y坐标
@property NSMutableArray<GDContainerViewOperate*> *operateList;//操作列表
@property NSMutableArray<GDPoint*> *pointList;//记录矩形线中高度变化的起点和最后的终点

@end

@implementation GDContainerView
@synthesize isNewLine,isKeepInCurrentLine,currentX,currentY,nextY,edgeInsets,insets,layoutMode,operateList,pointList;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        edgeInsets=UIEdgeInsetsMake(10, 10, 10, 10);
        insets=CGPointMake(10, 10);
        isNewLine=YES;
        layoutMode=YES;
        operateList=[NSMutableArray array];
        [self addNewBrokenPointWithX:edgeInsets.left y:edgeInsets.top];
        [self addNewBrokenPointWithX:edgeInsets.right y:edgeInsets.top];
    }
    return self;
}
-(void)layoutSubviews
{
    if (layoutMode==YES) {
        NSLog(@"布局子视图");
    }
    [super layoutSubviews];
    currentX=edgeInsets.left;
    currentY=edgeInsets.top;
    nextY=currentY;
    
    for (GDContainerViewOperate *operate in operateList) {
        
        switch (operate.type) {
            case newLine:
                [self newLineOperate];
                break;
                
            case addSubview:
                [self addSubviewOperate:operate.subview width:operate.width height:operate.height];
                break;
            
            case keepInCurrentLine:
                [self keepInCurrentLineOperate];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark 接收命令并记下来
-(void)newLine
{
    GDContainerViewOperate *operate=[GDContainerViewOperate new];
    operate.type=newLine;
    [operateList addObject:operate];
}
-(void)keepInCurrentLine
{
    GDContainerViewOperate *operate=[GDContainerViewOperate new];
    operate.type=keepInCurrentLine;
    [operateList addObject:operate];
}
-(void)addFixedSpaceWithWidth:(float)width
{
    
}
-(void)addFlexibleSpaceWithWeight:(int)weight
{
    
}
-(void)addSubview:(UIView *)view width:(float)width height:(float)height
{
    GDContainerViewOperate *operate=[GDContainerViewOperate new];
    operate.type=addSubview;
    operate.width=width;
    operate.height=height;
    operate.subview=view;
    [operateList addObject:operate];
}

#pragma mark 实际执行命令
-(void)newLineOperate
{
    currentX=edgeInsets.left;
    currentY=nextY;
    //[brokenPointList removeAllObjects];
    [self addNewBrokenPointWithX:edgeInsets.left y:currentY];
    [self addNewBrokenPointWithX:edgeInsets.right y:currentY];
}
-(void)keepInCurrentLineOperate
{
    isKeepInCurrentLine=YES;
}
-(void)addFixedSpaceOperateWithWidth:(float)width
{
}
-(void)addFlexibleSpaceOperateWithWeight:(int)weight
{
}
-(void)addSubviewOperate:(UIView *)view width:(float)width height:(float)height
{
    
    if (width<=1) {
        width=width*self.frame.size.width;
    }
    if (height<=1) {
        height=height*self.frame.size.height;
    }
    if (isKeepInCurrentLine==YES) {
        [self searchMostDeepSpaceWidthThan:(float)width height:height];
    }
    else if (width>self.frame.size.width-currentX-edgeInsets.right) {
        [self newLineOperate];
    }
    [self addSubviewInCurrentLine:view width:width height:height];
}
-(void)addSubviewInCurrentLine:(UIView *)view width:(float)width height:(float)height
{
    if (height+currentY+insets.y>nextY) {
        nextY=height+currentY+insets.y;
    }
    if (layoutMode==YES) {
        view.backgroundColor=[self randomColor];
    }
    view.frame=CGRectMake(currentX, currentY, width, height);
    [self addSubview:view];
    //[view outputFrameWithTitle:view.description];
    if (isKeepInCurrentLine==NO) {
        [self addNewBrokenPointWithX:currentX y:currentY+height];
    }
    currentX+=width+insets.x;
}
-(UIColor*)randomColor
{
    sranddev();
    float red=arc4random()%255;
    red/=255;
    float green=arc4random()%255;
    green/=255;
    float blue=arc4random()%255;
    blue/=255;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}


#pragma mark 记录之前的矩形线
-(void)resetWithY:(float)y
{
    if (pointList==nil) {
        pointList=[NSMutableArray array];
    }
    else
    {
        [pointList removeAllObjects];
    }
    [pointList addObject:[GDPoint createWithX:edgeInsets.left y:y]];
    [pointList addObject:[GDPoint createWithX:self.frame.size.width-edgeInsets.right y:y]];
}
-(void)refreshLong
{
    GDPoint *point1,*point2;
    for (int i=0;i<pointList.count;i++) {
        point1=pointList[i];
        for (int j=0;j<pointList.count;j++) {
            point2=pointList[j];
            if (point2.y>point1.y) {
                point1.lon=point2.x-point1.x;
                break;
            }
        }
        NSLog(@"%@",point1);
    }
}
-(void)addRectWithSize:(CGSize)size
{
    GDPoint *point1;
    //找出最深的，且能容纳新视图的豁口
    for (GDPoint *point2 in pointList) {
        if (point2.lon>=size.width&&point2.y<point1.y) {
            point1=point2;
        }
    }
    
}
-(void)addNewBrokenPointWithX:(float)x y:(float)y
{
//    GDContainerViewBrokenPoint *new=[GDContainerViewBrokenPoint new];
//    new.x=x;
//    new.y=y;
//    [brokenPointList addObject:new];
}
-(void)searchMostDeepSpaceWidthThan:(float)width height:(float)height
{
//    NSMutableArray<GDContainerViewLine*>*lineList=[NSMutableArray array];
//    for (int i=0;i<brokenPointList.count;i++) {
//        GDContainerViewBrokenPoint *point1=brokenPointList[i];
//        for (int j=i+1; j<brokenPointList.count; j++) {
//            GDContainerViewBrokenPoint *point2=brokenPointList[j];
//            if (point1.y>=point2.y) {
//                if (point2.x-point1.x>=width+insets.x) {
//                    [lineList addObject:[GDContainerViewLine createWithStart:point1 end:point2]];
//                }
//                break;
//            }
//        }
//    }
//    
//    NSLog(@"%ld",lineList.count);
//    if (lineList.count==0||(lineList.count==1&&lineList.firstObject.startPoint.y==nextY-insets.y)) {
//        [self newLineOperate];
//        return;
//    }
//    GDContainerViewLine *deep;
//    for (GDContainerViewLine *current in lineList) {
//        if (deep==nil||deep.startPoint.y>current.startPoint.y) {
//            deep=current;
//        }
//    }
//    
//    for (long i=brokenPointList.count-1;i>=0;i--)
//    {
//        if (brokenPointList[i].x<=deep.startPoint.x+width&&brokenPointList[i].x>deep.startPoint.x) {
//            [brokenPointList removeObjectAtIndex:i];
//        }
//        if (brokenPointList[i].x==deep.startPoint.x) {
//            [brokenPointList removeObjectAtIndex:i];
//            GDContainerViewBrokenPoint *start=[GDContainerViewBrokenPoint new];
//            start.x=deep.startPoint.x;
//            start.y=deep.startPoint.y+height+insets.y;
//            [brokenPointList insertObject:start atIndex:i];
//            GDContainerViewBrokenPoint *end=[GDContainerViewBrokenPoint new];
//            end.x=deep.startPoint.x+width+insets.x;
//            end.y=deep.startPoint.y;
//            [brokenPointList insertObject:end atIndex:i+1];
//        }
//    }
//    currentX=deep.startPoint.x;
//    currentY=deep.startPoint.y+insets.y;
}


@end

@implementation UIView(GDTools)

-(void)outputFrameWithTitle:(NSString *)title
{
    if (title==nil) {
        title=self.description;
    }
    NSLog(@"%@:  x:%f y:%f width:%f height:%f ",title,self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
}
@end




