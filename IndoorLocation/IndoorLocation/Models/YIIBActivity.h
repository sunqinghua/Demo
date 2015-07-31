//
//  YIIBActivity.h
//  YIVasMobile
//  室内导航活动信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIIBActivity : NSObject
@property (nonatomic, strong) NSString *activityid;     // 活动id
@property (nonatomic, strong) NSString *placeid;        // 商场id
@property (nonatomic, strong) NSString *icon;           // 活动海报图片
@property (nonatomic, assign) int type;                 // 优惠券or优惠活动
@property (nonatomic, assign) double begintime;         // 开始时间
@property (nonatomic, assign) double endtime;           // 结束时间
@property (nonatomic, strong) NSString *name;           // 名称
@property (nonatomic, strong) NSString *desc;           // 详细描述
@property (nonatomic, strong) NSString *hotpoint;       // 热度

@property (nonatomic, strong) NSString *shopid;         // 店铺id
@property (nonatomic, strong) NSString *shopname;       // 店铺名称
@property (nonatomic, assign) int floor;                // 店铺所在楼层
@property (nonatomic, assign) float coordinateX;        // 店铺X轴坐标
@property (nonatomic, assign) float coordinateY;        // 店铺Y轴坐标

- (id)initWithDic:(NSDictionary *)dic;
@end
