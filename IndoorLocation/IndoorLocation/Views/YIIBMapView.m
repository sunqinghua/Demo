//
//  YMMapView.m
//  mall
//
//  Created by HAO FENG on 14-7-16.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import "YIIBMapView.h"
#import "NavigationLine.h"


@implementation YIIBMapView

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initParams];
        [self initViews];
    }
    return self;
}

-(void)initParams{
    _markerTransform = CGAffineTransformIdentity;
    _mapTransform = CGAffineTransformIdentity;
    _markerDic = [[NSMutableDictionary alloc] init];
    _floorMapDic = [[NSMutableDictionary alloc] init];
    
    [self initRigesterNotifaction];
}

-(void)initRigesterNotifaction{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateHeading) name:NOTIFICATION_UPDATE_HEADING object:nil];
}

-(void)initViews{
    [self initScrollView];
    [self initFollowView];
    [self initStepperView];
    [self initFloorView];
    [self initMyLocation];
    [self initSelfView];
}

-(void)initSelfView{
    self.clipsToBounds = YES;
    self.followSelf = YES;
    self.currentMapFloor = 0;
}

#pragma mark -滑动ScrollView
-(void)initScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delegate = self;
    [self addSubview:scrollView];
    _scrollView=scrollView;
}

#pragma mark -跟随
-(void)initFollowView{
    UIButton *btnLocate = [self buttonWithNormal:[KResourcesPrefix stringByAppendingPathComponent:@"map_tool_locate_normal"] highlighted:@"map_tool_locate_highlighted"];
    btnLocate.frame = CGRectMake(12, self.frame.size.height - 62, 32, 32);
    [btnLocate addTarget:self action:@selector(locateSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnLocate];
    _locateButton = btnLocate;
}

#pragma mark -地图缩放
-(void)initStepperView{
    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(self.frame.size.width - 94-10, self.frame.size.height - 59, 94, 29)];
    stepper.maximumValue = 0;
    stepper.minimumValue = 0;
    stepper.backgroundColor = [UIColor whiteColor];
    stepper.tintColor=[UIColor colorWithRed:24/255.f green:180/255.f blue:237/255.f alpha:1];
    stepper.layer.cornerRadius = 4;
    [stepper setHidden:YES];
    [stepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:stepper];
    _mapStepper = stepper;
}

#pragma mark -楼层改变
-(void)initFloorView{
    YIIBMapToolView *toolView = [[YIIBMapToolView alloc] initWithFrame:CGRectMake(self.frame.size.width - 42, 20, 32, self.frame.size.height - 100)];
    toolView.delegate = self;
    toolView.floorView.delegate = self;
    [toolView setHidden:YES];
    [self addSubview:toolView];
    _toolView=toolView;
}

#pragma mark -当前我的位置
-(void)initMyLocation{
    YIIBMeIndicator *me = [YIIBMeIndicator view];
    _selfIndicator = me;
    [_selfIndicator setHidden:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didUpdateHeading
{
    //    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
    //
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    if (!_followHeading) {
        return;
    }
    
    if (_currentUserLocate.x == 0 || _currentUserLocate.y == 0) {
        return;
    }
    
    [self refreshHeading];
}

- (void)refreshHeading
{
    _imageView.transform = CGAffineTransformIdentity;
    //    _imageView.layer.anchorPoint = CGPointMake((_currentUserLocate.x * _currentScale)/_imageView.bounds.size.width, (_imageView.bounds.size.height - _currentUserLocate.y * _currentScale)/_imageView.bounds.size.height);
    //    CGPoint anchor = [self convertPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) toView:_imageView];
    //    _imageView.layer.anchorPoint = CGPointMake(anchor.x / _imageView.bounds.size.width, (_imageView.bounds.size.height - anchor.y) / _imageView.bounds.size.height);
    
    
    //    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
    //
    //    } completion:nil];
    
    double angle = [YMBeaconManager sharedManager].currentHeading.magneticHeading;
    
    if (abs(_lastAngle - angle) < 5 || abs(_lastAngle - angle) > 355) {
        angle = _lastAngle;
    }
    _lastAngle = angle;
    //    double angle = (int)([YMBeaconManager sharedManager].currentHeading.magneticHeading / 5) * 5;
    
    _mapTransform = CGAffineTransformMakeRotation(M_PI*(360 - angle)/180.0);
    _imageView.transform = _mapTransform;
    _compass.compassTransform = _mapTransform;
    
    //    _selfIndicator.transform = CGAffineTransformIdentity;
    //    CGAffineTransform transform2 = CGAffineTransformMakeRotation(M_PI*([YMBeaconManager sharedManager].currentHeading.magneticHeading)/180.0);
    //    _selfIndicator.transform = transform2;
    
    
    //    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
    //        <#code#>
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    _markerTransform = CGAffineTransformMakeRotation(M_PI*(angle)/180.0);
    
    for (UIView *view in _markerView.subviews) {
        view.transform = CGAffineTransformIdentity;
        view.transform = _markerTransform;
    }
    
    if (_followSelf) {
        CGPoint point = [_scrollView convertPoint:_selfIndicator.center fromView:_markerView];
        float width = _scrollView.frame.size.width;
        //float height = _scrollView.frame.size.height-200;
        float height = _scrollView.frame.size.height;
        
        CGRect rect = CGRectMake(point.x - width/2, point.y - height/2, width, height);
         [_scrollView scrollRectToVisible:rect animated:YES];
    }
}

- (void)locateSelected
{
    if (self.followSelf) {
        [self stopFollowAnimate];
        self.followSelf = NO;
    }
    else {
        self.isFocusUser = NO;
        [self focusSelfLocation];
        [self startFollowAnimate];
    }
}

#pragma mark YIIBMapToolView的代理方法
- (void)refreshBtnSelect
{
    if ([_delegate respondsToSelector:@selector(refreshDidSelect)]) {
        NSLog(@"mapview刷新");
        [_delegate refreshDidSelect];
        //创建通知
        //        NSNotification *notification =[NSNotification notificationWithName:NOTIFICATION_UPDATE_HEADING object:nil userInfo:nil];
        //        //通过通知中心发送通知
        //        [[NSNotificationCenter defaultCenter] postNotification:notification];
        //        [self refreshHeading];
    }
}

- (void)startFollowAnimate
{
    [_locateButton setImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"map_tool_locate_follow"]] forState:UIControlStateNormal];
}

- (void)stopFollowAnimate
{
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

- (void)gotoFloor:(int)floor
{
    _toolView.floorView.currentFloor = floor;
}

- (void)focusCoordinate:(CGPoint)point floor:(int)floor
{
    if (floor == 0) {
        return;
    }
    if (_currentMapStep != 2) {
        self.currentMapStep = 2;
    }
    point = CGPointMake(point.x * _currentScale, _imageView.bounds.size.height - point.y * _currentScale);
    point = [_scrollView convertPoint:point fromView:_imageView];
    self.isFocusUser = NO;
    self.followSelf = NO;
    if (floor != _currentMapFloor) {
        _toolView.floorView.currentFloor = floor;
    }
    
    float width = _scrollView.frame.size.width;
    float height = _scrollView.frame.size.height;
    CGRect rect = CGRectMake(point.x - width/2, point.y - height/2, width, height);
    [_scrollView scrollRectToVisible:rect animated:NO];
}

- (void)setFollowHeading:(BOOL)followHeading
{
    if (_followHeading != followHeading) {
        _followHeading = followHeading;
        _selfIndicator.followHeading = !_followHeading;
        if (!_followHeading) {
            _imageView.transform = CGAffineTransformIdentity;
            _compass.compassTransform = CGAffineTransformIdentity;
            _markerTransform = CGAffineTransformIdentity;
            _mapTransform = CGAffineTransformIdentity;
            _imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            for (UIView *view in _markerView.subviews) {
                view.transform = CGAffineTransformIdentity;
            }
        }
        else {
            // 跟随方向初始化
            [self refreshHeading];
        }
    }
}

- (void)setFollowSelf:(BOOL)followSelf
{
    if (_followSelf != followSelf) {
        _followSelf = followSelf;
        self.followHeading = _followSelf;
        
        if (_followSelf) {
            [self startFollowAnimate];
        }
        else {
            [self stopFollowAnimate];
        }
    }
}

- (void)setShowSignalView:(BOOL)showSignalView
{
    _showSignalView = showSignalView;
    if (_showSignalView) {
        if (!_signalView) {
            // build
            _signalView = [YIIBSignalView view];
            _signalView.center = CGPointMake(40, 20);
            [self addSubview:_signalView];
            [self bringSubviewToFront:_signalView];
        }
        [_signalView setHidden:NO];
    }
    else {
        if (_signalView) {
            [_signalView setHidden:YES];
        }
    }
}

- (void)setShowCompass:(BOOL)showCompass
{
    _showCompass = showCompass;
    if (_showCompass) {
        if (!_compass) {
            _compass = [YIIBCompass view];
            _compass.center = CGPointMake(40, 64);
            [self addSubview:_compass];
            [self bringSubviewToFront:_compass];
        }
        [_compass setHidden:NO];
    }
    else {
        if (_compass) {
            [_compass setHidden:YES];
        }
    }
}

- (void)setShowInfoButton:(BOOL)showInfoButton
{
    _showInfoButton = showInfoButton;
    if (_showInfoButton) {
        if (!_infoButton) {
            _infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_infoButton setImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"icon_info"]] forState:UIControlStateNormal];
            [_infoButton setFrame:CGRectMake(0, 0, 45, 45)];
            _infoButton.center = CGPointMake(40, 105);
            [_infoButton addTarget:self action:@selector(didSelectPlaceInfo) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_infoButton];
            [self bringSubviewToFront:_infoButton];
        }
        [_infoButton setHidden:NO];
    }
    else {
        if (_infoButton) {
            [_infoButton setHidden:YES];
        }
    }
}

- (void)didSelectPlaceInfo
{
    if ([_delegate respondsToSelector:@selector(didSelectPlaceInfo)]) {
        [_delegate didSelectPlaceInfo];
    }
}

- (void)setHideMarker:(BOOL)hideMarker
{
    _hideMarker = hideMarker;
    [_markerView setHidden:_hideMarker];
}

- (void)setHideToolView:(BOOL)hideToolView
{
    _hideToolView = hideToolView;
    [_toolView setHidden:_hideToolView];
}

- (void)setCurrentMapStep:(int)currentMapStep
{
    _currentMapStep = currentMapStep;
    _mapStepper.value = _currentMapStep;
    [self stepperValueChanged:_mapStepper];
}

- (void)setPlace:(YIIBPlace *)place
{
    _place = place;
    _currentUserLocate.x = 0;
    _currentUserLocate.y = 0;
    [_selfIndicator setHidden:YES];
    
    _floorMapDic = [[NSMutableDictionary alloc] init];
    [_toolView.floorView setTop:_place.topfloor low:_place.lowfloor];
    [_toolView.floorView setCurrentFloor:_place.topfloor];
    self.currentMapFloor = _place.topfloor;
    //添加
    if (_noPlaceView) {
        [_noPlaceView removeFromSuperview];
        _noPlaceView = nil;
    }
}

- (void)setCurrentMapFloor:(int)currentFloor
{
    _currentMapFloor = currentFloor;
    YIIBFloorMap *map = [_floorMapDic objectForKey:[NSString stringWithFormat:@"%d", currentFloor]];
    if (!map) {
        [_mapStepper setMaximumValue:0];
        [_mapStepper setValue:0];
        //        if (![YMBeaconManager sharedManager].placeid) {
        //            return;
        //        }
        
        [_toolView setHidden:NO];
        [_mapStepper setHidden:NO];
        
        //        if (!_mapManager) {
        _mapManager = [YIIBMapManager manager];
        //        }
        _mapManager.queryFloorMapBlock = ^(YIIBFloorMap *map, NSString *error) {
            if (map) {
                [_floorMapDic setObject:map forKey:[NSString stringWithFormat:@"%d", currentFloor]];
                [self buildFloorMap:map];
            }
        };
        [_mapManager queryFloorMapWithPlaceid:_place.placeid floor:_currentMapFloor];
    }
    else {
        [self buildFloorMap:map];
    }
}

- (void)buildFloorMap:(YIIBFloorMap *)map
{   self.floorMap=map;
    int scaleCount = (int)map.maps.count;
    [_mapStepper setMaximumValue:scaleCount - 1];
    if (_currentMapStep < scaleCount && _currentMapStep >= 0) {
        [self setCurrentMapStep:_currentMapStep];
    }
    else {
        [self setCurrentMapStep:0];
    }
}

- (void)stepperValueChanged:(UIStepper *)stepper
{
    @synchronized(_mapStepper) {
        int value = stepper.value;
        if (value > _currentMapStep) {
            _autoScale = NO;
        }
        _currentMapStep = value;
        YIIBFloorMap *floorMap = [_floorMapDic objectForKey:[NSString stringWithFormat:@"%d", _currentMapFloor]];
        if (floorMap) {
            YIIBMap *map = [floorMap.maps objectAtIndex:_currentMapStep];
            [self buildMap:map];
        }
    }
}


- (void)buildMap:(YIIBMap *)map
{
    @synchronized(self) {
        NSLog(@"--- build map %f---", map.scale);
        float scale = map.scale / 2.f;
        if (map && map != _currentMap) {
            if (_noPlaceView) {
                [_noPlaceView removeFromSuperview];
                _noPlaceView = nil;
            }
            _currentMap = map;
            _currentScale = scale;
            
            // 当前滑到的位置
            float percentX = 0;
            float percentY = 0;
            if (_imageView) {
                //        NSLog(@"%f, %f", _scrollView.contentOffset.x, _scrollView.contentOffset.y);
                percentX = (_scrollView.contentOffset.x - MAP_GAP_LEFT + _scrollView.frame.size.width / 2) / (_scrollView.contentSize.width - MAP_GAP_LEFT - MAP_GAP_RIGHT);
                percentY = (_scrollView.contentOffset.y - MAP_GAP_TOP + _scrollView.frame.size.height / 2) / (_scrollView.contentSize.height - MAP_GAP_TOP - MAP_GAP_BOTTOM);
            }
            
            // 清空marker字典
            [_markerDic removeAllObjects];
            
            // 移除除了自身以外的所有view
            for (UIView *view in _scrollView.subviews) {
                if (view != _selfIndicator) {
                    [view removeFromSuperview];
                }
            }
            
            NSLog(@"--- real build map %f---", map.scale);
            // 建立mapview
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, map.width/2.f, map.height/2.f)];
            __block UIImageView *bImageView = imageView;
            // loading图
            UIView *loadingView = [[UIView alloc] initWithFrame:imageView.bounds];
            //        loadingView.backgroundColor = GLOBAL_DISABLE_TINT;
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            indicator.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 30);
            [indicator startAnimating];
            [loadingView addSubview:indicator];
            [self addSubview:loadingView];
            //
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:map.image] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                UIColor *color = nil;
                if (image) {
                    unsigned char *imgPixel = RequestImagePixelData(image);
                    int i = 0;
                    int r = (unsigned char)imgPixel[i];
                    int g = (unsigned char)imgPixel[i+1];
                    int b = (unsigned char)imgPixel[i+2];
                    color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (bImageView.superview && color) {
                        bImageView.superview.backgroundColor = color;
                    }
                    [loadingView removeFromSuperview];
                });
            }];
            
            int width = imageView.frame.size.width + MAP_GAP_LEFT + MAP_GAP_RIGHT;
            int height = imageView.frame.size.height + MAP_GAP_TOP + MAP_GAP_BOTTOM;
            
            _scrollView.contentSize = CGSizeMake(width < _scrollView.frame.size.width ? _scrollView.frame.size.width : width,
                                                 height < _scrollView.frame.size.height ? _scrollView.frame.size.height : height);
            
            float offsetX = imageView.frame.size.width * percentX - _scrollView.frame.size.width / 2 + MAP_GAP_LEFT;
            float offsetY = imageView.frame.size.height * percentY - _scrollView.frame.size.height / 2 + MAP_GAP_TOP;
            
            offsetX = offsetX < 0 ? 0 : offsetX;
            offsetY = offsetY < 0 ? 0 : offsetY;
            
            offsetX = offsetX > _scrollView.contentSize.width - _scrollView.frame.size.width ? _scrollView.contentSize.width - _scrollView.frame.size.width : offsetX;
            offsetY = offsetY > _scrollView.contentSize.height - _scrollView.frame.size.height ? _scrollView.contentSize.height - _scrollView.frame.size.height : offsetY;
            if (offsetX == 0 && offsetY == 0) {
                offsetX = _scrollView.contentSize.width/4;
                offsetY = _scrollView.contentSize.height/4;
            }
            _scrollView.contentOffset = CGPointMake(offsetX, offsetY);
            
            
            imageView.center = CGPointMake(_scrollView.contentSize.width/2.f + (MAP_GAP_LEFT - MAP_GAP_RIGHT) / 2,
                                           _scrollView.contentSize.height/2.f + (MAP_GAP_TOP - MAP_GAP_BOTTOM) / 2);
            [_scrollView addSubview:imageView];
            _imageView = imageView;
            if (_floorImageChangeBlock) {
                _floorImageChangeBlock(0,map.scale);
            }
            _imageAnchorPoint = _imageView.layer.anchorPoint;
            
            // 建立marker层
            _markerView = [[UIView alloc] initWithFrame:imageView.bounds];
            //            _markerView.backgroundColor = [UIColor blueColor];
            [_markerView setHidden:_hideMarker];
            [imageView addSubview:_markerView];
            //            _markerView.transform = imageView.transform;
            
            // 手势
            UIPinchGestureRecognizer *reco = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(gestureFired:)];
            [_scrollView addGestureRecognizer:reco];
            
            if (_currentUserLocate.x != 0 && _currentUserLocate.y != 0) {
                [self moveSelfToX:_currentUserLocate.x y:_currentUserLocate.y floor:_currentUserFloor animated:NO checkSelf:NO];
                if (_followSelf) {
                    CGPoint selfPos = [_scrollView convertPoint:_selfIndicator.center fromView:_markerView];
                    CGPoint centerPos = [self convertPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) toView:_scrollView];
                    _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + selfPos.x - centerPos.x,
                                                            _scrollView.contentOffset.y + selfPos.y - centerPos.y);
                }
                
                
                imageView.transform = CGAffineTransformIdentity;
                imageView.transform = _mapTransform;
                for (UIView *view in _markerView.subviews) {
                    view.transform = CGAffineTransformIdentity;
                    view.transform = _markerTransform;
                }
            }
        }
        
        NSLog(@"--- set marker map %f---", map.scale);
        // marker重新放置
        for (UIView *view in _markerView.subviews) {
            [view removeFromSuperview];
        }
        
        for (YIIBRecord *pos in _recordPositions) {
            if (pos.placeid != _place.placeid || pos.floor != _currentMapFloor) {
                continue;
            }
            YIIBMarker *marker = [YIIBMarker markerWithStyle:YIIBMarkerStyleGreen];
            [self placeMarker:marker point:CGPointMake(pos.coordinateX, pos.coordinateY) scale:scale];
            marker.textLabel.text = pos.name;
            [_markerView addSubview:marker];
            
            [_markerDic setObject:marker forKey:[NSString stringWithFormat:@"record%d", pos.recordid]];
        }
        
        for (YIIBCarPosition *pos in _carPositions) {
            if (pos.placeid != _place.placeid || pos.coordinate.floor != _currentMapFloor) {
                continue;
            }
            YIIBMarker *marker = [YIIBMarker markerWithStyle:YIIBMarkerStyleCar];
            [self placeMarker:marker point:CGPointMake(pos.coordinate.x, pos.coordinate.y) scale:scale];
            [_markerView addSubview:marker];
            [_markerDic setObject:marker forKey:@"car"];
        }
        
        for (YIIBActivity *activity in _activities) {
            if (activity.floor != _currentMapFloor) {
                continue;
            }
            YIIBMarker *marker = [YIIBMarker markerWithStyle:YIIBMarkerStyleActivity];
            marker.tag = activity.activityid.intValue;
            [self placeMarker:marker point:CGPointMake(activity.coordinateX, activity.coordinateY) scale:scale];
            marker.textLabel.text = activity.shopname;
            [_markerView addSubview:marker];
            [marker addTarget:self action:@selector(activityDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
        [_imageView setUserInteractionEnabled:YES];
        [_markerView setUserInteractionEnabled:YES];
        
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        
        for (YIIBUser *pos in _userPositions) {
            if (pos.placeid != _place.placeid || pos.floor != _currentMapFloor) {
                continue;
            }
            if (_isFocusUser && _focusUserId != pos.userid) {
                continue;
            }
            YIIBMarker *marker = [YIIBMarker markerWithStyle:pos.sex ? YIIBMarkerStyleMale : YIIBMarkerStyleFemale];
            [self placeMarker:marker point:CGPointMake(pos.coordinateX, pos.coordinateY) scale:scale];
            marker.textLabel.text = pos.nickname;
            
            //            NSLog(@"-------user pos : %.2f,%.2f scale:%.2f ------", pos.coordinateX, pos.coordinateY, scale);
            //            NSLog(@"-------imageView %.2f,%.2f -------", _imageView.frame.size.width, _imageView.frame.size.height);
            if (now - pos.modifyTime > 600) {
                [marker gray];
            }
            
            [_markerView addSubview:marker];
            [_markerDic setObject:marker forKey:[NSString stringWithFormat:@"user%d", pos.userid]];
        }
        
        [_markerView addSubview:_selfIndicator];
        [_markerView bringSubviewToFront:_selfIndicator];
        
        [self checkFocusUser];
    }
}

- (void)checkFocusUser
{
    NSLog(@"==== checkFocusUser ====");
    //    if (_isFocusUser) {
    //        YMUserPos *userPos;
    //        for (YMUserPos *pos in _userPositions) {
    //            if (pos.userId == _focusUserId) {
    //                userPos = pos;
    //                break;
    //            }
    //        }
    //        if (userPos) {
    //            if (userPos.floor == _currentMapFloor) {
    //                // 跟随的好友已经在当前楼层
    //                [self focusUserWithId:_focusUserId];
    //            }
    //            else {
    //                // 跟随的好友不在当前楼层，切换楼层
    //                _toolView.floorView.currentFloor = userPos.floor;
    //            }
    //        }
    //    }
}

- (void)setIsFocusUser:(BOOL)isFocusUser
{
    if (_isFocusUser != isFocusUser) {
        _isFocusUser = isFocusUser;
        if (_isFocusUser) {
            
        }
        else {
            if (_currentMapFloor != _currentUserFloor) {
                [_selfIndicator setHidden:YES];
            }
        }
    }
}

- (void)setUserPositions:(NSArray *)userPositions
{
    _userPositions = userPositions;
    self.currentMapStep = self.currentMapStep;
}

- (void)setRecordPositions:(NSArray *)recordPositions
{
    _recordPositions = recordPositions;
    self.currentMapStep = self.currentMapStep;
}

- (void)setCarPositions:(NSArray *)carPositions
{
    _carPositions = carPositions;
    self.currentMapStep = self.currentMapStep;
}

- (void)setActivities:(NSArray *)activities
{
    _activities = activities;
    self.currentMapStep = self.currentMapStep;
}

- (void)gestureFired:(UIPinchGestureRecognizer *)reco
{
    //    NSLog(@"gestureFired %f", reco.scale);
    if (reco.state == UIGestureRecognizerStateEnded) {
        if (reco.scale < 0.7 && _mapStepper.value > 0) {
            _mapStepper.value = _mapStepper.value - 1;
            [self stepperValueChanged:_mapStepper];
        }
        else if (reco.scale > 1.3 && _mapStepper.value < _mapStepper.maximumValue) {
            _mapStepper.value = _mapStepper.value + 1;
            [self stepperValueChanged:_mapStepper];
        }
    }
}

- (void)activityDidSelect:(YIIBMarker *)marker
{
    //    for (YMActivity *activity in _activities) {
    //        if (activity.activityId == marker.tag) {
    //            if ([_delegate respondsToSelector:@selector(didSelectActivity:)]) {
    //                [_delegate didSelectActivity:activity];
    //            }
    //            break;
    //        }
    //    }
}

- (void)placeMarker:(YIIBMarker *)marker point:(CGPoint)point scale:(float)scale
{
    marker.center = CGPointMake(point.x * scale, _imageView.bounds.size.height - point.y * scale);
    marker.transform = _markerTransform;
}

- (void)moveSelfToX:(float)x y:(float)y floor:(int)floor animated:(BOOL)animated
{
    [self moveSelfToX:x y:y floor:floor animated:animated checkSelf:YES];
}

- (void)moveSelfToX:(float)x y:(float)y floor:(int)floor animated:(BOOL)animated checkSelf:(BOOL)checkSelf
{
    if (floor == 0) {
        self.followSelf = NO;
    }
    float scale = _currentScale;
    _currentUserLocate = CGPointMake(x, y);
    _currentUserFloor = floor;
    if (floor == self.currentMapFloor) {
        [_selfIndicator setHidden:NO];
        [_selfIndicator setHideFloor:YES];
        _selfIndicator.alpha = 1;
    }
    else if (floor != 0) {
        if (_followSelf) {
            self.isFocusUser = NO;
            _toolView.floorView.currentFloor = _currentUserFloor;
        }
        if (_isFocusUser) {
            [_selfIndicator setHidden:NO];
            _selfIndicator.alpha = 0.7;
            _selfIndicator.floorStr = [_toolView.floorView floorTitleWithFloor:floor];
            [_selfIndicator setHideFloor:NO];
            if (checkSelf) {
                [self checkSelfCanSee];
            }
        }
        else {
            [_selfIndicator setHidden:YES];
        }
    }
    if (self.followHeading) {
        CGPoint newAnchorPoint = CGPointMake((_currentUserLocate.x * _currentScale)/_imageView.bounds.size.width, (_imageView.bounds.size.height - _currentUserLocate.y * _currentScale)/_imageView.bounds.size.height);
        double delta = pow(newAnchorPoint.x - _imageAnchorPoint.x, 2) + pow(newAnchorPoint.y - _imageAnchorPoint.y, 2);
        if (delta > 0) {
            //NSLog(@"*******set anchorPoint******** %f", delta);
            CGPoint beforePoint = CGPointMake(_imageView.layer.anchorPoint.x * _imageView.bounds.size.width, _imageView.layer.anchorPoint.y * _imageView.bounds.size.height);
            CGPoint afterPoint = CGPointMake(newAnchorPoint.x * _imageView.bounds.size.width, newAnchorPoint.y * _imageView.bounds.size.height);
            CGPoint sBeforePoint = [_scrollView convertPoint:beforePoint fromView:_imageView];
            CGPoint sAfterPoint = [_scrollView convertPoint:afterPoint fromView:_imageView];
            
            CGPoint deltaPos = CGPointMake(sAfterPoint.x - sBeforePoint.x, sAfterPoint.y - sBeforePoint.y);
            _imageView.layer.anchorPoint = newAnchorPoint;
            _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x - deltaPos.x, _scrollView.contentOffset.y - deltaPos.y);
//            NSLog(@"=== content offset %.2f, %02f ===", deltaPos.x, deltaPos.y);
            _imageAnchorPoint = newAnchorPoint;
        }
    }
    if (!_selfIndicator.hidden && animated) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _selfIndicator.center = CGPointMake(x * scale, _imageView.bounds.size.height - y * scale);
           // NSLog(@"_scrollView.contentOffset=%@",NSStringFromCGPoint(_scrollView.contentOffset));
        } completion:nil];
    }
    else {
        _selfIndicator.center = CGPointMake(x * scale, _imageView.bounds.size.height - y * scale);//[_markerView convertPoint: toView:_scrollView];
    }
    if (_followSelf && floor != 0) {
        [self focusSelfLocation];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_followSelf) {
        NSLog(@"============== 取消跟随 ============");
        //        _followSelf = NO;
        self.followSelf = NO;
        _checkDraging = YES;
        _dragBefore = scrollView.contentOffset;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (_checkDraging) {
        int deltaX = abs(targetContentOffset->x - _dragBefore.x);
        int deltaY = abs(targetContentOffset->y - _dragBefore.y);
        NSLog(@"=========== drag %d,%d ==========", deltaX, deltaY);
        if (deltaX < 50 && deltaY < 50) {
            self.followSelf = YES;
        }
        _checkDraging = NO;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self checkSelfCanSee];
    
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

- (void)checkSelfCanSee
{
    @synchronized(self) {
        if (_isFocusUser && _autoScale) {
            NSLog(@"------------end------------------");
            CGPoint selfPos = [self convertPoint:_selfIndicator.center fromView:_scrollView];
            if (selfPos.x < 0 || selfPos.x > self.frame.size.width || selfPos.y < 0 || selfPos.y > self.frame.size.height) {
                NSLog(@"!!!!!!!!!!!!!!!out!!!!!!!!!!!!!!!!!");
                if (_currentMapStep > 0) {
                    self.currentMapStep = _currentMapStep - 1;
                }
            }
        }
    }
}

#pragma mark - tool view delegate
- (void)focusSelfLocation
{
    if (_place.placeid != [YMBeaconManager sharedManager].placeid || _currentUserFloor == 0) {
        return;
    }
    self.followSelf = YES;
    if (_currentMapFloor != _currentUserFloor) {
        _toolView.floorView.currentFloor = _currentUserFloor;
    }
    
    NSLog(@"============== 开始跟随 ============");
    
    
    CGPoint point = [_scrollView convertPoint:_selfIndicator.center fromView:_markerView];
    float width = _scrollView.frame.size.width;
   // float height = _scrollView.frame.size.height-200;
    float height = _scrollView.frame.size.height;
    
    
    CGRect rect = CGRectMake(point.x - width/2, point.y - height/2, width, height);
    [_scrollView scrollRectToVisible:rect animated:YES];
    
}

- (void)cancelFollowing
{
    self.followSelf = NO;
}

- (void)hideMarker:(BOOL)hideMarker
{
    self.hideMarker = hideMarker;
}

- (void)focusUserWithId:(int)userid
{
    YIIBUser *userPos = nil;
    for (YIIBUser *pos in _userPositions) {
        if (pos.userid == userid) {
            userPos = pos;
            break;
        }
    }
    if (userPos) {
        self.followSelf = NO;
        _focusUserId = userid;
        if (!_isFocusUser) {
            _autoScale = YES;
        }
        self.isFocusUser = YES;
        if (userPos.floor == _currentMapFloor) {
            YIIBMarker *marker = [_markerDic objectForKey:[NSString stringWithFormat:@"user%d", userid]];
            if (marker) {
                CGPoint point = marker.center;
                float width = _scrollView.frame.size.width;
                float height = _scrollView.frame.size.height;
                
                CGRect rect = CGRectMake(point.x - width/2, point.y - height/2, width, height);
                [_scrollView scrollRectToVisible:[_scrollView convertRect:rect fromView:_imageView] animated:YES];
            }
        }
        else {
            _toolView.floorView.currentFloor = userPos.floor;
        }
    }
}

- (void)focusRecordWithId:(int)recordId
{
    YIIBRecord *recordPos = nil;
    for (YIIBRecord *pos in _recordPositions) {
        if (pos.recordid == recordId) {
            recordPos = pos;
            break;
        }
    }
    if (recordPos) {
        self.followSelf = NO;
        if (recordPos.floor == _currentMapFloor) {
            YIIBMarker *marker = [_markerDic objectForKey:[NSString stringWithFormat:@"record%d", recordId]];
            if (marker) {
                CGPoint point = marker.center;
                float width = _scrollView.frame.size.width;
                float height = _scrollView.frame.size.height;
                
                CGRect rect = CGRectMake(point.x - width/2, point.y - height/2, width, height);
                [_scrollView scrollRectToVisible:[_scrollView convertRect:rect fromView:_imageView] animated:YES];
            }
        }
        else {
            _toolView.floorView.currentFloor = recordPos.floor;
        }
    }
}

- (void)focusCar
{
    if (_carPositions.count) {
        YIIBCarPosition *pos = [_carPositions objectAtIndex:0];
        //        [self focusCoordinate:CGPointMake(pos.coordinateX, pos.coordinateY) floor:pos.floor];
        self.followSelf = NO;
        self.isFocusUser = NO;
        if (pos.coordinate.floor == _currentMapFloor) {
            YIIBMarker *marker = [_markerDic objectForKey:@"car"];
            
            CGPoint point = marker.center;
            float width = _scrollView.frame.size.width;
            float height = _scrollView.frame.size.height;
            
            CGRect rect = CGRectMake(point.x - width/2, point.y - height/2, width, height);
            [_scrollView scrollRectToVisible:[_scrollView convertRect:rect fromView:_imageView] animated:YES];
        }
        else {
            _toolView.floorView.currentFloor = pos.coordinate.floor;
        }
    }
}

#pragma mark -绘制线路
-(void)drawLineWithPointList:(NSArray *)paths scale:(CGFloat)scale{
    //缩放比例
    CGFloat  s= scale;
    //    NSValue *v=[NSValue valueWithCGPoint:CGPointMake(20*s, 20*s)];
    //    NSValue *v1=[NSValue valueWithCGPoint:CGPointMake(40*s, 20*s)];
    //    NSValue *v2=[NSValue valueWithCGPoint:CGPointMake(40*s, 120*s)];
    //    NSValue *v3=[NSValue valueWithCGPoint:CGPointMake(150*s, 120*s)];
    //
    //    NSArray *list=[NSArray arrayWithObjects:v,v1,v2,v3,nil];
    
    if(paths){
        //清除旧的
        NavigationLine *old=(NavigationLine *)[_imageView viewWithTag:888888];
        [old removeFromSuperview];
    
        NavigationLine *line=[[NavigationLine alloc]initWithFrame:_imageView.bounds pathList:paths scale:s];
        line.backgroundColor=[UIColor clearColor];
        line.lineWidth=2.0;
        line.lineColor=[UIColor blueColor];
        line.lineScale=1;
        line.tag=888888;
        [_imageView addSubview:line];
    }
}

- (void)didSelectFloor:(int)floor manul:(BOOL)manul
{
    NSLog(@"--- didSelectFloor:%d ---", floor);
    if (floor != _currentMapFloor) {
        self.currentMapFloor = floor;
        //        _followSelf = NO;
        if (manul) {
            self.followSelf = NO;
            self.isFocusUser = NO;
        }
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

static unsigned char *RequestImagePixelData(UIImage *inImage)
{
    CGImageRef img = [inImage CGImage];
    //使用上面的函数创建上下文
    CGContextRef cgctx = CreateRGBABitmapContext(img);
    
    CGRect rect = {{0,0},{1, 1}};
    //将目标图像绘制到指定的上下文，实际为上下文内的bitmapData。
    CGContextDrawImage(cgctx, rect, img);
    unsigned char *data = CGBitmapContextGetData (cgctx);
    //释放上面的函数创建的上下文
    CGContextRelease(cgctx);
    return data;
}

static CGContextRef CreateRGBABitmapContext (CGImageRef inImage)
{
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *bitmapData; //内存空间的指针，该内存空间的大小等于图像使用RGB通道所占用的字节数。
    int bitmapByteCount;
    int bitmapBytesPerRow;
    
    size_t pixelsWide = 1; //获取横向的像素点的个数
    size_t pixelsHigh = 1;
    
    
    
    bitmapBytesPerRow    = (pixelsWide * 4); //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit(0-255)的空间
    bitmapByteCount    = (bitmapBytesPerRow * pixelsHigh); //计算整张图占用的字节数
    
    colorSpace = CGColorSpaceCreateDeviceRGB();//创建依赖于设备的RGB通道
    //分配足够容纳图片字节数的内存空间
    bitmapData = malloc( bitmapByteCount );
    //创建CoreGraphic的图形上下文，该上下文描述了bitmaData指向的内存空间需要绘制的图像的一些绘制参数
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    //Core Foundation中通过含有Create、Alloc的方法名字创建的指针，需要使用CFRelease()函数释放
    CGColorSpaceRelease( colorSpace );
    return context;
}
@end
