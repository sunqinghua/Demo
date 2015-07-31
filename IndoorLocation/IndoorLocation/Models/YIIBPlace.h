//
//  YIIBPlace.h
//  YIVasMobile
//  商场（地点）信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIIBPlace : NSObject
@property (nonatomic, assign) int placeid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, assign) float longitude;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) int topfloor;
@property (nonatomic, assign) int lowfloor;

@property (nonatomic, strong) NSString *welcome;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *brief;
@property (nonatomic, strong) NSString *url;

- (id)initWithDic:(NSDictionary *)dic;
@end
