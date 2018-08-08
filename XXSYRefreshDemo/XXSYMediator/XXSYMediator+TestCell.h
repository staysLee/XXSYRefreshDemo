//
//  XXSYMediator+TestCell.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYMediator.h"
#import "TestCellProtocol.h"

@interface XXSYMediator (TestCell)
- (UITableViewCell *)XXSYMediator_TestListCellWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier;
@end
