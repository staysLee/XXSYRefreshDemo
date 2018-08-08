//
//  XXSYRefreshComponent.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXSYRefreshConst.h"
#import "UIView+MJExtension.h"
#import "UIScrollView+MJExtension.h"

typedef NS_ENUM(NSInteger,XXSYRefreshState) {
    /** 普通闲置状态 */
    XXSYRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    XXSYRefreshStatePulling,
    /** 正在刷新中的状态 */
    XXSYRefreshStateRefreshing,
    /** 即将刷新的状态 */
    XXSYRefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    XXSYRefreshStateNoMoreData
};
/***进入刷新****/
typedef void (^XXSYRefreshComponentRefreshingBlock)(void);
/** 开始刷新后的回调(进入刷新状态后的回调) */
typedef void (^XXSYRefreshComponentbeginRefreshingCompletionBlock)(void);
/** 结束刷新后的回调 */
typedef void (^XXSYRefreshComponentEndRefreshingCompletionBlock)(void);
@interface XXSYRefreshComponent : UIView
{
    /** 记录scrollView刚开始的inset */
    UIEdgeInsets _scrollViewOriginalInset;
    /** 父控件 */
    __weak UIScrollView *_scrollView;
    XXSYRefreshState _state;
}
#pragma mark - 刷新回调
/** 正在刷新的回调 */
@property (copy, nonatomic) XXSYRefreshComponentRefreshingBlock refreshingBlock;
/** 设置回调对象和回调方法 */
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
/** 回调对象 */
@property (weak, nonatomic) id refreshingTarget;
/** 回调方法 */
@property (assign, nonatomic) SEL refreshingAction;
/** 触发回调（交给子类去调用） */
- (void)executeRefreshingCallback;

#pragma mark --
@property (weak,nonatomic) UIScrollView *scrollView;

#pragma mark - 刷新状态控制
/** 刷新状态 一般交给子类内部实现 */
@property (assign, nonatomic) XXSYRefreshState state;

/** 是否正在刷新 */
@property (assign, nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

/** 进入刷新状态 */
- (void)beginRefreshing;
- (void)beginRefreshingWithCompletionBlock:(void (^)(void))completionBlock;
/** 开始刷新后的回调(进入刷新状态后的回调) */
@property (copy, nonatomic) XXSYRefreshComponentbeginRefreshingCompletionBlock beginRefreshingCompletionBlock;
/** 结束刷新状态 */
- (void)endRefreshing;
/** 结束刷新的回调 */
@property (copy, nonatomic) XXSYRefreshComponentEndRefreshingCompletionBlock endRefreshingCompletionBlock;
- (void)endRefreshingWithCompletionBlock:(void (^)(void))completionBlock;
#pragma mark--父类方法，子类继承
/** 初始化 */
- (void)prepare NS_REQUIRES_SUPER;
/** 摆放子控件frame */
- (void)placeSubviews NS_REQUIRES_SUPER;
/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change ;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change ;
/** 当scrollView的拖拽状态发生改变的时候调用 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
#pragma mark - 交给子类去访问
/** 记录scrollView刚开始的inset */
@property (assign, nonatomic, readonly) UIEdgeInsets scrollViewOriginalInset;

/** 拉拽的百分比(交给子类重写) */
@property (assign, nonatomic) CGFloat pullingPercent;


/** 根据拖拽比例自动切换透明度 */
@property (assign, nonatomic, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;
@end

@interface UILabel(XXSYRefresh)
+ (instancetype)xxsy_label;
- (CGFloat)xxsy_textWith;
@end
