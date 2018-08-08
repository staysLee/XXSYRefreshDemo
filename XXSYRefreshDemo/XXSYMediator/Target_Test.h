//
//  Target_Test.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  @description
 *  Route模块 负责创建各个controller的类
 *  @importent
 *  方法名Action_后面跟的是类名
 *  只有一个参数  类型字典
 */
@interface Target_Test : NSObject
- (UIViewController *)Action_TestViewController:(NSDictionary *)params;
- (UIViewController *)Action_XXSYCoreTextViewController:(NSDictionary *)params;
- (UIViewController *)Action_ReadViewController:(NSDictionary *)params;
- (id)Action_ShowAlert:(NSDictionary *)params;
@end
