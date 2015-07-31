//
//  URLConfig.h
//  YIVasMobile
//
//  Created by song on 14/11/24.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#ifndef YIVasMobile_URLConfig_h
#define YIVasMobile_URLConfig_h



// 默认加载的列表数量  一页的数量
#define kListDataCount 20  


/**
 *
 *彩票代码**lodid
 *
 */


//双色球  //lodid
#define DOUBELBALL_ID @"001"
//福利彩票
#define WELFARE_ID @"002";
//大乐透
#define BIGLOTTO_ID @"113";
//003 004

/**
 *
 *网络请求常用返回参数定义
 *
 */
#define RESULT_OK   @"SUCCES"
#define RESULT_FAIL  @"FAIL"

#define RESULT @"result";

#define ERRORCODE @"errorCode"
#define ERRORMSG @"errorMsg"

#define RESPONSECODE @"responseCode"
#define RESPONSE_OK @"0000"


/********api地址***baseUrl*************/

#define api_baseurl @"http://220.168.94.226:9081/vas-openapi/api/"


/*
 **商户相关接口URl**
 *
 */

//查询商户首页信息
#define api_merchants_homepage   @"queryMerchantsHomepage"
//查询商户分类信息
#define api_merchants_category   @"queryCategory"
//查询商户轮播广告信息
#define api_merchants_adimage    @"queryMerchantsImage"
//详细页面
#define api_merchants_detail     @"queryMERCHANTDetail"




/*
 **彩票相关URl**
 *
 */

//我的彩票:参数未知未联通
#define api_mylottery_order   @"queryMyLotterOrder"

//查询当前彩票期号和截止日期
#define api_lottery_issueandtime    @"queryLotteryIssueAndTime"

//查询彩票近期中奖记录
#define api_lottery_winning   @"queryLotteryWinning"

//**近十期中奖情况</br>参数mylCode：彩种*/  //  0002
#define api_lottery_selectten     @"selectListByTen"




/**
 *
 **银行卡相关信息url**
 *
 */

#define api_card_my  @"queryMyCard"
#define api_card_add @"addMyCard"
//删除接口未知??此处需修改
#define api_card_del @"delMyCard"



/**
 *
 **城市相关信息url**
 *
 */


//所有省份
#define api_city_provinces  @"queryByParent"
//所有城市
#define api_city_query  @"queryCitys"
//可查子节点   参数pid＝要查询的节点id 例如北京1  查出北京的所有区
#define api_city_dic @"queryByChildren"


/**
 *
 *游戏虚拟充值卡相关url
 *
 **/

//所有支持的游戏
#define api_game_query  @"gamequery"
//所有虚拟游戏充卡产品  gameid=GAME0001
#define api_game_products  @"prodquery"
//某游戏区服信息       gameid=GAME36781
#define api_game_areaservers  @"areaservquery"


/**
 *
 *地铁公交信息公有url
 *
 **/

//查询某城市所有线路信息
#define api_line_all  @"queryAllBusLines"
//产寻某条线路所有站点
#define api_line_stations  @"queryStationsByLineCodeAndType"
//查询站点入口信息
#define api_line_station_exits  @"querySubwayStationExit"
//根据loc地点信息查询附近的出口
#define api_line_near_exits @"querySTATIONList1"

/**
 *
 *手机充值信息相关url
 *
 **/
//根据参数获取手机流量充值产品 参数string provinceName, String prodIsptype
#define api_recharge_flowpro  @"getDirectFlowProductBy"
//手机话费充值产品   string provincename, String prodIsptype
#define api_recharge_costpro  @"getDirectProductBy"

//检查该号码是否可以流量充值  返回号码信息  moblieNO
#define api_recharge_flow_checkPNumber @"checkFlowAccsegment"
//检查该号码是否可以话费充值  返回号码信息 moblieNO
#define api_recharge_cost_checkPNumber @"checkTelAccsegment"
//充值订单生成
#define api_recharge_order_create  @"createChargeOrder"


/**
 *
 *公交卡圈存网点
 **/
/**圈存网点，根据城市查询圈存网点</br>参数cityCode：城市id*/  // 南京 03
#define api_service_branches  @"queryServiceBranchesByCode"
/**圈存网点，根据经纬度查询圈存网点</br>参数latitude：经度  longitude：纬度*/  // 南京 03
#define api_service_around  @"queryServiceBranchesJwd"
/**圈存网点详情，查询圈存网点详情</br>参数id：网点id*/  //  0002
#define api_service_detail  @"queryListById"


#endif
//测试url

//服务器url
//HOST="http://192.168.1.127:8080/vas-openapi/api/";
//  HOST="http://admore.cn:10002/vas-openapi/api/";
/**
 *
 *商户门店信息
 **/
//#define api_merchants_homepage @"http://220.168.94.226:9081/vas-openapi/api/queryMerchantsHomepage"
//查询商户分类信息
//#define api_merchants_category @"http://220.168.94.226:9081/vas-openapi/api/queryCategory"
//查询商户轮播广告信息
//#define api_merchants_adimage @"http://220.168.94.226:9081/vas-openapi/api/queryMerchantsImage"

//查询商户详细信息  例子
//#define api_merchants_homepage @"http://220.168.94.226:9081/vas-openapi/api/queryMERCHANTDetail?branchesId=88114"