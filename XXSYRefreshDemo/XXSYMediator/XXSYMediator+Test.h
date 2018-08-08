//
//  XXSYMediator+Test.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYMediator.h"

@interface XXSYMediator (Test)
- (UIViewController *)XXSYMediator_TestViewController;
- (UIViewController *)XXSYMediator_CoreTextViewController;
- (void)XXSYMediator_ShowAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction;
@end
