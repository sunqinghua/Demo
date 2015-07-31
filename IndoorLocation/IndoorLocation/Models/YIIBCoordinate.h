//
//  YIIBCoordinate.h
//  YIVasMobile
//  坐标信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIIBCoordinate : NSObject
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) int floor;
@property (nonatomic,assign) int placeId;

- (id)initWithX:(float)x y:(float)y floor:(int)floor;
- (BOOL)isEqual:(YIIBCoordinate*)c;
@end
