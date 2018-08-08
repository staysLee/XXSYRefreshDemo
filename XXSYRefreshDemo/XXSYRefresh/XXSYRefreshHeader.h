//
//  XXSYRefreshHeader.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/23.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYRefreshComponent.h"

@interface XXSYRefreshHeader : XXSYRefreshComponent
+ (instancetype)headerWithRefreshingBlock:(XXSYRefreshComponentRefreshingBlock)refreshingBlock;
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;
/** 这个key用来存储上一次下拉刷新成功的时间 */
@property (copy, nonatomic) NSString *lastUpdatedTimeKey;
/** 上一次下拉刷新成功的时间 */
@property (strong, nonatomic, readonly) NSDate *lastUpdatedTime;
/** 忽略多少scrollView的contentInset的top */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;
@property (assign, nonatomic) CGFloat insetTDelta;
@end
