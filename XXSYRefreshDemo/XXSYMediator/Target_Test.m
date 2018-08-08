//
//  Target_Test.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "Target_Test.h"
#import "TestViewController.h"
#import "XXSYCoreTextViewController.h"

#define Return_ActionDefine(vcName) \
- (UIViewController *)Action_##vcName:(NSDictionary *)params{ \
vcName *viewController = [[vcName alloc] init];\
viewController.baseParams = params;\
return viewController;\
}\

typedef void (^CallbackBlock)(NSDictionary *infoDic);

@implementation Target_Test

Return_ActionDefine(TestViewController);

Return_ActionDefine(XXSYCoreTextViewController);

- (id)Action_ShowAlert:(NSDictionary *)params
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CallbackBlock callback = params[@"cancelAction"];
        if (callback) {
            callback(@{@"name1":@"liming"});
        }
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CallbackBlock callback = params[@"confirmAction"];
        if (callback) {
            callback(@{@"name":@"liming"});
        }
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:params[@"message"]?:@"没有message" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return nil;
}
@end
