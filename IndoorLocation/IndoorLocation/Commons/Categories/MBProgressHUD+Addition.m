//
//  MBProgressHUD+Addition.m
//  weibo
//
//  Created by mj on 13-3-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#define kDuration 0.6

#import "MBProgressHUD+Addition.h"

@implementation MBProgressHUD (Addition)

static MBProgressHUD* shareHUD = nil;

+(MBProgressHUD*) shareMyHUDAt:(UIViewController*)vc{
    if(shareHUD == nil){
        shareHUD = [[MBProgressHUD alloc]initWithView:vc.view];
//        shareHUD.delegate=vc;
        shareHUD.opacity= 0.7f;
        [vc.view addSubview:shareHUD];
         shareHUD.labelText = @"加载中...";//IC上电中，请稍后...
        [shareHUD show:YES];
    }
    return shareHUD;
}

+(void) dismissMyHUD:(UIViewController*)vc{
    if (shareHUD) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [shareHUD hide:YES];
            [shareHUD removeFromSuperview];
             shareHUD = nil;
        });
        
    };
    
}

+ (void)string:(NSString *)string success:(BOOL)success to:(UIView *)to {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:to animated:YES];
    UIImage *image = [UIImage imageNamed:success?@"HUD.bundle/success.png":@"HUD.bundle/error.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    hud.customView = imageView;
    hud.labelText = string;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    [hud hide:YES afterDelay:kDuration];
}



+ (void)success:(NSString *)success to:(UIView *)to{
    [self string:success success:YES to:to];
}

+ (void)error:(NSString *)error to:(UIView *)to{
    [self string:error success:NO to:to];
}

+ (void)showOnlyText:(NSString*)string to:(UIView *)to {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:to animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
}
//+(void)success:(NSString *)success to:(UIView *)to time:(NSTimeInterval)duration{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:to animated:YES];
//    UIImage *image = [UIImage imageNamed:success?@"HUD.bundle/success.png":@"HUD.bundle/error.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    hud.customView = imageView;
//    hud.labelText = success;
//    hud.removeFromSuperViewOnHide = YES;
//    hud.mode = MBProgressHUDModeCustomView;
//    [hud hide:YES afterDelay:duration];
//    
//    
//}

@end
