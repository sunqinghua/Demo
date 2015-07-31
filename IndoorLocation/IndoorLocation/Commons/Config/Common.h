//
//  Common.h
//  YIVasMobile
//
//  Created by SUNX on 15/3/24.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "YIURLConfig.h"

#ifndef YIVasMobile_Common_h
#define YIVasMobile_Common_h
#define KPlist @"plist"
#define KPlistMainHomeItem @"MainHomeItem.plist"
#define KMainHomeItemKey_Title @"title"
#define KMainHomeItemKey_Tag    @"tag"
#define KMainHomeItemKey_Img    @"img"
#define KMainHomeItemKey_IsSelect @"isSelect"

#define kdbName @"weconexDB.db"//总数据库名字
//#define KLocalNotificationInterval 60*60*24
#define KLocalNotificationInterval 60*10

#define KDevice_System_IOS @"1"



/***************************支付平台**********************/
//1. 充值
#define BUSINESS_NUMBER_PERSONAL_RECHARGE 106148
//2. 手机验证
#define BUSINESS_NUMBER_PERSONAL_PHONEAUTH 106147
//3. 银行卡添加
#define BUSINESS_NUMBER_PERSONAL_BANKADD 106145
//4. 已绑定银行卡支付
#define BUSINESS_NUMBER_PERSONAL_BANKPAY 106142
//5. 银行卡信息查询
#define BUSINESS_NUMBER_PERSONAL_BANKINFOQUERY 106143
//6. 银行卡信息查询
#define BUSINESS_NUMBER_PERSONAL_ACCONTPAY 106149
//7. 设置支付密码
#define BUSINESS_NUMBER_PERSONAL_SETPAYPASSWORD 106151
//8. 设置支付密码
#define BUSINESS_NUMBER_PERSONAL_QUERYPAYPASSWORD 106150
//9. 银行卡解绑
#define BUSINESS_NUMBER_PERSONAL_BANKUNBINDING 106146
//10.查询已绑定的银行卡
#define BUSINESS_NUMBER_PERSONAL_BINDINGBANKLIST 106144
//11. 未绑定银行卡支付
#define BUSINESS_NUMBER_PERSONAL_UNBINDINGBANKPAY 888888

/***************************POS平台**********************/

#define BUSINESS_NUMBER_POS_UPDATALOCATION 200009
#define BUSINESS_NUMBER_POS_VISIT 10003

#define CITY_ADDRESS_PERSONAL_PROVINCELIST_TAG 200001
#define CITY_ADDRESS_PERSONAL_CITYLIST_TAG 200002
#define CITY_ADDRESS_PERSONAL_DISTRICTLIST_TAG 200003

#define CITY_ADDRESS_PERSONAL_PROVINCELIST_API_PATH @"provinceList"
#define CITY_ADDRESS_PERSONAL_CITYLIST_API_PATH @"cityList"
#define CITY_ADDRESS_PERSONAL_DISTRICTLIST_API_PATH @"areaList"


#define KNOTIFICATION_POS_ACTIVITY_PUSH @"KNOTIFICATION_POS_ACTIVITY_PUSH"


#endif
