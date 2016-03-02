//
//  CollectionView.m
//  News
//
//  Created by 国栋 on 16/2/26.
//  Copyright © 2016年 GD. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView
@synthesize mainDisplayDelegate,newsList;

+(instancetype)createWithFrame:(CGRect)frame data:(NSArray *)array delegate:(id<MainDisplayDelegate>)theDelegate
{
    CHTCollectionViewWaterfallLayout *layout=[[CHTCollectionViewWaterfallLayout alloc]init];
    layout.columnCount=2;
    CollectionView *collection=[[self alloc]initWithFrame:frame collectionViewLayout:layout];
    collection.mainDisplayDelegate=theDelegate;
    collection.newsList=array;
    [collection layout];
    return collection;
}
-(void)layout
{
    self.delegate=self;
    self.dataSource=self;
    self.backgroundColor=[UIColor whiteColor];
    [self registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)removeFromSuperview
{
    [super removeFromSuperview];
    [self removeObserver:self forKeyPath:@"contentOffset"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (self.contentOffset.y+self.frame.size.height>self.contentSize.height-100&&self.frame.size.height<self.contentSize.height)
        {
            [[NewsManager share]nextPage];
        }
    }
}

#pragma mark CHTCollectionViewDelegateWaterfallLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (newsList[indexPath.row].imageList.count==0) {
        return CGSizeMake(100, 100);
    }
    else
    {
        ImageInfo *imageInfo=newsList[indexPath.row].imageList.firstObject;
        return CGSizeMake(imageInfo.width.floatValue, imageInfo.height.floatValue);
    }
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return newsList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell=(CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor yellowColor];
    cell.title.text=newsList[indexPath.row].title;
    cell.image.image=nil;
    if (newsList[indexPath.row].imageList.count!=0) {
        [cell setImageURL:newsList[indexPath.row].imageList.firstObject.url];
    }
    [cell sizeToFit];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [(CollectionViewCell*)cell endDisplay];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [mainDisplayDelegate didSelectItemAtIndexPath:indexPath];
}

@end
