//
//  XXSYRefreshStateHeader.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/24.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYRefreshStateHeader.h"
@interface XXSYRefreshStateHeader ()
{
    __unsafe_unretained UILabel *_lastUpdatedTimeLabel;
    __unsafe_unretained UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end


@implementation XXSYRefreshStateHeader


#pragma mark--set and get
- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = XXSYRefreshLabelFont;
        label.textColor = XXSYRefreshLabelTextColor;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:_stateLabel = label];
    }
    return _stateLabel;
}

- (UILabel *)lastUpdatedTimeLabel
{
    if (!_lastUpdatedTimeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = XXSYRefreshLabelFont;
        label.textColor = XXSYRefreshLabelTextColor;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:_lastUpdatedTimeLabel = label];
    }
    return _lastUpdatedTimeLabel;
}

- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        _stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    if (self.lastUpdatedTimeLabel.hidden) return;
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    if (lastUpdatedTime) {
        
        NSCalendar *calendar = [self currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        BOOL isToday = NO;
        if ([cmp1 day]==[cmp2 day]) {
            formatter.dateFormat = @"HH:mm";
            isToday = YES;
        }else if ([cmp1 year]==[cmp2 year])
        {
            formatter.dateFormat = @"MM-dd HH:mm";
        }else
        {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        // 3.显示日期
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@%@",
                                          @"最后更新：",
                                          isToday ? @"今天" : @"",
                                          time];
    }else
    {
        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@",
                                          @"最后更新：",
                                          @"无记录"];
    }
}

- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    //
    self.labelLeftInset = XXSYRefreshLabelLeftInset;
    [self setTitle:@"下拉可以刷新" forState:XXSYRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:XXSYRefreshStatePulling];
    [self setTitle:@"正在刷新数据中..." forState:XXSYRefreshStateRefreshing];
}

- (void)placeSubviews
{
    [super placeSubviews];
    if (self.stateLabel.hidden) return;
    BOOL noConstrainsOnStatusLabel = self.stateLabel.constraints.count == 0;
    if (self.lastUpdatedTimeLabel.hidden) {
        if (noConstrainsOnStatusLabel) self.stateLabel.frame = self.bounds;
    }else
    {
        CGFloat statelabelH = self.mj_h*0.5;
        if (noConstrainsOnStatusLabel) {
            self.stateLabel.mj_x = 0;
            self.stateLabel.mj_y= 0;
            self.stateLabel.mj_w = self.mj_w;
            self.mj_h = statelabelH;
        }
        //更新时间
        if (self.lastUpdatedTimeLabel.constraints.count==0) {
            self.lastUpdatedTimeLabel.mj_x = 0;
            self.lastUpdatedTimeLabel.mj_y = statelabelH;
            self.lastUpdatedTimeLabel.mj_w = self.mj_w;
            self.lastUpdatedTimeLabel.mj_h = self.mj_h - self.lastUpdatedTimeLabel.mj_y;
        }
        
    }
}

- (void)setState:(XXSYRefreshState)state
{
    XXSYRefreshState oldState = self.state;
    if (state == oldState) return;
    [super setState:state];
    
    //设置文字状态
    self.stateLabel.text = self.stateTitles[@(state)];
    //重新设定key
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
    
}



- (void)setTitle:(NSString *)title forState:(XXSYRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}


@end
