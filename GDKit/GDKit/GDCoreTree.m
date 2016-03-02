//
//  GDCoreTree.m
//  GDFW
//
//  Created by 国栋 on 15/12/24.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import "GDCoreTree.h"

@interface GDCoreTree ()

@end

@implementation GDCoreTree

+(id)creatTreeWithName:(NSString *)tname
{
    GDCoreTree *root=[[GDCoreTree alloc]init];
    root.name=tname;
    return root;
}
-(GDCoreTree *)addPathWithName:(NSString *)tname
{
    GDCoreTree *new=[[GDCoreTree alloc]init];
    if (self.first==nil&&self.last==nil) {
        self.first=new;
        self.last=new;
    }
    else
    {
        new.before=self.last;
        self.last.next=new;
        self.last=new;
    }
    new.upLevel=self;
    new.name=tname;
    new.level=self.level+1;
    return new;
}
-(void)print
{
    func(self);
}
void func(GDCoreTree *p)
{
    NSLog(@"name=%@  up=%@",p.name,p.upLevel.name);
    if (p.first!=nil) {
        func(p.first);
    }
    else func2(p);
}
void func2(GDCoreTree *p)
{
    if (p.next!=nil)
    {
        func(p.next);
    }
    else if(p.upLevel!=nil)
    {
        func2(p.upLevel);
    }
}
@end
