//
//  YIIBMap.h
//  YIVasMobile
//  地图基础信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIIBMap : NSObject
@property (nonatomic, strong) NSString *image;         // 地图图片url
@property (nonatomic, assign) float scale;               // 比例尺
@property (nonatomic, assign) int width;               // 图片像素宽
@property (nonatomic, assign) int height;              // 图片像素高

@end
