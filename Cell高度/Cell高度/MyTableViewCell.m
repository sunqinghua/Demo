//
//  MyTableViewCell.m
//  Cell高度获取
//
//  Created by admin on 15/6/19.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyTableViewCell.h"
#import "MyView.h"

@implementation MyTableViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        NSLog(@"cell.Frame=%@",NSStringFromCGRect(self.frame));
        [self initView];
    }
    return self;
}

-(void)initView{
    MyView *my=[[MyView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    my.backgroundColor=[UIColor redColor];
    [self addSubview:my];
}

-(void)layoutSubviews{
    NSLog(@"%s,cell.Frame=%@",__FUNCTION__,NSStringFromCGRect(self.frame));

}
-(void)drawRect:(CGRect)rect{
    NSLog(@"%s",__FUNCTION__);
}
- (void)awakeFromNib {
    NSLog(@"%s",__FUNCTION__);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
