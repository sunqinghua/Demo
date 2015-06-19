//
//  MyView.m
//  Cell高度获取
//
//  Created by admin on 15/6/19.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        NSLog(@"myview.Frame=%@",NSStringFromCGRect(self.frame));
    }
    
    return self;
}

@end
