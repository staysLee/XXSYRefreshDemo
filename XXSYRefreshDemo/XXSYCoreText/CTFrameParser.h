//
//  CTFrameParser.h
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/6.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"

@interface CTFrameParser : NSObject
+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;
+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;
@end
