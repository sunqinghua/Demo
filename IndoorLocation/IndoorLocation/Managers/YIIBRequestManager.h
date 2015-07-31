//
//  YIIBRequestManager.h
//  YIVasMobile
//  带serCode参数的请求-网络请求Manager
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


//#define API_URL  [api_baseurl stringByAppendingPathComponent:@"/v2/vas"]
//#define API_URL     @"http://220.168.94.226:9081/vas-openapi/api/v2/vas"
//#define API_URL     @"http://172.16.0.25:8080/vas-openapi/api/v2/vas"
//#define API_URL     @"http://172.16.0.167:8080/vas-openapi/api/v2/vas"
#define API_KEY     @"af8eee6c39204eb8bcd9f31cf158c9e5"

#define API_CODE_FRINED_LIST            106041
#define API_CODE_ADD_FRIEND             106042
#define API_CODE_DEL_FRIEND             106043

#define API_CODE_PLACE_INFO             106051
#define API_CODE_PLACE_LIST             106052

#define API_CODE_UPLOAD_LOCATION        106061
#define API_CODE_GET_USER_LOCATION      106062
#define API_CODE_PLACE_FRIENDS          106063

#define API_CODE_ADD_RECORD             106071
#define API_CODE_MODIFY_RECORD          106072
#define API_CODE_DEL_RECORD             106073
#define API_CODE_RECORD_LIST            106074

#define API_CODE_PLACE_SHOPS            106081
#define API_CODE_SHOP_INFO              106082

#define API_CODE_PLACE_ACTIVITIES       106091
//#define API_CODE_ADD_MY_ACTIVITY        106092
//#define API_CODE_DEL_MY_ACTIVITY        106093
//#define API_CODE_MY_ACTIVITIES          106094
#define API_CODE_ACTIVITY_INFO          106095
#define API_CODE_EDGE_ACTIVITIES        106096
#define API_CODE_PUSH_ACTIVITIES     200010

#define API_CODE_FLOOR_MAP              106101
#define API_CODE_PLACE_MAP              106102

#define API_CODE_CARD_LIST              106113

#define API_CODE_EDGE_INFO              106121
#define API_CODE_PLACE_EDGES            106122

#define API_CODE_UPLOAD_STDATA          106131
#define API_CODE_UPLOAD_VISIT          200008


#define API_CODE_Logout 106021
#define API_CODE_Login  106022
#define API_CODE_Modify_passwd  106023
#define API_CODE_Mdify_Member_Info 106024
#define API_CODE_Query_Member_Info 106025
#define API_CODE_Register 106026
#define API_CODE_Register_Checkcode 10614

#define API_CODE_Query_version 106031
#define API_CODE_Feedback 106032
#define  API_CODE_MAPLINE 106133
#define  API_CODE_MATCHADDRESS 200013

#define RESPONSE_CODE_SUCCESS           @"0000"
#define KEY_RESPONSE_CODE               @"responseCode"
#define KEY_RESULT                      @"result"
#define KEY_RESULT_LIST                 @"resultList"
#define KEY_RESPONSE_DESC               @"responseDesc"



@interface YIIBRequestManager : NSObject<ASIHTTPRequestDelegate>
+ (id)manager;
// 取消所有的请求
+ (void)cancelAll;

// 取消请求
- (void)cancel;
// 在baseAPI路径的基础上发送一个POST请求
- (void)postWithSerCode:(int)code params:(NSMutableDictionary *)params;

// 请求完成后
- (void)requestSuccessWithData:(NSDictionary *)data serCode:(int)serCode;
- (void)requestFailedWithError:(NSString *)error serCode:(int)serCode;
@end
