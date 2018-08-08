//
//  XXSYDIYHeader.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/24.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYDIYHeader.h"
@interface XXSYDIYHeader()
/** 显示刷新状态的label */
@property (weak, nonatomic) UILabel *stateLabel;
@property (weak, nonatomic) XXSYRefreshCircleView *circleView;
@property (weak, nonatomic) UIImageView *headerImageView;
@property (assign, nonatomic) BOOL navigationBarHidden;
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation XXSYDIYHeader
#pragma mark---public method
+ (instancetype)headerWithNavgationBarHidden:(BOOL)navigationBarHidden RefreshingBlock:(XXSYRefreshComponentRefreshingBlock)refreshingBlock
{
    XXSYDIYHeader *header = [[self alloc]init];
    header.navigationBarHidden = navigationBarHidden;
    header.refreshingBlock = refreshingBlock;
    return header;
}

#pragma mark--set and get

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = XXSYRefreshLabelFont;
        label.textColor = XXSYRefreshLabelTextColor;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor greenColor];
        [self addSubview:_stateLabel = label];
    }
    return _stateLabel;
}

- (XXSYRefreshCircleView *)circleView
{
    if (!_circleView) {
        XXSYRefreshCircleView *circleView = [[XXSYRefreshCircleView alloc]initWithFrame:CGRectZero];
        circleView.backgroundColor = [UIColor redColor];
        [self addSubview:_circleView=circleView];
    }
    return _circleView;
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        UIImageView *headerImageView = [[UIImageView alloc]init];
        headerImageView.image = [UIImage imageNamed:@"homePageRefreshImage"];
        headerImageView.contentMode =  UIViewContentModeScaleToFill;
        [self insertSubview:_headerImageView = headerImageView atIndex:0];
    }
    return _headerImageView;
}

- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        _stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    [self.circleView updateWithProgress:MIN(pullingPercent, 1)];
    
}
#pragma mark--继承父类的方法
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.mj_h = (self.navigationBarHidden&&IphoneX)?XXSYRefreshHeaderHeight_iphoneX:XXSYRefreshHeaderHeight;
}
- (void)prepare
{
     NSLog(@"%f",self.scrollView.mj_inset.top);
    [super prepare];
    self.stateLabel.hidden = YES;
    self.circleView.hidden = NO;
    [self setTitle:@"刷新成功" forState:XXSYRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:XXSYRefreshStatePulling];
    [self setTitle:@"正在刷新数据中..." forState:XXSYRefreshStateRefreshing];
}

- (void)placeSubviews
{
    [super placeSubviews];
     self.mj_h = (self.navigationBarHidden&&IphoneX)?XXSYRefreshHeaderHeight_iphoneX:XXSYRefreshHeaderHeight;
    if (self.navigationBarHidden)
    {
        self.headerImageView.mj_size = CGSizeMake(self.mj_w, self.mj_w*858/1242.0);
        self.headerImageView.mj_x = 0;
        self.headerImageView.mj_y = self.mj_h -self.mj_w*858/1242.0;
        
    }
    self.stateLabel.frame = CGRectMake(0, (self.navigationBarHidden&&IphoneX)?XXSYRefreshIphoneXDelta:0,self.mj_w,(self.navigationBarHidden&&IphoneX)?XXSYRefreshHeaderHeight_iphoneX-XXSYRefreshIphoneXDelta:XXSYRefreshHeaderHeight);
    self.circleView.mj_w = 30.0f;
    self.circleView.mj_h = 30.0f;
    self.circleView.center = CGPointMake(self.mj_w*0.5,(self.navigationBarHidden&&IphoneX)?   XXSYRefreshIphoneXDelta + (XXSYRefreshHeaderHeight_iphoneX-XXSYRefreshIphoneXDelta)*0.5: XXSYRefreshHeaderHeight*0.5 );
//    self.circleView.mj_centerX = self.mj_w*0.5;
//    self.circleView.mj_centerY = (self.navigationBarHidden&&IphoneX)?self.mj_h*0.5+XXSYRefreshIphoneXDelta : self.mj_h*0.5;
}

//这里不调用super了，自己DIY
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    if (self.state == XXSYRefreshStateRefreshing) {
        if (self.window==nil) return;
        
        CGFloat insertT = -self.scrollView.mj_offsetY > _scrollViewOriginalInset.top?-self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insertT = insertT> self.mj_h +_scrollViewOriginalInset.top?self.mj_h +_scrollViewOriginalInset.top:insertT;
        
        self.insetTDelta = _scrollViewOriginalInset.top-insertT;
        return;
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
     CGFloat pullingPercent_iPhoneX =  ((happenOffsetY - offsetY)-XXSYRefreshIphoneXDelta) / (self.mj_h-XXSYRefreshIphoneXDelta);
    if (self.scrollView.isDragging) {
        if (self.navigationBarHidden&&IphoneX) {
            if ((happenOffsetY - offsetY)<XXSYRefreshIphoneXDelta) {
                self.pullingPercent = 0;
            }else
            {
                self.pullingPercent = pullingPercent_iPhoneX;
            }
        }else
        {
            self.pullingPercent = pullingPercent;
        }
        
        if (self.state == XXSYRefreshStateIdle && offsetY<normal2pullingOffsetY) {
            self.state = XXSYRefreshStatePulling;
        }else if (self.state == XXSYRefreshStatePulling &&  offsetY>= normal2pullingOffsetY){
            self.state = XXSYRefreshStateIdle;
        }
    }else if (self.state == XXSYRefreshStatePulling)
    {
        [self beginRefreshing];
    }else if (pullingPercent < 1) {
        if (self.navigationBarHidden&&IphoneX) {
            if ((happenOffsetY - offsetY)<XXSYRefreshIphoneXDelta) {
                self.pullingPercent = 0;
            }else
            {
                self.pullingPercent = pullingPercent_iPhoneX;
            }
        }else
        {
            self.pullingPercent = pullingPercent;
        }
    }
}

//这里不调用super了，自己DIY
- (void)setState:(XXSYRefreshState)state
{
    XXSYRefreshState oldState = self.state;
    if (state == oldState) return;
//XXSYRefreshComponent method
    _state = state;
    // 加入主队列的目的是等setState:方法调用完毕、设置完文字后再去布局子控件
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsLayout];
    });
// XXSYRefreshHeader method
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
    
    if (state == XXSYRefreshStateIdle)
    {
        if (oldState == XXSYRefreshStateRefreshing) {//先隐藏circle显示statelabel，然后延迟一下，回去
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [UIView animateWithDuration:XXSYRefreshFastAnimationDuration animations:^{
                self.circleView.alpha = 0;
            } completion:^(BOOL finished) {
                [self.circleView resignNormal];
                self.circleView.alpha = 1;
                self.circleView.hidden = YES;
                self.stateLabel.hidden = NO;
                [UIView animateWithDuration:XXSYRefreshSlowAnimationDuration delay:0.8 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.scrollView.mj_insetT += self.insetTDelta;
                    // 自动调整透明度
                    if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
                } completion:^(BOOL finished) {
                    self.pullingPercent = 0.0;
                    self.circleView.hidden = NO;
                    self.stateLabel.hidden = YES;
                    if (self.endRefreshingCompletionBlock) {
                        self.endRefreshingCompletionBlock();
                    }
                }];
                
            }];
        }else
        {
            self.circleView.hidden = NO;
            self.stateLabel.hidden = YES;
        }
    }else if (state == XXSYRefreshStateRefreshing)
    {
        [self.circleView updateWithProgress:1.0];
        [self.circleView startRefreshAnimation];
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

#pragma mark--custom method
- (void)setTitle:(NSString *)title forState:(XXSYRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

@end
