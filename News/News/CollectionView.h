//
//  CollectionView.h
//  News
//
//  Created by 国栋 on 16/2/26.
//  Copyright © 2016年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"
#import "CollectionViewCell.h"
#import "MainDisplayProtocol.h"
#import "NewsManager.h"

@interface CollectionView : UICollectionView<MainDisplayProtocol,UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
@property id<MainDisplayDelegate> mainDisplayDelegate;
@property NSArray<News*>* newsList;

@end
