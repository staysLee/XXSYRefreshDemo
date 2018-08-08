//
//  XXSYTabBar.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/3.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CenterItemBlock)(void);

@interface XXSYTabBar : UITabBar
@property (nonatomic, copy) CenterItemBlock centerBlock;
@end
