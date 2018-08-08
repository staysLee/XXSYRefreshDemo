//
//  XXSYRefreshNormalHeader.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/24.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYRefreshStateHeader.h"

@interface XXSYRefreshNormalHeader : XXSYRefreshStateHeader
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
@end
