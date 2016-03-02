//
//  GDCollectionView.h
//  GDCollectionView
//
//  Created by 国栋 on 16/1/23.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDCollectionViewCell.h"
@class GDCollectionView;
@protocol GDCollectionViewDelegate <NSObject>

/**行数*/
-(NSInteger)numberOfRow;
/**每行的cell数*/
-(NSInteger)numberOfCellInRow;
/**每个cell的大小*/
-(CGSize)cellSize;
/**间隔的大小*/
-(CGSize)spacing;
/**获取cell*/
-(GDCollectionViewCell*)cellOfCollectionView:(GDCollectionView*)collectionView forRow:(NSInteger)row index:(NSInteger)index;
/**选中了某一个cell*/
-(void)didSelectCell:(GDCollectionViewCell*)cell collectionView:(GDCollectionView*)collectionView;


//委托对象的范例
//#pragma mark GDCollectionViewDelegate
///**行数*/
//-(NSInteger)numberOfRow
//{
//    return 1000;
//}
///**每行的cell数*/
//-(NSInteger)numberOfCellInRow
//{
//    return 1000;
//}
///**每个cell的大小*/
//-(CGSize)cellSize
//{
//    return CGSizeMake(30, 30);
//}
///**间隔的大小*/
//-(CGSize)spacing
//{
//    return CGSizeMake(10, 10);
//}
///**获取cell*/
//-(GDCollectionViewCell*)cellOfCollectionView:(GDCollectionView *)collectionView forRow:(NSInteger)row index:(NSInteger)index
//{
//    GDCollectionViewCell *cell=[collectionView dequeueReusableCellWithIdentifier:@"reuse"];
//    if (cell==nil) {
//        cell=[[GDCollectionViewCell alloc]initWithReuseIdentifier:@"reuse"];
//    }
//    cell.backgroundColor=[UIColor orangeColor];
//    return cell;
//}
///**某个cell被点击*/
//-(void)didSelectCell:(GDCollectionViewCell *)cell collectionView:(GDCollectionView *)collectionView
//{
//    NSLog(@"点击了%ld行%ld个",cell.row,cell.index);
//    NSLog(@"显示%ld，可复用%ld",collectionView.usingCellList.count,collectionView.reuseCellList.count);
//    NSLog(@"重置");
//    [collectionView reset];
//}

@end


@interface GDCollectionView : UIScrollView

@property float temp;//滑动的距离超过这个数才会刷新

/**创建视图*/
+(instancetype)createWithFrame:(CGRect)theFrame delegate:(id<GDCollectionViewDelegate>)theDelegate;
/**预备,重新设定视图的大小*/
-(void)prepare;
/**清除可复用的cell*/
-(void)cleanReuseCell;
/**刷新视图*/
-(void)reset;
/**获取可以重用的cell*/
-(GDCollectionViewCell*)dequeueReusableCellWithIdentifier:(NSString*)identifier;

@end
