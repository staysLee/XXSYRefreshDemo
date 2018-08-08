//
//  XXSYMediator.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface XXSYMediator : NSObject
+ (instancetype)sharedMediator;
//normalTarget
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;
//cellTarget
- (id)performCellTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;
@end
NS_ASSUME_NONNULL_END
