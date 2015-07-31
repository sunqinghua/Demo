//
//  YMMapToolView.m
//  mall
//
//  Created by HAO FENG on 14-7-17.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import "YIIBMapToolView.h"

@implementation YIIBMapToolView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIButton *btnRefresh = [self buttonWithNormal:@"map_tool_refresh_normal" highlighted:@"map_tool_refresh_highlighted"];
        btnRefresh.frame = CGRectMake(0, 0, frame.size.width, frame.size.width);
       // [self addSubview:btnRefresh];
        [btnRefresh addTarget:self action:@selector(refreshBtnSelect) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btnMarker = [self buttonWithNormal:@"map_tool_marker_normal" highlighted:@"map_tool_marker_highlighted"];
        btnMarker.frame = CGRectMake(0, frame.size.height - frame.size.width, frame.size.width, frame.size.width);
        [self addSubview:btnMarker];
        [btnMarker setHidden:YES];
        [btnMarker addTarget:self action:@selector(markerSelected) forControlEvents:UIControlEventTouchUpInside];
        _markerButton = btnMarker;
        
        
        UIButton *btnLocate = [self buttonWithNormal:@"map_tool_locate_normal" highlighted:@"map_tool_locate_highlighted"];
        btnLocate.frame = CGRectMake(-270, btnMarker.frame.origin.y - frame.size.width - CTRL_GAP, frame.size.width, frame.size.width);
        [self addSubview:btnLocate];
        [btnLocate setHidden:YES];
        _locateButton = btnLocate;
        [btnLocate addTarget:self action:@selector(locateSelected) forControlEvents:UIControlEventTouchUpInside];
        
//        YIIBFloorSelectView *floorView = [[YIIBFloorSelectView alloc] initWithFrame:CGRectMake(0, frame.size.width + CTRL_GAP, frame.size.width, btnLocate.frame.origin.y - frame.size.width - CTRL_GAP * 2)];
        
        YIIBFloorSelectView *floorView = [[YIIBFloorSelectView alloc] initWithFrame:CGRectMake(0, frame.size.width + CTRL_GAP, frame.size.width, self.frame.size.height-frame.size.width - CTRL_GAP*2)];
        [self addSubview:floorView];
        _floorView = floorView;
    }
    return self;
}

- (void)refreshBtnSelect
{
    if ([_delegate respondsToSelector:@selector(refreshBtnSelect)]) {
        [_delegate refreshBtnSelect];
    }
}

- (void)locateSelected
{
    if (_following) {
        [self stopFollowAnimate];
        if ([_delegate respondsToSelector:@selector(cancelFollowing)]) {
            [_delegate cancelFollowing];
        }
    }
    else {
        if ([_delegate respondsToSelector:@selector(focusSelfLocation)]) {
            [_delegate focusSelfLocation];
        }
        [self startFollowAnimate];
    }
}

- (void)markerSelected
{
    _hideMarker = !_hideMarker;
    if (_hideMarker) {
        _markerButton.alpha = 0.5;
    }
    else {
        _markerButton.alpha = 1;
    }
    if ([_delegate respondsToSelector:@selector(hideMarker:)]) {
        [_delegate hideMarker:_hideMarker];
    }
}

- (void)startFollowAnimate
{
    _following = YES;
    [_locateButton setImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"map_tool_locate_follow"]] forState:UIControlStateNormal];
}

- (void)stopFollowAnimate
{
    _following = NO;
    [_locateButton setImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"map_tool_locate_normal"]] forState:UIControlStateNormal];
}

- (UIButton *)buttonWithNormal:(NSString *)normal highlighted:(NSString *)highlighted
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    button.layer.cornerRadius = 4;
    button.layer.borderColor = [UIColor colorWithRed:24/255.f green:180/255.f blue:237/255.f alpha:1].CGColor;
    button.layer.borderWidth = 1;
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    [button setContentMode:UIViewContentModeCenter];
    button.clipsToBounds = YES;
    return button;
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
