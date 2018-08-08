//
//  UIScrollView+XXSYRefresh.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/25.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXSYRefreshConst.h"
@class XXSYRefreshHeader;

@interface UIScrollView (XXSYRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic) XXSYRefreshHeader *xxsy_header;
@end
