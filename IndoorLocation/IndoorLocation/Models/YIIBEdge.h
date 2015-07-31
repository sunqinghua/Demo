//
//  YIIBEdge.h
//  YIVasMobile
//  区域信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>



@class YIIBEdge;
@protocol YIIBEdgeDelegate <NSObject>
- (void)edgeDidEnter:(YIIBEdge *)edge;
- (void)edgeDidExit:(YIIBEdge *)edge;
@end


@interface YIIBEdge : NSObject
{
    int _inRangeTime;
    int _outRangeTime;
}


@property (nonatomic, assign) int edgeid;           // 区域id
@property (nonatomic, strong) NSString *name;       // 区域名称
@property (nonatomic, strong) NSString *desc;       // 区域描述
@property (nonatomic, assign) int placeid;          // 所在商场id
@property (nonatomic, assign) int floor;            // 所在楼层
@property (nonatomic, assign) int type;             // 区域类型 1.圆形

@property (nonatomic, assign) float centerX;        // 圆心x轴坐标
@property (nonatomic, assign) float centerY;        // 圆心y轴坐标
@property (nonatomic, assign) float radius;         // 圆形区域半径
@property (nonatomic, assign)  int locationType;

@property (nonatomic, weak) id<YIIBEdgeDelegate> delegate;
@property (nonatomic, assign) BOOL inRange;
@property (nonatomic, assign) NSTimeInterval lastInTime;
- (void)processX:(float)x y:(float)y floor:(int)floor;

- (id)initWithDic:(NSDictionary *)dic;
@end
