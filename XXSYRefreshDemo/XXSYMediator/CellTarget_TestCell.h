//
//  CellTarget_TestCell.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TestCellProtocol.h"
/**
 *  @description
 *  place模块 负责创建各个cell作为中间件，这个cell不在当前模块，用temp替代
 *  @importent
 *  方法名Action_后面跟的是类名
 */
@interface CellTarget_TestCell : NSObject
- (UITableViewCell *)Action_TestListCell:(NSDictionary *)params;
@end
