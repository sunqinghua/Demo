//
//  YIIBRequestManager.m
//  YIVasMobile
//  带serCode参数的请求-网络请求Manager
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBRequestManager.h"
#import "NetworkUtil.h"
#import "NSObject+SBJson.h"
#import <CommonCrypto/CommonDigest.h>
#import "WeconexSDK.h"


#define kError    @"服务器忙，请稍后再试"
#define kNetError @"无法连接到网络，请稍后再试"

#define kTokenErrorCode1  @"403"
#define kTokenErrorCode2  @"9999"
//token 失效
#define kTokenErrorCode3  @"9998"

#define kTokenErrorMsg1  @"其他设备上登录该账号，请重新登录"
#define kTokenErrorMsg2  @"账号已冻结"
//token 失效
#define kTokenErrorMsg3  @"请登录账号"


@interface YIIBRequestManager ()
{
    ASIFormDataRequest *_request;
}
@end

@implementation YIIBRequestManager
static NSMutableArray *_queries;

#pragma mark - static method
+ (void)addQuery:(YIIBRequestManager *)query
{
    if (![_queries containsObject:query]) {
        [_queries addObject:query];
    }
}

+ (void)removeQuery:(YIIBRequestManager *)query
{
    [_queries removeObject:query];
}

+ (void)cancelAll
{
    if (_queries.count > 0) {
        [_queries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            YIIBRequestManager *query = obj;
            [query cancel];
        }];
    }
}

+ (id)manager
{
    if (!_queries) {
        _queries =[NSMutableArray array];
    }
    return [[[self class] alloc] init];
}

#pragma matk - public method
- (void)postWithSerCode:(int)code params:(NSMutableDictionary *)params
{
    NSDictionary *dic    =   [[NSBundle mainBundle] infoDictionary];//获取info－plist
    NSString *appName  =   [dic objectForKey:@"CFBundleIdentifier"];//获取Bundle identifier
    NSLog(@"appName==%@",appName);
    
    
    if (_request) return;
    if (!params) params = [NSMutableDictionary dictionary];
    
    // 发送请求API_URL
    _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:API_URL]];
    [_request setTimeOutSeconds:TimeOutSeconds];
    _request.delegate = self;
    // 参数拼接
    NSMutableDictionary *queryDic = [NSMutableDictionary dictionary];
    NSMutableArray *queryKeys = [NSMutableArray array];
    [queryDic setObject:[NSString stringWithFormat:@"%d", code] forKey:@"serCode"];
    // 上层参数
    [queryDic setObject:[params JSONRepresentation] forKey:@"dataMsg"];
    // token
//    [queryDic setObject:[YIIBUserManager sharedManager].token forKey:@"token"];
//    [queryDic setObject:[IDTools devId] forKey:@"terminalCode"];
//    [queryDic setObject:[YIIBUserManager sharedManager].memberCode forKey:@"memberCode"];

    [queryDic setObject:[WeconexSDK getApiKey] forKey:@"ak"];
    // 需要签名的参数key
    [queryKeys addObject:@"serCode"];
    [queryKeys addObject:@"dataMsg"];
    //[queryKeys addObject:@"token"];
    [queryKeys addObject:@"ak"];
    
    NSString *paramStr = [YIIBRequestManager queryStringWithParams:queryDic keys:queryKeys];
//    NSLog(@"url=%@",_request.url);
//    NSLog(@"paramStr : %@", paramStr);
    NSString *sign = [YIIBRequestManager md5Encrypt:paramStr];
//    NSLog(@"sign : %@", sign);
    [queryDic setObject:sign forKey:@"sign"];
    
    // 设置http post参数
    for (NSString *key in queryDic.allKeys) {
        [_request addPostValue:[queryDic objectForKey:key] forKey:key];
    }
    _request.tag = code;
    [[self class] addQuery:self];
    [_request setTimeOutSeconds:TimeOutSeconds];
    if (![NetworkUtil isConnectNetWork])
    {
        if ([self respondsToSelector:@selector(requestFailedWithError:serCode:)]) {
            [self requestFailedWithError:kError serCode:(int)_request.tag];
        }
        return;
    }
    [_request startAsynchronous];
}

- (void)cancel
{
    [_request clearDelegatesAndCancel];
    _request = nil;
    
    // 移除自己
    [[self class] removeQuery:self];
}

#pragma mark - asihttprequest delegate
- (void)requestFailed:(ASIHTTPRequest *)request
{
    if ([self respondsToSelector:@selector(requestFailedWithError:serCode:)]) {
        [self requestFailedWithError:kError serCode:(int)request.tag];
    }
    // 移除自己
    [[self class] removeQuery:self];
//    _request = nil;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
   // NSLog(@"responseString : %@", [request responseString]);
    NSString *jsonStr = nil;
    NSError *error;
    NSString *responseString = [request responseString];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\{.+\\}" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:responseString
                                                             options:0
                                                               range:NSMakeRange(0, [responseString length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            jsonStr = [responseString substringWithRange:resultRange];
        }
    }
    
    NSDictionary *result = [jsonStr JSONValue];
    if (result) {
        NSString *code=[result objectForKey:@"code"];
        if ([code isEqualToString:kTokenErrorCode1]||[code isEqualToString:kTokenErrorCode2]||[code isEqualToString:kTokenErrorCode3]) {
            if ([code isEqualToString:kTokenErrorCode1]) {
                [YIToast showText:[NSString stringWithFormat:@"%@",kTokenErrorMsg1]];
            };
            if ([code isEqualToString:kTokenErrorCode2]) {
                [YIToast showText:[NSString stringWithFormat:@"%@",kTokenErrorMsg2]];
            };
            if([code isEqualToString:kTokenErrorCode3]) {
                [YIToast showText:[NSString stringWithFormat:@"%@",kTokenErrorMsg3]];
            };
           // [[YIPersonalConfig sharedInstance] clear];
           // [[NSNotificationCenter defaultCenter] postNotificationName:kNeedAlertLoginView object:nil userInfo:nil];
            return;
        }else{
            if ([self respondsToSelector:@selector(requestSuccessWithData:serCode:)]) {
                [self requestSuccessWithData:result serCode:(int)request.tag];
            }
        }
    }
    else {
        if ([self respondsToSelector:@selector(requestFailedWithError:serCode:)]) {
            [self requestFailedWithError:kError serCode:(int)request.tag];
        }
    }
    // 移除自己
    [[self class] removeQuery:self];
//    _request = nil;
}

#pragma mark - tools
+ (NSString *)md5Encrypt:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02x", result[i]];
    return hash;
}

+ (NSString *)queryStringWithParams:(NSDictionary *)params keys:(NSArray *)keys
{
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = [keys objectAtIndex:i];
        if (str.length > 0) {
            [str appendFormat:@"&%@=%@",key,[params objectForKey:key]];
        }
        else {
            [str appendFormat:@"%@=%@",key,[params objectForKey:key]];
        }
    }
    return str;
}


@end
