//
//  YIIBSTData.h
//  YIVasMobile
//  区域统计信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIIBSTData : NSObject
@property (nonatomic, assign) int placeid;
@property (nonatomic, assign) int sid;
@property (nonatomic, assign) int edgeid;
@property (nonatomic, assign) int gathertime;
@property (nonatomic, assign) int staytime;

@property (nonatomic, assign) int activityid;

- (NSDictionary *)makeDic;
@end
