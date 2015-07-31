//
//  YMMapToolView.h
//  mall
//
//  Created by HAO FENG on 14-7-17.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YIIBFloorSelectView.h"

#define CTRL_GAP 6

@protocol YIIBMapToolViewDelegate <NSObject>
- (void)refreshBtnSelect;
- (void)focusSelfLocation;
- (void)cancelFollowing;
- (void)hideMarker:(BOOL)hideMarker;
@end

@interface YIIBMapToolView : UIView
@property (nonatomic, weak) YIIBFloorSelectView *floorView;
@property (nonatomic, weak) UIButton *markerButton;
@property (nonatomic, weak) UIButton *locateButton;
@property (nonatomic, assign) BOOL hideMarker;
@property (nonatomic, weak) id<YIIBMapToolViewDelegate> delegate;
@property (nonatomic, assign) BOOL following;

- (void)startFollowAnimate;
- (void)stopFollowAnimate;
@end
