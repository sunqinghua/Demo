//
//  YIIBUser.m
//  YIVasMobile
//  用户信息
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBUser.h"
#import "NSDictionary+YIIBParam.h"

@implementation YIIBUser
- (id)initWithPlaceFriendDic:(NSDictionary *)dic
{
    if (self = [super init]) {
//        _nickname = [dic safeObjectForKey:@"memberName"];
//        _userid = [[dic safeObjectForKey:@"friendid"] integerValue];
//        _memberCode = [dic safeObjectForKey:@"fMemberCode"];
//        _mobile = [dic safeObjectForKey:@"fPhoneNo"];
//        _avatar = [dic safeObjectForKey:@"photo"];
//        _sex = [[dic safeObjectForKey:@"fSex"] intValue];
        _nickname = [dic safeObjectForKey:@"nickName"];
        _memberName = [dic safeObjectForKey:@"memberName"];
        _userid = [[dic safeObjectForKey:@"friendid"] integerValue];
        _memberCode = [dic safeObjectForKey:@"memberCode"];
        _mobile = [dic safeObjectForKey:@"phoneNo"];
        _avatar = [dic safeObjectForKey:@"photo"];
        _sex = [[dic safeObjectForKey:@"sex"] intValue];
        
        _placeid=[[dic safeObjectForKey:@"placeid"] intValue];
        _floor=[[dic safeObjectForKey:@"floor"] intValue];
        _coordinateX=[[dic safeObjectForKey:@"coordinatex"] floatValue];
        _coordinateY=[[dic safeObjectForKey:@"coordinatey"] floatValue];
    }
    return self;
}

- (id)initWithFriendDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        _nickname = [dic safeObjectForKey:@"fNickName"];
        _userid = [[dic safeObjectForKey:@"friendid"] integerValue];
        _memberCode = [dic safeObjectForKey:@"fMemberCode"];
        _mobile = [dic safeObjectForKey:@"fPhoneNo"];
        _avatar = [dic safeObjectForKey:@"photo"];
        _fPhoto=[dic safeObjectForKey:@"fPhoto"];
        _sex = [[dic safeObjectForKey:@"fSex"] intValue];
    }
    return self;
}
@end
