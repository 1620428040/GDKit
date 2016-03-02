//
//  GDCollectionViewCell.h
//  GDCollectionView
//
//  Created by 国栋 on 16/1/23.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GDCollectionViewCell;
@protocol BelongProtocol <NSObject>

-(void)didSelectCell:(GDCollectionViewCell*)cell;

@end

@interface GDCollectionViewCell : UIButton

@property NSInteger row,index;
@property NSString *reuseIdentifier;
@property id<BelongProtocol> belong;
@property UILabel *textLabel;//空的，只是一个指针

-(instancetype)initWithReuseIdentifier:(NSString*)identifier;

@end
