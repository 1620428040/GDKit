//
//  GDCollectionView.m
//  GDCollectionView
//
//  Created by 国栋 on 16/1/23.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDCollectionView.h"

@interface GDCollectionView ()<BelongProtocol>
{
    CGPoint oldOffset;
    NSMutableArray *usingCellList,*reuseCellList;
}
@property id<GDCollectionViewDelegate>viewDelegate;

@end


@implementation GDCollectionView
@synthesize viewDelegate,temp;
/**创建*/
+(instancetype)createWithFrame:(CGRect)theFrame delegate:(id<GDCollectionViewDelegate>)theDelegate
{
    GDCollectionView *new=[[self alloc]initWithFrame:theFrame];
    new.viewDelegate=theDelegate;
    [new initialize];
    return new;
}
/**初次加载*/
-(void)initialize
{
    usingCellList=[NSMutableArray array];
    reuseCellList=[NSMutableArray array];
    oldOffset=self.contentOffset;
    temp=100;
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self prepare];
}
/**预备*/
-(void)prepare
{
    //设定内容视图的大小
    float width=[viewDelegate numberOfCellInRow]*[viewDelegate cellSize].width+([viewDelegate numberOfCellInRow]+1)*[viewDelegate spacing].width;
    float height=[viewDelegate numberOfRow]*[viewDelegate cellSize].height+([viewDelegate numberOfRow]+1)*[viewDelegate spacing].height;
    self.contentSize=CGSizeMake(width, height);
    [self refresh];
}
/**刷新*/
-(void)refresh
{
    //获取显示的范围
    NSInteger startIndex=(self.contentOffset.x-temp)/([viewDelegate cellSize].width+[viewDelegate spacing].width);
    if (startIndex<0) {
        startIndex=0;
    }
    NSInteger endIndex=(self.contentOffset.x+self.frame.size.width+temp)/([viewDelegate cellSize].width+[viewDelegate spacing].width);
    if (endIndex>[viewDelegate numberOfCellInRow]-1) {
        endIndex=[viewDelegate numberOfCellInRow]-1;
    }
    NSInteger startRow=(self.contentOffset.y-temp)/([viewDelegate cellSize].height+[viewDelegate spacing].height);
    if (startRow<0) {
        startRow=0;
    }
    NSInteger endRow=(self.contentOffset.y+self.frame.size.height+temp)/([viewDelegate cellSize].height+[viewDelegate spacing].width);
    if (endRow>[viewDelegate numberOfRow]-1) {
        endRow=[viewDelegate numberOfRow]-1;
    }
    
    //将移出屏幕的cell移到reuseCellList中
    if (usingCellList.count!=0) {
        for (NSInteger i=usingCellList.count-1;i>=0;i--){
            GDCollectionViewCell *cell=[usingCellList objectAtIndex:i];
            if (cell.index<startIndex||cell.index>endIndex||cell.row<startRow||cell.row>endRow) {
                [reuseCellList addObject:cell];
                [usingCellList removeObject:cell];
            }
        }
    }
    
    //创建缺少的cell
    for (NSInteger row=startRow;row<=endRow;row++) {
        for (NSInteger index=startIndex;index<=endIndex;index++) {
            
            GDCollectionViewCell *cell=nil;
            
            for (GDCollectionViewCell *enumCell in usingCellList) {
                if (enumCell.index==index&&enumCell.row==row) {
                    cell=enumCell;
                    break;
                }
            }
            
            if (cell==nil) {
                cell=[viewDelegate cellOfCollectionView:self forRow:row index:index];
                cell.index=index;
                cell.row=row;
                float x=index*[viewDelegate cellSize].width+(index+1)*[viewDelegate spacing].width;
                float y=row*[viewDelegate cellSize].height+(row+1)*[viewDelegate spacing].height;
                cell.frame=CGRectMake(x, y, [viewDelegate cellSize].width, [viewDelegate cellSize].height);
                
                if (cell.superview==nil) {
                    [self addSubview:cell];
                    cell.belong=self;
                }
                [usingCellList addObject:cell];
            }
        }
    }
}
/**重新显示*/
-(void)reset
{
    [reuseCellList addObjectsFromArray:usingCellList];
    [usingCellList removeAllObjects];
    [self refresh];
}
-(void)cleanReuseCell
{
    for (GDCollectionViewCell *cell in usingCellList) {
        [cell removeFromSuperview];
    }
    [usingCellList removeAllObjects];
    [reuseCellList removeAllObjects];
    [self prepare];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        //验证滑动距离大于一定距离才刷新
        if (oldOffset.x<self.contentOffset.x+temp&&oldOffset.x>self.contentOffset.x-temp&&oldOffset.y<self.contentOffset.y+temp&&oldOffset.y>self.contentOffset.y-temp) {
            return;
        }
        oldOffset=self.contentOffset;
        [self refresh];
    }
}
-(GDCollectionViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    for (GDCollectionViewCell *cell in reuseCellList) {
        if ([cell.reuseIdentifier isEqualToString:identifier]) {
            GDCollectionViewCell *reuseCell=cell;
            [reuseCellList removeObject:cell];
            return reuseCell;
        }
    }
    return nil;
}
-(void)didSelectCell:(GDCollectionViewCell *)cell
{
    [viewDelegate didSelectCell:cell collectionView:self];
}

@end