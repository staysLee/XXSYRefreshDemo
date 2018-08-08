//
//  UIScrollView+XXSYRefresh.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/25.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "UIScrollView+XXSYRefresh.h"
#import "XXSYRefreshHeader.h"

static const char XXSYRefreshHeaderKey = '\0';
@implementation UIScrollView (XXSYRefresh)
- (void)setXxsy_header:(XXSYRefreshHeader *)xxsy_header
{
    if (xxsy_header != self.xxsy_header) {
        [self.xxsy_header removeFromSuperview];
        [self insertSubview:xxsy_header atIndex:0];
    }
    objc_setAssociatedObject(self, &XXSYRefreshHeaderKey, xxsy_header, OBJC_ASSOCIATION_RETAIN);
}


- (XXSYRefreshHeader *)xxsy_header
{
    return objc_getAssociatedObject(self, &XXSYRefreshHeaderKey);
}
@end
