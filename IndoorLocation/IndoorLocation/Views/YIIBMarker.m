//
//  YMMarker.m
//  mall
//
//  Created by HAO FENG on 14-7-17.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import "YIIBMarker.h"

@implementation YIIBMarker

+ (YIIBMarker *)markerWithStyle:(YIIBMarkerStyle)style
{
    switch (style) {
        case YIIBMarkerStyleBlue:
        {
            YIIBMarker *marker = [YIIBMarker buttonWithType:UIButtonTypeCustom];
            marker.style = YIIBMarkerStyleBlue;
            marker.frame = CGRectMake(0, 0, 26.5, 66);
            [marker setImage:[UIImage imageNamed:@"map_pin_blue"] forState:UIControlStateNormal];
            [marker buildTitleView];
            return marker;
        }
            break;
        case YIIBMarkerStyleGreen:
        {
            YIIBMarker *marker = [YIIBMarker buttonWithType:UIButtonTypeCustom];
            marker.style = YIIBMarkerStyleGreen;
//            marker.backgroundColor = [UIColor blueColor];
            marker.frame = CGRectMake(0, 0, 26.5, 66);
            [marker setImage:[UIImage imageNamed:@"map_pin_green"] forState:UIControlStateNormal];
            [marker buildTitleView];
            return marker;
        }
            break;
        case YIIBMarkerStyleMe:
        {
            YIIBMarker *marker = [YIIBMarker buttonWithType:UIButtonTypeCustom];
            marker.style = YIIBMarkerStyleMe;
            marker.frame = CGRectMake(0, 0, 25.5, 33);
            [marker setImage:[UIImage imageNamed:@"map_pin_me"] forState:UIControlStateNormal];
            return marker;
        }
            break;
        case YIIBMarkerStyleCar:
        {
            YIIBMarker *marker = [YIIBMarker buttonWithType:UIButtonTypeCustom];
            marker.style = YIIBMarkerStyleCar;
            marker.frame = CGRectMake(0, 0, 26.5, 66);
            [marker setImage:[UIImage imageNamed:@"map_pin_car"] forState:UIControlStateNormal];
            return marker;
        }
            break;
        case YIIBMarkerStyleMale:
        {
            YIIBMarker *marker = [YIIBMarker buttonWithType:UIButtonTypeCustom];
            marker.style = YIIBMarkerStyleMale;
            marker.frame = CGRectMake(0, 0, 26.5, 66);
            [marker setImage:[UIImage imageNamed:@"map_pin_male"] forState:UIControlStateNormal];
            [marker buildTitleView];
            return marker;
        }
            break;
        case YIIBMarkerStyleFemale:
        {
            YIIBMarker *marker = [YIIBMarker buttonWithType:UIButtonTypeCustom];
            marker.style = YIIBMarkerStyleFemale;
            marker.frame = CGRectMake(0, 0, 26.5, 66);
            [marker setImage:[UIImage imageNamed:@"map_pin_female"] forState:UIControlStateNormal];
            [marker buildTitleView];
            return marker;
        }
            break;
        case YIIBMarkerStyleActivity:
        {
            YIIBMarker *marker = [YIIBMarker buttonWithType:UIButtonTypeCustom];
            marker.style = YIIBMarkerStyleActivity;
            marker.frame = CGRectMake(0, 0, 45, 45);
            [marker setImage:[UIImage imageNamed:@"sale"] forState:UIControlStateNormal];
//            [marker buildTitleView];
            return marker;
        }
            break;
        default:
            return nil;
            break;
    }
    
}

- (void)gray
{
    switch (_style) {
        case YIIBMarkerStyleMale:
        {
            [self setImage:[UIImage imageNamed:@"map_pin_male_gray"] forState:UIControlStateNormal];
            [_titleImageView setImage:[UIImage imageNamed:@"marker_window_gray"]];
        }
            break;
        case YIIBMarkerStyleFemale:
        {
            [self setImage:[UIImage imageNamed:@"map_pin_female_gray"] forState:UIControlStateNormal];
            [_titleImageView setImage:[UIImage imageNamed:@"marker_window_gray"]];
        }
            break;
    }
}

- (void)buildTitleView
{
    _titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.style == YIIBMarkerStyleGreen ? @"marker_window_green" : @"marker_window"]];
    _titleImageView.center = CGPointMake(self.frame.size.width/2, - 16);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:_titleImageView.bounds];
    titleLabel.center = CGPointMake(_titleImageView.frame.size.width/2, _titleImageView.frame.size.height/2 - 3);
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleImageView addSubview:titleLabel];
    titleLabel.text = @"丁建伟";
    _textLabel = titleLabel;
    [self addSubview:_titleImageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
