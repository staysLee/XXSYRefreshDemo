//
//  CTDisplayView.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/6.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "CTDisplayView.h"

@implementation CTDisplayView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, context);
    }
}


@end
