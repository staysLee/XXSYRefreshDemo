//
//  CTFrameParserConfig.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/6.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "CTFrameParserConfig.h"
#define RGB(A, B, C)    [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]

@implementation CTFrameParserConfig

- (id)init
{
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = RGB(108, 108, 108);
    }
    return self;
}
@end
