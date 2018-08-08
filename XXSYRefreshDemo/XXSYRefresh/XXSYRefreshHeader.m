//
//  XXSYRefreshHeader.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/23.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYRefreshHeader.h"
@interface XXSYRefreshHeader()
@end


@implementation XXSYRefreshHeader

+ (instancetype)headerWithRefreshingBlock:(XXSYRefreshComponentRefreshingBlock)refreshingBlock
{
    XXSYRefreshHeader *header = [[self alloc] init];
    header.refreshingBlock = refreshingBlock;
    return header;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    XXSYRefreshHeader *header = [[self alloc] init];
    [header setRefreshingTarget:target refreshingAction:action];
    return header;
}


#pragma mark---覆盖父类方法
- (void)prepare
{
    [super prepare];
    //刷新时间key
    self.lastUpdatedTimeKey = XXSYRefreshHeaderLastUpdatedTimeKey;
    self.mj_h = XXSYRefreshHeaderHeight;
   
}

- (void)placeSubviews
{
    [super placeSubviews];
    // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
    self.mj_y = - self.mj_h - self.ignoredScrollViewContentInsetTop;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    if (self.state == XXSYRefreshStateRefreshing) {
        if (self.window==nil) return;
        
        CGFloat insertT = -self.scrollView.mj_offsetY > _scrollViewOriginalInset.top?-self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insertT = insertT> self.mj_h +_scrollViewOriginalInset.top?self.mj_h +_scrollViewOriginalInset.top:insertT;
        
        self.insetTDelta = _scrollViewOriginalInset.top-insertT;
    }
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.mj_inset;
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
    CGFloat pullingPercent = (happenOffsetY - offsetY)/self.mj_h;
    if (self.scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        if (self.state == XXSYRefreshStateIdle && offsetY<normal2pullingOffsetY) {
            self.state = XXSYRefreshStatePulling;
        }else if (self.state == XXSYRefreshStatePulling &&  offsetY>= normal2pullingOffsetY){
            self.state = XXSYRefreshStateIdle;
        }
    }else if (self.state == XXSYRefreshStatePulling)
    {
        [self beginRefreshing];
    }else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
    
}

- (void)setState:(XXSYRefreshState)state
{
    XXSYRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    //
    if (state == XXSYRefreshStateIdle) {
        if (oldState != XXSYRefreshStateRefreshing) return;
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [UIView animateWithDuration:XXSYRefreshSlowAnimationDuration animations:^{
            self.scrollView.mj_insetT += self.insetTDelta;
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
    }else if (state == XXSYRefreshStateRefreshing){
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:XXSYRefreshFastAnimationDuration animations:^{
                CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
                // 增加滚动区域top
                self.scrollView.mj_insetT = top;
                // 设置滚动位置
                CGPoint offset = self.scrollView.contentOffset;
                offset.y = -top;
                [self.scrollView setContentOffset:offset animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }
    
}

#pragma mark---get and set
- (NSDate *)lastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}
- (void)setIgnoredScrollViewContentInsetTop:(CGFloat)ignoredScrollViewContentInsetTop
{
    _ignoredScrollViewContentInsetTop = ignoredScrollViewContentInsetTop;
    self.mj_y = - self.mj_h - _ignoredScrollViewContentInsetTop;
}
@end
