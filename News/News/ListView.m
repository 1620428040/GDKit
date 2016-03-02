//
//  ListView.m
//  News
//
//  Created by 国栋 on 16/2/25.
//  Copyright © 2016年 GD. All rights reserved.
//

#import "ListView.h"

@implementation ListView
@synthesize mainDisplayDelegate,newsList,cellHeight;

+(instancetype)createWithFrame:(CGRect)frame data:(NSArray *)array delegate:(id)theDelegate
{
    ListView *listView=[[self alloc]initWithFrame:frame];
    listView.newsList=array;
    listView.mainDisplayDelegate=theDelegate;
    [listView layout];
    return listView;
}
-(void)layout
{
    self.delegate=self;
    self.dataSource=self;
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell==nil) {
        cell=[[ListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        cell.textLabel.numberOfLines=0;
    }
    cell.textLabel.text=newsList[indexPath.row].title;
    [cell sizeToFit];
    cellHeight=cell.frame.size.height;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cellHeight!=0) {
        return cellHeight;
    }
    else
        return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mainDisplayDelegate didSelectItemAtIndexPath:indexPath];
}

@end
