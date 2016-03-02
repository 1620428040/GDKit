//
//  NewsViewController.h
//  News
//
//  Created by 国栋 on 16/2/19.
//  Copyright © 2016年 GD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideView.h"
#import "MainDisplayProtocol.h"
#import "ListView.h"
#import "CollectionView.h"
#import "NewsTypeManager.h"
#import "NewsManager.h"
#import "DetailsViewController.h"

@interface NewsViewController : UIViewController<SideViewDelegate,UITableViewDataSource,UITableViewDelegate,NewsTypeManagerDelegate,NewsManagerDelegate,MainDisplayDelegate>

@end
