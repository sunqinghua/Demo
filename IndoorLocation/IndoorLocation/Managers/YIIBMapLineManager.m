//
//  YIIBMapLineManager.m
//  YIVasMobile
//
//  Created by admin on 15/4/3.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "YIIBMapLineManager.h"



@implementation YIIBMapLineManager

/*
 *1.获取最短路径
 */
-(void)queryMapLineWithPlaceid:(int)placeid floor:(int)floor startLocation:(NSString *)start endLocation:(NSString *)end{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:floor] forKey:@"floor"];
    [params setObject:[NSNumber numberWithInt:placeid] forKey:@"placeId"];
    [params setObject:start forKey:@"startPoint"];
    [params setObject:end forKey:@"endPoint"];
    [self postWithSerCode:API_CODE_MAPLINE params:params];
    
}
/*
 *2.获取地址列表
 */
-(void)queryAddressMatchingWithStartName:(NSString *)start endName:(NSString *)end floor:(NSInteger)floor place:(NSInteger)place{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithDouble:floor] forKey:@"floor"];
    [params setObject:[NSNumber numberWithDouble:place] forKey:@"placeId"];
    [params setObject:start forKey:@"startPointName"];
    [params setObject:end forKey:@"endPointName"];
    [self postWithSerCode:API_CODE_MATCHADDRESS params:params];
    
}

#pragma mark -成功回调
-(void)requestSuccessWithData:(NSDictionary *)data serCode:(int)serCode{
    NSString *responseCode = [data objectForKey:KEY_RESPONSE_CODE];
    NSString *responseDesc = [data objectForKey:KEY_RESPONSE_DESC];
    switch (serCode) {
        case API_CODE_MAPLINE:{
            if (self.mapLineBlock) {
                NSMutableArray *paths = [NSMutableArray array];
                if ([responseCode isEqualToString:RESPONSE_CODE_SUCCESS]) {
                    NSArray *temp=[data objectForKey:KEY_RESULT_LIST];
                    for (NSString *obj in temp) {
                        NSArray *info=[obj componentsSeparatedByString:@","];
                        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
                        [dic setValue:[info objectAtIndex:0] forKey:@"name"];
                        [dic setValue:[info objectAtIndex:1] forKey:@"x"];
                        [dic setValue:[info objectAtIndex:2] forKey:@"y"];
                        [paths addObject:dic];
                    }
                    self.mapLineBlock(paths,nil);
                }else{
                    self.mapLineBlock(nil,responseDesc);
                }
            }else{
                NSLog(@"self.mapLineBlock为空");
            }
        }break;
        case API_CODE_MATCHADDRESS:{
            if (self.mapMatchAddressBlock) {
                if ([responseCode isEqualToString:RESPONSE_CODE_SUCCESS]) {
                    NSDictionary *address=[data objectForKey:KEY_RESULT_LIST];
                    NSArray *start=[address objectForKey:@"0001"];
                    NSArray *end=[address objectForKey:@"0002"];
                    
                    if ([[start class]isSubclassOfClass:[NSNull class]]) {
                        start=nil;
                    }
                    if ([[end class]isSubclassOfClass:[NSNull class]]) {
                        end=nil;
                    }
                    
                    //数据封装
                    
                    NSArray *only=[address objectForKey:@"0003"];
                    
                    NSMutableArray *location=[NSMutableArray array];
                    if ([[only objectAtIndex:0]isEqualToString:@"1"]) {
                        if ((start&&start.count!=0)) {
                            NSMutableDictionary *startDic=[NSMutableDictionary dictionary];
                            [startDic setObject:start forKey:@"list"];
                            [startDic setObject:@"起始点选择" forKey:@"title"];
                            [startDic setObject:@"start" forKey:@"type"];
                            [startDic setValue:[NSNumber numberWithInteger:start.count] forKey:@"count"];
                            [location addObject:startDic];
                        }
                    }
                    
                    if ([[only objectAtIndex:1]isEqualToString:@"1"]) {
                        if ((end&&end.count!=0)) {
                            NSMutableDictionary *endDic=[NSMutableDictionary dictionary];
                            [endDic setObject:end forKey:@"list"];
                            [endDic setObject:@"终点选择" forKey:@"title"];
                            [endDic setObject:@"end" forKey:@"type"];
                            [endDic setValue:[NSNumber numberWithInteger:end.count] forKey:@"count"];
                            [location addObject:endDic];
                        }
                    }
                    
                    
                    
                    BOOL isOnly=[[only objectAtIndex:0]isEqualToString:@"0"]&&[[only objectAtIndex:1]isEqualToString:@"0"];
                    
                    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
                    [dic setValue:[NSNumber numberWithInteger:start.count] forKey:@"start"];
                    [dic setValue:[NSNumber numberWithInteger:end.count] forKey:@"end"];
                    [dic setValue:location forKey:@"data"];
                    [dic setValue:[NSNumber numberWithBool:isOnly] forKey:@"only"];
                    
                    
                    [dic setValue:[only objectAtIndex:0] forKey:@"startOnly"];
                    [dic setValue:[only objectAtIndex:1] forKey:@"endOnly"];
                    if ([[only objectAtIndex:0]isEqualToString:@"0"]) {
                        [dic setValue:start forKey:@"startValue"];
                    }
                    if ([[only objectAtIndex:1]isEqualToString:@"0"]) {
                        [dic setValue:end forKey:@"endValue"];
                    }
                    
                    
                    self.mapMatchAddressBlock(dic,nil);
                }else{
                    self.mapMatchAddressBlock(nil,responseDesc);
                }
            }else{
                NSLog(@"self.mapMatchAddressBlock为空");
            }
            
        }break;
    };
}

#pragma mark -失败回调
-(void)requestFailedWithError:(NSString *)error serCode:(int)serCode{
    switch (serCode) {
        case API_CODE_MAPLINE:{
            if (self.mapLineBlock) {
                self.mapLineBlock(nil,error);
            }
        }break;
        case API_CODE_MATCHADDRESS:{
            if (self.mapMatchAddressBlock) {
                self.mapMatchAddressBlock(nil,error);
            }
        }break;
        default:
            break;
    }
}

@end
