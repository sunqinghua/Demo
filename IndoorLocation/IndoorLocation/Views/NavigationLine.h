//
//  NavigationLine.h
//  YIVasMobile
//
//  Created by admin on 15/4/3.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationLine : UIView

@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,assign) NSInteger lineWidth;
@property (nonatomic,assign) NSInteger lineScale;

-(id)initWithFrame:(CGRect)frame pathList:(NSArray *)list scale:(CGFloat)scale;


@end
