//
//  YMMapView.h
//  mall
//
//  Created by HAO FENG on 14-7-16.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YIIBMarker.h"
#import "YIIBMapToolView.h"
#import "YIIBUser.h"
#import "YIIBRecord.h"
//#import "YMCarPos.h"
#import "YIIBMeIndicator.h"
//#import "YMDataManager.h"
#import "UIImageView+WebCache.h"
#import "YIIBSignalView.h"
#import "YIIBCompass.h"
#import "YIIBActivity.h"
#import "YIIBMap.h"
#import "YIIBFloorMap.h"
#import "YIIBPlace.h"
#import "YMBeaconLocate.h"
#import "YIIBMapManager.h"
#import "YIIBCarPosition.h"
#import "YIIBIndictionView.h"

#define MAP_GAP_LEFT        200
#define MAP_GAP_TOP         200
#define MAP_GAP_RIGHT       245
#define MAP_GAP_BOTTOM      200

@protocol YIIBMapViewDelegate <NSObject>
- (void)refreshDidSelect;
- (void)didSelectActivity:(YIIBActivity *)activity;
- (void)didSelectPlaceInfo;
@end

typedef void(^MapViewFloorImageChange)(NSInteger error,NSInteger scale);
typedef void(^MapViewLocationCurrent)(NSInteger error);

@interface YIIBMapView : UIView<YIIBMapToolViewDelegate,UIScrollViewDelegate,YMFloorSelectViewDelegate,YIIBIndictionViewDelegate>
{
    UIScrollView *_scrollView;
    UIView *_markerView;
    YIIBMapToolView *_toolView;
    NSMutableDictionary *_markerDic;
    NSMutableDictionary *_floorMapDic;
    
    UIView *_noPlaceView;
    
    YIIBMap *_currentMap;
    
    YIIBSignalView *_signalView;
    
    YIIBCompass *_compass;
    
    CGAffineTransform _markerTransform;
    CGAffineTransform _mapTransform;
    CGPoint _imageAnchorPoint;
    
    UIButton *_infoButton;
    
    double _lastAngle;
    YIIBMapManager *_mapManager;
}
@property (nonatomic, strong) YIIBMeIndicator *selfIndicator;
@property (nonatomic, weak) UIStepper *mapStepper;
@property (nonatomic, weak) UIButton *locateButton;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) CGPoint currentUserLocate;
@property (nonatomic, assign) BOOL hideToolView;
@property (nonatomic, assign) int currentMapStep;
@property (nonatomic, assign) float currentScale;

@property (nonatomic, strong) NSArray *userPositions;
@property (nonatomic, strong) NSArray *recordPositions;
@property (nonatomic, strong) NSArray *carPositions;
@property (nonatomic, strong) NSArray *activities;

@property (nonatomic, assign) BOOL followSelf;
@property (nonatomic, assign) BOOL hideMarker;
@property (nonatomic, strong) YIIBPlace *place;
@property (nonatomic, assign) BOOL showSignalView;

@property (nonatomic, assign) BOOL showCompass;

@property (nonatomic, assign) BOOL showInfoButton;

@property (nonatomic, assign) BOOL followHeading;

@property (nonatomic, assign) CGPoint posToFocus;

@property (nonatomic, assign) BOOL checkDraging;
@property (nonatomic, assign) CGPoint dragBefore;

@property (nonatomic, assign) int currentMapFloor;
@property (nonatomic, assign) int currentUserFloor;

@property (nonatomic, assign) int focusUserId;
@property (nonatomic, assign) BOOL isFocusUser;

@property (nonatomic, assign) BOOL autoScale;

@property (nonatomic,copy) MapViewFloorImageChange floorImageChangeBlock;
@property (nonatomic,copy) MapViewLocationCurrent locationCurrentBlock;

@property (nonatomic,strong) YIIBFloorMap *floorMap;

@property (nonatomic, weak) id<YIIBMapViewDelegate> delegate;

- (void)focusSelfLocation;
- (void)focusUserWithId:(int)userid;
- (void)focusRecordWithId:(int)recordId;
- (void)focusCar;
- (void)moveSelfToX:(float)x y:(float)y floor:(int)floor animated:(BOOL)animated;
-(void)drawLineWithPointList:(NSArray *)point scale:(CGFloat)scale;
- (void)gotoFloor:(int)floor;
- (void)focusCoordinate:(CGPoint)point floor:(int)floor;
@end
