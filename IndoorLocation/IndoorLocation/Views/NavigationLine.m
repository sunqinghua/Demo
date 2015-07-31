//
//  NavigationLine.m
//  YIVasMobile
//
//  Created by admin on 15/4/3.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "NavigationLine.h"

#define KIconWidth 24
#define KIconHieght 24

@interface NavigationLine (){

    NSArray *_pathList;
    CGFloat _scale;
    CGRect _startImgRect;
    CGRect _endImgRect;
}

@end

@implementation NavigationLine

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(id)initWithFrame:(CGRect)frame pathList:(NSArray *)list scale:(CGFloat)scale{
    if (self=[super initWithFrame:frame]) {
        _pathList=list;
        _scale=scale;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //线条颜色
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    //CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.5);
    //线条宽度
    CGContextSetLineWidth(context, self.lineWidth);
    //位置
    
    if (_pathList&&_pathList.count>=2) {
        //第一条
        if ([_pathList objectAtIndex:0]) {
            //        NSValue *val=[_pathList objectAtIndex:0];
            //        CGPoint startPoint=[val CGPointValue];
            
            NSDictionary *dic=[_pathList objectAtIndex:0];
            CGPoint startPoint=CGPointMake([[dic objectForKey:@"x"]floatValue], [[dic objectForKey:@"y"]floatValue]);
            CGContextMoveToPoint(context, startPoint.x*_scale, startPoint.y*_scale);
            NSLog(@"startPoint=%@",NSStringFromCGPoint(CGPointMake(startPoint.x*_scale, startPoint.y*_scale)));
            
            _startImgRect=CGRectMake(startPoint.x*_scale-KIconWidth*.5, startPoint.y*_scale-KIconHieght, KIconWidth, KIconHieght);
        } 
        //其他
        for (int i=1; i<_pathList.count; i++) {
            NSDictionary *dic=[_pathList objectAtIndex:i];
            CGPoint point=CGPointMake([[dic objectForKey:@"x"]floatValue], [[dic objectForKey:@"y"]floatValue]);
            //        NSValue *val=[_pathList objectAtIndex:i];
            //        CGPoint point=[val CGPointValue];
            
            CGFloat dashArray[] = {5,5};
            
            CGContextSetLineDash(context, 0, dashArray, 2);//跳过3个再画虚线，所以刚开始有6-（3-2）=5个虚点
            
            CGContextAddLineToPoint(context, point.x*_scale,point.y*_scale);
            NSLog(@"Point=%@",NSStringFromCGPoint(CGPointMake(point.x*_scale, point.y*_scale)));
            if (i==_pathList.count-1) {
                // 1.取得图片
               // UIImage *end=[UIImage imageNamed:@"map_navigation_start"];
//                [end drawInRect:CGRectMake((point.x-(KIconWidth*0.5))*_scale, (point.y-(KIconHieght*.5))*_scale, KIconWidth, KIconHieght)];
                //[end drawInRect:CGRectMake(point.x*_scale-KIconWidth*.5, point.y*_scale-KIconHieght, KIconWidth, KIconHieght)];
                
                _endImgRect=CGRectMake(point.x*_scale-KIconWidth*.5, point.y*_scale-KIconHieght, KIconWidth, KIconHieght);
            }
        }
        
        //开始绘制
        CGContextStrokePath(context);
        UIImage *start = [UIImage imageNamed:@"map_naviagtion_end"];
        //[start drawInRect:CGRectMake((startPoint.x-(KIconWidth*.5))*_scale, (startPoint.y-(KIconHieght*.5))*_scale, KIconWidth, KIconHieght)];
        [start drawInRect:_startImgRect];
        
        UIImage *end=[UIImage imageNamed:@"map_navigation_start"];
        [end drawInRect:_endImgRect];
    }
    
    // 2.画
    //    [image drawAtPoint:CGPointMake(50, 50)];
    //    [image drawInRect:CGRectMake(0, 0, 150, 150)];
    //    [end drawAsPatternInRect:CGRectMake()];
}


@end
