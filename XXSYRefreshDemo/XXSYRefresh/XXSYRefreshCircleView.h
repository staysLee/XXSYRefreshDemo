//
//  XXSYRefreshCircleView.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/24.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXSYRefreshCircleView : UIView

@property (nonatomic, assign) float progress;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) BOOL isAnimation;
- (void)updateWithProgress:(float)progress;
- (void)startRefreshAnimation;
- (void)resignNormal;

@end
