//
//  MBProgressHUD+Addition.h
//  weibo
//
//  Created by mj on 13-3-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Addition)
+ (void)success:(NSString *)success to:(UIView *)to;
+ (void)error:(NSString *)error to:(UIView *)to;
+ (void)string:(NSString *)string success:(BOOL)success to:(UIView *)to;
+ (void)success:(NSString *)success to:(UIView *)to  time:(NSTimeInterval)duration;
+(MBProgressHUD*) shareMyHUDAt:(UIViewController*)vc;
+(void) dismissMyHUD:(UIViewController*)vc;

+ (void)showOnlyText:(NSString*)string to:(UIView *)to;
@end
