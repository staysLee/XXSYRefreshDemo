//
//  XXSYRefreshConst.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>

#define IphoneX CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen]currentMode].size)
//#define IphoneXStatusBar_HEIGHT 44.0f
// 运行时objc_msgSend
#define XXSYRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define XXSYRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define XXSYRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 字体大小
#define XXSYRefreshLabelFont [UIFont boldSystemFontOfSize:14]
// 文字颜色
#define XXSYRefreshLabelTextColor XXSYRefreshColor(90, 90, 90)

UIKIT_EXTERN const CGFloat XXSYRefreshLabelLeftInset;
UIKIT_EXTERN const CGFloat XXSYRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat XXSYRefreshIphoneXDelta;
UIKIT_EXTERN const CGFloat XXSYRefreshHeaderHeight_iphoneX;

UIKIT_EXTERN const CGFloat XXSYRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat XXSYRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const XXSYRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const XXSYRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const XXSYRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const XXSYRefreshKeyPathPanState;


UIKIT_EXTERN NSString *const XXSYRefreshHeaderLastUpdatedTimeKey;
