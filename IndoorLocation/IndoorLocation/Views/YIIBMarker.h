//
//  YMMarker.h
//  mall
//
//  Created by HAO FENG on 14-7-17.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YIIBMarkerStyleBlue,
    YIIBMarkerStyleMe,
    YIIBMarkerStyleMale,
    YIIBMarkerStyleFemale,
    YIIBMarkerStyleCar,
    YIIBMarkerStyleGreen,
    YIIBMarkerStyleActivity
}YIIBMarkerStyle;

@interface YIIBMarker : UIButton
{
    UIImageView *_titleImageView;
}
@property (nonatomic, assign) YIIBMarkerStyle style;
@property (nonatomic, weak) UILabel *textLabel;

+ (YIIBMarker *)markerWithStyle:(YIIBMarkerStyle)style;
- (void)gray;
@end
