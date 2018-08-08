//
//  XXSYRefreshStateHeader.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/24.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYRefreshHeader.h"


@interface XXSYRefreshStateHeader : XXSYRefreshHeader
#pragma mark - 刷新时间相关
/** 显示上一次刷新时间的label */
@property (weak, nonatomic, readonly) UILabel *lastUpdatedTimeLabel;
#pragma mark - 状态相关
/** 文字距离圈圈、箭头的距离 */
@property (assign, nonatomic) CGFloat labelLeftInset;
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(XXSYRefreshState)state;
@end
