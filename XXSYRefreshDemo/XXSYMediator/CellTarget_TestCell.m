//
//  CellTarget_TestCell.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "CellTarget_TestCell.h"
#import "TestListCell.h"

#define Return_ActionDefine(preCellName) \
- (UITableViewCell *)Action_##preCellName:(NSDictionary *)params {\
UITableView *tableView = [params objectForKey:@"tableView"];\
NSString *identifier = [params objectForKey:@"identifier"];\
UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];\
if (nil == cell) {\
if (NSClassFromString(@#preCellName)) {\
cell = [[NSClassFromString(@#preCellName) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];\
} else {\
cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];\
}\
}\
return cell;\
}\

@implementation CellTarget_TestCell
Return_ActionDefine(TestListCell);
@end
