//
//  XXSYDIYHeader.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/24.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYRefreshHeader.h"
#import "XXSYRefreshCircleView.h"

@interface XXSYDIYHeader : XXSYRefreshHeader
+ (instancetype)headerWithNavgationBarHidden:(BOOL)navigationBarHidden RefreshingBlock:(XXSYRefreshComponentRefreshingBlock)refreshingBlock;
@end
