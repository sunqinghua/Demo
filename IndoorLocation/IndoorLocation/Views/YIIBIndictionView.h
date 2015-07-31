//
//  YIIBIndictionView.h
//  YIVasMobile
//
//  Created by admin on 15/4/8.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YIIBIndictionView;

@protocol YIIBIndictionViewDelegate <NSObject>

-(void)indictionView:(YIIBIndictionView *)view refueshView:(UIButton *)aBtn;

@end

@interface YIIBIndictionView : UIView

@property (nonatomic,assign) id<YIIBIndictionViewDelegate> delegate;

@end
