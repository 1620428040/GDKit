//
//  CollectionViewCell.h
//  News
//
//  Created by 国栋 on 16/2/24.
//  Copyright © 2016年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property UIImageView *image;
@property UILabel *title;
@property NSURLSessionDataTask *task;

-(void)setImageURL:(NSString *)imageURL;
-(void)endDisplay;

@end
