//
//  XXSYTabBar.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/3.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYTabBar.h"
#import "UIView+MJExtension.h"
@interface XXSYTabBar ()
@property (nonatomic, strong) UIButton *centerButtonItem;
@end

@implementation XXSYTabBar
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat itemWidth = self.mj_w/(self.items.count + 1);
    __block CGFloat itemHeight = 0;
    __block CGFloat itemY = 0;
    NSMutableArray<UIView *> *tabBarButtonsArray = [NSMutableArray array];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonsArray addObject:obj];
            obj.mj_w = itemWidth;
            itemHeight = obj.mj_h;
            itemY = obj.mj_y;
        }
    }];
    [tabBarButtonsArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx<=1) {
            obj.mj_x = idx *itemWidth;
        }else
        {
            obj.mj_x = (idx + 1)*itemWidth;
        }
    }];
    [self bringSubviewToFront:self.centerButtonItem];
    self.centerButtonItem.mj_size = CGSizeMake(itemWidth, itemHeight);
    self.centerButtonItem.mj_centerX = self.mj_w * 0.5;
    self.centerButtonItem.mj_y = itemY;
}


- (UIButton *)centerButtonItem
{
    if (!_centerButtonItem) {
        _centerButtonItem = [[UIButton alloc] init];
        [_centerButtonItem setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_centerButtonItem setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        _centerButtonItem.imageView.contentMode = UIViewContentModeCenter;
        [_centerButtonItem addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerButtonItem];
    }
    return _centerButtonItem;
}

- (void)buttonClickAction:(UIButton *)btn
{
    if (self.centerBlock) {
        self.centerBlock();
    }
}
@end
