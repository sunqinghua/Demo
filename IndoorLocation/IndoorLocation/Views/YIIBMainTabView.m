//
//  YIIBMainTabView.m
//  YIVasMobile
//
//  Created by darren on 14-12-18.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBMainTabView.h"

@implementation YIIBMainTabView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetRGBStrokeColor(context, 204/255.f, 204/255.f, 204/255.f, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width, 0);
    CGContextStrokePath(context);
    for (int i = 1; i < 4; i++) {
        CGFloat x = i * rect.size.width / 4;
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, x, 10);
        CGContextAddLineToPoint(context, x, rect.size.height - 10);
        CGContextStrokePath(context);
    }
}

@end
