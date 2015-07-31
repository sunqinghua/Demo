//
//  YIIBMapLineManager.h
//  YIVasMobile
//
//  Created by admin on 15/4/3.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YIIBRequestManager.h"

typedef void(^MapLineBlock)(NSArray *data,NSString *error);
typedef void(^MapMatchAddressBlock)(NSDictionary *data,NSString *error);

@interface YIIBMapLineManager : YIIBRequestManager


@property (nonatomic,copy) MapLineBlock mapLineBlock;
@property (nonatomic,copy) MapMatchAddressBlock mapMatchAddressBlock;

/*
 *1.获取最短路径
 */
- (void)queryMapLineWithPlaceid:(int)placeid floor:(int)floor startLocation:(NSString *)start endLocation:(NSString *)end;
/*
 *2.获取地址列表
 */
-(void)queryAddressMatchingWithStartName:(NSString *)start endName:(NSString *)end floor:(NSInteger )floor place:(NSInteger )place;

@end
