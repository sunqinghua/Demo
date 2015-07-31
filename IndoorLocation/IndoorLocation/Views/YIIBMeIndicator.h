//
//  YMMeIndicator.h
//  mall
//  我的指示器
//  Created by HAO FENG on 14-8-28.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YIIBMeIndicator : UIView
{
    //UIImageView *_arrowImageView;
    UILabel *_lblFloor;
    UIImageView *_me;
    UIImageView *_indicator;
}
+ (YIIBMeIndicator *)view;
@property (nonatomic, strong) NSString *floorStr;
@property (nonatomic, assign) BOOL hideFloor;
@property (nonatomic, assign) BOOL followHeading;

-(void)meIndicatorSacleChange:(NSInteger )scale;

@end
