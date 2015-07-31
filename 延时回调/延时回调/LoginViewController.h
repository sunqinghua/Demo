//
//  LoginViewController.h
//  延时回调
//
//  Created by admin on 15/7/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginViewBlock)(NSString *error,UIViewController *nextVC);

@interface LoginViewController : UIViewController

-(id)initWithNextViewController:(UIViewController *)nextVC;

@property (nonatomic,copy) LoginViewBlock loginBlock;


@end
