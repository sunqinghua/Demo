//
//  ViewController.m
//  延时回调
//
//  Created by admin on 15/7/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "UserViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)initSelfView{
    self.title=@"RootView";
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initViews{
    
    [self initSelfView];
    [self initBtnView];
    
    
}

-(void)initBtnView{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)*.5, (self.view.frame.size.height-40)*.5, 100, 40)];
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:@"延时回调1" forState:UIControlStateNormal];
    btn.tag=100;
    [btn addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)*.5, (self.view.frame.size.height-40)*.5+60, 100, 40)];
    btn1.backgroundColor=[UIColor redColor];
    btn1.tag=200;
    [btn1 setTitle:@"延时回调2" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

-(void)gotoOther:(UIButton *)aBtn{
    
    UIViewController *next=[[UIViewController alloc]init];
    
    
    switch (aBtn.tag) {
        case 100:
        {
            next=[[UserViewController alloc]init];
            next.view.backgroundColor=[UIColor yellowColor];
        }break;
        case 200:{
        
            next=[[UIViewController alloc]init];
            next.view.backgroundColor=[UIColor blueColor];
        }break;
            
        default:
            break;
    }
    
    LoginViewController *login=[[LoginViewController alloc]initWithNextViewController:next];
    
    login.loginBlock=^(NSString *error,UIViewController *nextVC){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:nextVC animated:YES];
        });
        
    };
    [self presentViewController:login animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
