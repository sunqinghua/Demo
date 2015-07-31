//
//  YIIBUser.h
//  YIVasMobile
//  用户信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIIBUser : NSObject
@property (nonatomic, assign) NSInteger userid;               // 用户id
@property (nonatomic, strong) NSString *nickname;       // 用户昵称
@property (nonatomic, strong) NSString *memberName;       // 用户名称
@property (nonatomic, assign) int sex;                  // 用户性别
@property (nonatomic, strong) NSString *avatar;         // 头像url
@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, assign) int placeid;              // 所在商场id
@property (nonatomic, assign) int floor;                // 所在楼层
@property (nonatomic, assign) float coordinateX;        // X轴坐标
@property (nonatomic, assign) float coordinateY;        // Y轴坐标
@property (nonatomic, assign) NSTimeInterval modifyTime;

@property (nonatomic,copy) NSString *fPhoto;//朋友图片

@property (nonatomic, strong) NSString *memberCode;



- (id)initWithPlaceFriendDic:(NSDictionary *)dic;
- (id)initWithFriendDic:(NSDictionary *)dic;
@end
