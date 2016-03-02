//
//  GDTree.m
//  key
//
//  Created by 国栋 on 15/12/18.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "GDTree.h"

NSMutableArray *rootList;//所有树的列表

@implementation GDTree
@synthesize name,level,upLevel,list;

+(id)creatTreeWithName:(NSString *)tname
{
    if (rootList==nil) {
        rootList=[NSMutableArray array];
    }
    GDTree *root=[[GDTree alloc]init];
    root.name=tname;
    root.level=0;
    root.upLevel=nil;
    root.list=[NSMutableArray array];
    [rootList addObject:root];
    return root;
}
-(id)addPath
{
    GDTree *path=[[GDTree alloc]init];
    path.upLevel=self;
    path.level=path.upLevel.level+1;
    path.list=[NSMutableArray array];
    [list addObject:path];
    return path;
}
-(id)addPathWithName:(NSString *)tname
{
    GDTree *path=[[GDTree alloc]init];
    path.name=tname;
    path.upLevel=self;
    path.level=path.upLevel.level+1;
    path.list=[NSMutableArray array];
    [list addObject:path];
    return path;
}
-(NSString *)description
{
    NSString *space=[NSString stringWithFormat:@"\n%d  ",level];
    for (int i=0;i<level;i++) {
        space=[NSString stringWithFormat:@"%@--  ",space];
    }
    NSString *description=[NSString stringWithFormat:@"%@%@",space,name];
    for (GDTree *path in list) {
        description=[NSString stringWithFormat:@"%@%@",description,[path description]];
    }
    return description;
}
-(NSMutableArray *)searchCurrentPathWithName:(NSString *)tname
{
    return [self searchCurrentPathIn:@"name" With:tname];
}
-(NSMutableArray *)searchCurrentPathIn:(NSString *)tproperty With:(NSString *)tvalue
{
    NSMutableArray *paths=[NSMutableArray array];
    if ([[self valueForKey:tproperty] isEqualToString:tvalue]) {
        [paths addObject:self];
    }
    for (GDTree *path in list) {
        NSMutableArray *back=[path searchCurrentPathIn:tproperty With:tvalue];
        if (back!=nil) {
            [paths addObjectsFromArray:back];
        }
    }
    if (paths.count==0) {
        paths=nil;
    }
    return paths;
}
/*带返回值的函数块示例
typedef BOOL(^Search)(GDTree* current);
Search search=^(GDTree* current){
    if([current.name isEqualToString: @"revqv"])
    {
        return YES;
    }
    else return NO;
};
 */
-(NSMutableArray *)searchCurrentPathBlock:(BOOL (^)(GDTree *))seachBlock
{
    NSMutableArray *paths=[NSMutableArray array];
    if (seachBlock(self)) {
        [paths addObject:self];
    }
    for (GDTree *path in list) {
        NSMutableArray *back=[path searchCurrentPathBlock:seachBlock];
        if (back!=nil) {
            [paths addObjectsFromArray:back];
        }
    }
    if (paths.count==0) {
        paths=nil;
    }
    return paths;
}
-(NSString *)getIndexForPath:(GDTree *)ttree
{
    return [ttree index];
}
-(NSString *)index
{
    if (upLevel==nil) {
        return [NSString stringWithFormat:@"%d",(int)[rootList indexOfObject:self]];
    }
    else
    {
        return [NSString stringWithFormat:@"%@/%d",upLevel.index,(int)[upLevel.list indexOfObject:self]];
    }
}
-(GDTree *)getPathWithIndex:(NSString*)tindex
{
    NSArray *indexs=[tindex componentsSeparatedByString:@"/"];
    GDTree *back=[rootList objectAtIndex:[[indexs firstObject]intValue]];
    for (int i=1;i<indexs.count;i++) {
        back=[back.list objectAtIndex:[[indexs objectAtIndex:i]intValue]];
    }
    return back;
}
@end
