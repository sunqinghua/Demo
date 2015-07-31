//
//  LoginViewController.m
//  延时回调
//
//  Created by admin on 15/7/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (){
    UIViewController *_nextViewController;
}

@end

@implementation LoginViewController


-(id)initWithNextViewController:(UIViewController *)nextVC{
    if (self=[super init]) {
        _nextViewController=nextVC;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    
    // Do any additional setup after loading the view.
}

-(void)initViews{
    [self initSelfView];
    [self initBtn];
}

-(void)initBtn{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)*.5, (self.view.frame.size.height-40)*.5, 100, 40)];
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:@"登陆成功" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoSucess) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)initSelfView{
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)gotoSucess{
    self.loginBlock(nil,_nextViewController);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
