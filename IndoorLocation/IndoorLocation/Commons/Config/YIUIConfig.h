//
//  YIUIConfig.h
//  YIVasMobile
//
//  Created by apple on 15/4/9.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#ifndef YIVasMobile_YIUIConfig_h
#define YIVasMobile_YIUIConfig_h

/**
 *  当前系统版本
 */
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]


#pragma mark -颜色相关定义

/**
 *  十六进制数值转颜色值
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 * 主题青蓝色
 */
#define kGlobalThemeColor [UIColor colorWithRed:(float)(41)/255.0 green:(float)(181)/255.0 blue:(float)(234)/255.0 alpha:1.0]

/**
 * 主题背景 UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1.0]
 */
#define kGlobalBg [UIColor colorWithRed:0.955 green:0.955 blue:0.955 alpha:1]
#define kGlobalBackgroundColor [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]

/**
 *  全局黑色文字颜色
 */
#define kGlobalBlackColor [UIColor colorWithRed:17/255 green:17/255 blue:17/255 alpha:1.0]

/**
 *  表格左侧黑色文字 大小 颜色
 */

#define kTableLeftTitleFont  [UIFont systemFontSize: 14.0]
//17
#define kTableLeftTitleColor [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0]
/**
 *  表格右侧灰色文字 大小 颜色
 */
#define kTableRightTitleFont  [UIFont systemFontSize: 13.0]
#define kTableRightTitleColor [UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:1.0]

/**
 *  表格橙色文字  大小  颜色
 */

#define kTableOrangeTitleFont  [UIFont systemFontSize: 13.0]
#define kTableOrangeTitleColor [UIColor colorWithRed:255/255 green:119/255 blue:0/255 alpha:1.0]


/**
 *  灰色 文字颜色
 */
#define kgrayTitleColor [UIColor grayColor]

/**
 *  我的页面 cell
 */
#define cellSpeartorColor [UIColor colorWithRed:203./255 green:203./255 blue:203./255 alpha:1.0]
#define cellOtherTextColor [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0]


/**
 *  判断是否是iphone5
 */
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

/**
 *  是真机否
 */
#define IS_dev YES

/**
 *  字体大小转为文字高度
 */
#define size2height(_size_) [UIFont systemFontOfSize:_size_].lineHeight


/**
 *  导航栏的高度
 */
#define kNavigationBarHeight 44


/**
 *  状态栏的高度
 */
#define kStatusBarHeight 20

#define kTabbarHeight  49


// 默认加载的列表数量  一页的数量
#define kListDataCount 20

#define kTextFieldBaseTag 10
/**
 *  导航栏的高度
 */
#define kNavigationBarHeight 44


/**
 *  状态栏的高度
 */
#define kStatusBarHeight 20

#define kTabbarHeight 49

/**
 *  tableView的头部高度
 */
#define kTableViewHeaderHeight 16

/**
 *  主题按钮的高度（注册，登录，下一步，确认等等）
 */
#define kGlobalThemeBtnHeight 36
/**
 *  圆角半径
 */
#define kGlobalCornerRadiu 5


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
 *  系统屏幕宽度
 */
#define KMainScreenSize [UIScreen mainScreen].bounds.size
    

//自定义添加字符类型库
#define YIFont @"FZZZHJT_0.TTF"



/**
 *  判断是否为iOS7
 */
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

/**
 *  比较系统版本大小
 */
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define spstring @" ▼ "
#define changeTitleName(v, s) (self.navigationItem.title = [NSString stringWithFormat:@"%@%@", s, spstring])

/**
 *  设置title
 */
#define changeTitleName2(v, s) ([v setTitle:[NSString stringWithFormat:@"%@%@", s, spstring] forState:UIControlStateNormal])

/**
 *  彩球颜色
 */
#define RED_BALL_COLOR [UIColor colorWithRed:160.0/255.0 green:14.0/255.0 blue:54.0/255.0 alpha:1]
#define RAD_BALL_COLOR [UIColor colorWithRed:255.0/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define BLUE_BALL_COLOR [UIColor colorWithRed:9/255.0 green:110/255.0 blue:213/255.0 alpha:1]
#define NONE_BALL_COLOR [UIColor whiteColor]




#endif
