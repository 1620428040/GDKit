//用对象树的形式储存一些信息
/*//调用的示例
DTree *myTree=[GDTree creatTreeWithName:@"myTree"];
GDTree *effw=[myTree addPathWithName:@"cdvcrevw"];
[myTree addPathWithName:@"revqv"];
GDTree *as=[myTree addPathWithName:@"as"];
GDTree *yu=[[[[[[[[[[[[[[[as addPathWithName:@"ccwevev"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"]addPathWithName:@"dfcwe"];
GDTree *aw=[yu addPathWithName:@"vcdgv"];
GDTree *a2w=[yu addPathWithName:@"vcdgv"];

NSLog(@"%@",[myTree searchCurrentPathBlock:search]);
*/

#import <Foundation/Foundation.h>

@interface GDTree : NSObject

@property NSString *name;
@property int level;
@property GDTree *upLevel;
@property NSMutableArray *list;
@property (readonly)NSString *index;

+(GDTree*)creatTreeWithName:(NSString*)tname;//创建根
-(GDTree*)addPathWithName:(NSString*)tname;//创建分支
-(GDTree*)addPath;

-(NSMutableArray*)searchCurrentPathWithName:(NSString*)tname;
-(NSMutableArray*)searchCurrentPathIn:(NSString*)tproperty With:(NSString*)tname;
-(NSMutableArray *)searchCurrentPathBlock:(BOOL (^)(GDTree* current))seachBlock;
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

-(NSString*)getIndexForPath:(GDTree*)ttree;
-(GDTree*)getPathWithIndex:(NSString*)tindex;


//要在各节点存储的信息，例如
@property NSDate *date;
@property NSString *str;
@property NSInteger num;

@end
