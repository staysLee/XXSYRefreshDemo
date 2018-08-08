//
//  XXSYMediator+TestCell.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYMediator+TestCell.h"
//target
NSString *const kXXSYMediatorTarget_TestCell = @"TestCell";
//action
NSString *const kXXSYMediatorAction_TestListCell = @"TestListCell";

#define Return_PerformTarget(a,b,c)\
UITableViewCell *viewCell = [self performCellTarget:a action:b params:c];\
return viewCell;\

@implementation XXSYMediator (TestCell)
- (UITableViewCell*)XXSYMediator_TestListCellWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier
{
    NSDictionary *params = @{@"tableView":tableView,@"identifier":identifier};
    Return_PerformTarget(kXXSYMediatorTarget_TestCell,kXXSYMediatorAction_TestListCell,params);
}


@end
