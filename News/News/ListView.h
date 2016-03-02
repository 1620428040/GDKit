//
//  ListView.h
//  News
//
//  Created by 国栋 on 16/2/25.
//  Copyright © 2016年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsManager.h"
#import "MainDisplayProtocol.h"
#import "ListViewCell.h"

@interface ListView : UITableView<MainDisplayProtocol,UITableViewDataSource,UITableViewDelegate>
@property id<MainDisplayDelegate> mainDisplayDelegate;
@property NSArray<News*>* newsList;
@property float cellHeight;

@end
