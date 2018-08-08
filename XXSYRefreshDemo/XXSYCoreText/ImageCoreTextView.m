//
//  ImageCoreTextView.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/7.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "ImageCoreTextView.h"
#import <CoreText/CoreText.h>
@interface ImageCoreTextView ()
@property (nonatomic, assign) CGRect imageRect;
@property (nonatomic, assign) CTFrameRef ctFrame;
@property (nonatomic, assign) NSInteger length;
@end

@implementation ImageCoreTextView

static CGFloat ascentCallBacks(void *ref)
{
    return [(NSNumber *)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallBacks(void *ref)
{
    return 0;
}
static CGFloat widthCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"width"] floatValue];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1);
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"这是一个富文本，带图片那种，我测试一下看看"];
    CTRunDelegateCallbacks callBacks;
    memset(&callBacks, 0, sizeof(CTRunDelegateCallbacks));
    callBacks.version  = kCTRunDelegateVersion1;
    callBacks.getAscent = ascentCallBacks;
    callBacks.getDescent = descentCallBacks;
    callBacks.getWidth = widthCallBacks;
    NSDictionary *picDic = @{@"height":@80,@"width":@150};
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge void *)picDic);
    unichar placeHolder = 0xFFC;
    NSString *placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1];
    NSMutableAttributedString *placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    [attributeStr insertAttributedString:placeHolderAttrStr atIndex:12];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);
    NSInteger length = attributeStr.length;
    self.length = length;
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, length), path, NULL);
    self.ctFrame = frame;
    CTFrameDraw(frame, context);
    
    
    //这里绘制图片
    UIImage *image = [UIImage imageNamed:@"coretext-image-1.jpg"];
    CGRect imageRect  = [self calculateImageRectWithFrame:frame];
    self.imageRect = imageRect;
    CGContextDrawImage(context, imageRect, image.CGImage);
    CFRelease(framesetter);
    CFRelease(path);
    CFRelease(frame);
}


- (CGRect)calculateImageRectWithFrame:(CTFrameRef)frame
{
    NSArray *arrLines = (NSArray *)CTFrameGetLines(frame);
    NSInteger count = arrLines.count;
    CGPoint lineOrigins[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOrigins);
    for (int i =0;i<count;i++)
    {
        CTLineRef line = (__bridge CTLineRef)arrLines[i];
        NSArray *glyphRunsArr = (NSArray *)CTLineGetGlyphRuns(line);
        for(int j = 0; j<glyphRunsArr.count; j++)
        {
            CTRunRef run = (__bridge CTRunRef)glyphRunsArr[j];
            NSDictionary *attributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) {
                continue;
            }
            NSDictionary *dic = CTRunDelegateGetRefCon(delegate);
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CGPoint originPoint = lineOrigins[i];
            CGFloat ascent;
            CGFloat descent;
            CGRect runBounds;
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            CGFloat XOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = originPoint.x + XOffset;
            runBounds.origin.y = originPoint.y - descent;
            
            CGPathRef path = CTFrameGetPath(frame);
            CGRect colRect = CGPathGetBoundingBox(path);
            CGRect imageBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            return imageBounds;
        }
    }
    return CGRectZero;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [self systemPointFromScreenPoint:[touch locationInView:self]];
    if ([self checkIsClickOnImageWithPoint:location]) {
        return;
    }
    
}

- (void)clickOnStringWithLocationPoint:(CGPoint)location
{
    NSArray *lines = (NSArray *)CTFrameGetLines(self.ctFrame);
    CFRange ranges[lines.count];
    CGPoint origins[lines.count];
    CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0, 0), origins);
    for (int i = 0; i<lines.count; i++)
    {
        CTLineRef line = (__bridge CTLineRef)lines[i];
        CFRange range = CTLineGetStringRange(line);
        ranges[i] = range;
    }
    for (int i =0; i<self.length; i++)
    {
        long maxLoc=0;
        int lineNum=0;
        for (int j = 0 ; j< lines.count; j++) {
            CFRange range = ranges[j];
            maxLoc = range.location + range.length -1;
            if (i <= maxLoc) {
                lineNum = j;
                break;
            }
        }
        CTLineRef line = (__bridge CTLineRef)lines[lineNum];
        CGPoint origin = origins[lineNum];
        CGRect CTRunFrame = [self frameForCTRunWithIndex:i CTLine:line origin:origin];
        if ([self isFrame:CTRunFrame containsPoint:location]) {
            NSLog(@"您点击到了第 %d 个字符，位于第 %d 行，然而他没有响应事件。",i,lineNum + 1);//点击到文字，然而没有响应的处理。可以做其他处理
            return;
        }
    }
    NSLog(@"没有点击到文字");
}



- (CGRect)frameForCTRunWithIndex:(NSInteger)index
                          CTLine:(CTLineRef)line
                          origin:(CGPoint)origin
{
    CGFloat offsetX = CTLineGetOffsetForStringIndex(line, index, NULL);
    CGFloat offsetX2 = CTLineGetOffsetForStringIndex(line, index+1, NULL);
    offsetX = origin.x + offsetX;
    offsetX2 = origin.x + offsetX2;
    CGFloat offsetY = origin.y;
    CGFloat lineAscent;
    CGFloat lineDescent;
    NSArray *runs = (__bridge NSArray *)CTLineGetGlyphRuns(line);
    CTRunRef currentRun;
    for (int k = 0 ; k<runs.count; k++) {
        CTRunRef run = (__bridge CTRunRef)runs[k];
        CFRange range = CTRunGetStringRange(run);
        NSRange range_OC = NSMakeRange(range.location, range.length);
        if ([self isIndex:index inRange:range_OC]) {
            currentRun = run;
            break;
        }
    }
    CTRunGetTypographicBounds(currentRun, CFRangeMake(0, 0), &lineAscent, &lineDescent, NULL);
    offsetY = offsetY -lineDescent;
    CGFloat height = lineDescent +lineAscent;
    return CGRectMake(offsetX, offsetY, offsetX2-offsetX, height);
}

-(BOOL)isIndex:(NSInteger)index inRange:(NSRange)range
{
    if ((index <= range.location + range.length - 1) && (index >= range.location)) {
        return YES;
    }
    return NO;
}


- (BOOL)checkIsClickOnImageWithPoint:(CGPoint)location
{
    if ([self isFrame:self.imageRect containsPoint:location]) {
        return YES;
    }else{
        return NO;
    }
}

///坐标转换将屏幕坐标转换为系统坐标
-(CGPoint)systemPointFromScreenPoint:(CGPoint)origin
{
    return CGPointMake(origin.x, self.bounds.size.height - origin.y);
}

-(BOOL)isFrame:(CGRect)frame containsPoint:(CGPoint)point
{
    return CGRectContainsPoint(frame, point);
}


- (void)setCtFrame:(CTFrameRef)ctFrame
{
    if (_ctFrame != ctFrame) {
        if (_ctFrame != nil) {
            CFRelease(_ctFrame);
        }
        CFRetain(ctFrame);
        _ctFrame = ctFrame;
    }
}

- (void)dealloc
{
    if (_ctFrame != nil) {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}
@end
