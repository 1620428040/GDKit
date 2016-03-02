//
//  GDCoreTree.h
//  GDFW
//
//  Created by 国栋 on 15/12/24.
//  Copyright (c) 2015年 GD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDCoreTree : NSObject

@property NSString *name;
@property int level;

@property GDCoreTree *upLevel;

@property GDCoreTree *next;
@property GDCoreTree *before;

@property GDCoreTree *first;
@property GDCoreTree *last;

@property (readonly)NSString *index;

+(GDCoreTree*)creatTreeWithName:(NSString*)tname;//创建根
-(GDCoreTree*)addPathWithName:(NSString*)tname;//创建分支
-(void)print;

@end
