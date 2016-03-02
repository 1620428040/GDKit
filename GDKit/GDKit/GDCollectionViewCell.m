//
//  GDCollectionViewCell.m
//  GDCollectionView
//
//  Created by 国栋 on 16/1/23.
//  Copyright (c) 2016年 GD. All rights reserved.
//

#import "GDCollectionViewCell.h"

@implementation GDCollectionViewCell

-(instancetype)initWithReuseIdentifier:(NSString *)identifier
{
    if (self=[super init]) {
        self.reuseIdentifier=identifier;
        [self addTarget:self action:@selector(didSelected) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}
-(void)didSelected
{
    [self.belong didSelectCell:self];
}

@end
