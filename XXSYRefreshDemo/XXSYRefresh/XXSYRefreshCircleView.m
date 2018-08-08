//
//  XXSYRefreshCircleView.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/24.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYRefreshCircleView.h"
#define CircleView_Radius 10.0f
#define CircleView_LineLength 70.0f
#define CircleView_LineLength 70.0f

@implementation XXSYRefreshCircleView
#pragma mark--life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _isAnimation = NO;
        _strokeColor = [UIColor colorWithRed:79.0f / 255.0f green:194.0f / 255.0f blue:241.0f / 255.0f alpha:1.0f];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.progress==0) {
        return;
    }
    CGPoint viewCenter = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldSubpixelQuantizeFonts(context,YES);
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context,self.strokeColor.CGColor);
    
    //画笔宽度
    CGContextSetLineWidth(context, 1.5);
    //绘线
    CGContextMoveToPoint(context, viewCenter.x, viewCenter.y- CircleView_Radius -CircleView_LineLength*(1-self.progress));
    CGContextAddLineToPoint(context, viewCenter.x, viewCenter.y-CircleView_Radius);
    //绘圆  (起始点-M_PI/2，终止点  M_PI/2 *3)
    CGContextAddArc(context, viewCenter.x, viewCenter.y, CircleView_Radius,  -M_PI/2 ,(_isAnimation?(15.0/8.0):2)*M_PI*self.progress- M_PI_2, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
}

#pragma mark--public methd
- (void)updateWithProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}
- (void)startRefreshAnimation
{
    if (self.progress==1 && self.isAnimation==NO) {
        [self startAnimation];
    }
}
- (void)resignNormal
{
    if (self.isAnimation==NO) return;
    [self.layer removeAnimationForKey:@"rotationAnimation"];
    self.isAnimation = NO;
    [self updateWithProgress:0];
}

#pragma mark--custom method
- (void)startAnimation
{
    self.isAnimation = YES;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.65;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark---get and set
- (UIColor *)strokeColor
{
    return _strokeColor?:[UIColor colorWithRed:79.0f / 255.0f green:194.0f / 255.0f blue:241.0f / 255.0f alpha:1.0f];
}

@end
