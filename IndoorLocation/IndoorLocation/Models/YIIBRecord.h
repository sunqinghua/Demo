//
//  YIIBRecord.h
//  YIVasMobile
//  位置记录信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIIBRecord : NSObject
@property (nonatomic, assign) int recordid;             // 记录id
@property (nonatomic, strong) NSString *name;           // 记录名称
@property (nonatomic, assign) int placeid;              // 所在商场id
@property (nonatomic, assign) int floor;                // 所在楼层
@property (nonatomic, assign) float coordinateX;        // X轴坐标
@property (nonatomic, assign) float coordinateY;        // Y轴坐标
@property (nonatomic, assign) double modifytime;        // 最后修改时间戳

- (id)initWithDic:(NSDictionary *)dic;
@end
