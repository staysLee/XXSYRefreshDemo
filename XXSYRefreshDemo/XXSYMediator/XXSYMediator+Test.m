//
//  XXSYMediator+Test.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYMediator+Test.h"
//target
NSString *const kXXSYMediatorTarget_Test = @"Test";
//action
NSString *const kXXSYMediatorAction_TestViewController = @"TestViewController";
NSString *const kXXSYMediatorAction_CoreTextViewController = @"XXSYCoreTextViewController";
NSString *const kXXSYMediatorAction_ReadViewController = @"ReadViewController";
NSString *const kXXSYMediatorAction_ShowAlert = @"ShowAlert";

#define Return_PerformTarget(a,b,c) \
UIViewController *viewController = [self performTarget:a action:b params:c];\
if ([viewController isKindOfClass:[UIViewController class]]) {\
return viewController;\
} else {\
return [[UIViewController alloc] init];\
}\

@implementation XXSYMediator (Test)
- (UIViewController *)XXSYMediator_TestViewController
{
    NSDictionary *params = @{@"title":@"这是传递的参数title"};
    Return_PerformTarget(kXXSYMediatorTarget_Test, kXXSYMediatorAction_TestViewController, params);
}

- (UIViewController *)XXSYMediator_CoreTextViewController
{
    NSDictionary *params = @{@"title":@"这是传递的参数title"};
    Return_PerformTarget(kXXSYMediatorTarget_Test, kXXSYMediatorAction_CoreTextViewController, params);
}

- (UIViewController *)XXSYMediator_ReadViewController
{
    NSDictionary *params = @{@"title":@"这里是传递的参数title"};
    Return_PerformTarget(kXXSYMediatorTarget_Test, kXXSYMediatorAction_ReadViewController, params);
}

- (void)XXSYMediator_ShowAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (message) {
        params[@"message"] = message;
    }
    if (cancelAction) {
        params[@"cancelAction"] = cancelAction;
    }
    if (confirmAction) {
        params[@"confirmAction"] = confirmAction;
    }
    [self performTarget:kXXSYMediatorTarget_Test action:kXXSYMediatorAction_ShowAlert params:params];
}
@end
