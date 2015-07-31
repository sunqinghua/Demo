//
//  YIIBIndictionView.m
//  YIVasMobile
//
//  Created by admin on 15/4/8.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "YIIBIndictionView.h"

@interface YIIBIndictionView (){
    UIActivityIndicatorView *_activity;
    UILabel *_alertText;
}

@end

@implementation YIIBIndictionView

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor grayColor];
        self.layer.cornerRadius=5.f;
        [self initViews];
    }
    return self;
}

-(void)initViews{
    [self initDiction];
    [self initAlertText];
}

-(void)initDiction{
    UIActivityIndicatorView *activity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.frame=CGRectMake(30, 30, 0, 0);
    [activity startAnimating];
    [self addSubview:activity];
    _activity=activity;
    
    [self stopAnimation];
}

-(void)initAlertText{
    UILabel *alertLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 180, self.frame.size.height)];
    [alertLabel setTextColor:[UIColor whiteColor]];
    [alertLabel setText:@"正在定位中..."];
    _alertText=alertLabel;
    [self addSubview:alertLabel];
}

-(void)initRefushBtn{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(20, 0, 180, self.frame.size.height)];
    [btn setTitle:@"点击重新定位" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(refush:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

-(void)refush:(UIButton *)aBtn{
    [aBtn removeFromSuperview];
    [_activity startAnimating];
    [self initAlertText];
    [self stopAnimation];
    if ([self.delegate respondsToSelector:@selector(indictionView:refueshView:)]) {
        [self.delegate indictionView:self refueshView:aBtn];
    }
}

-(void)stopAnimation{
    __weak YIIBIndictionView *__self=self;
    //停止提示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*10), dispatch_get_main_queue(), ^{
        [_activity stopAnimating];
        [_alertText removeFromSuperview];
        [__self initRefushBtn];
    });
}

@end
