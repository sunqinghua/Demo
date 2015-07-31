//
//  YIIBCarPosition.h
//  YIVasMobile
//  车位信息
//  Created by darren on 14-12-25.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YIIBCoordinate.h"

@interface YIIBCarPosition : NSObject
@property (nonatomic, assign) int placeid;
@property (nonatomic, strong) YIIBCoordinate *coordinate;
@end
