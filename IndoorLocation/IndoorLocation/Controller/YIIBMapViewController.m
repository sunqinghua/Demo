//
//  YIIBMapViewController.m
//  YIVasMobile
//  室内导航-主页
//  Created by darren on 14-12-16.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import "YIIBMapViewController.h"
#import "YIIBPlaceManager.h"
#import "YIIBMapView.h"


#define UPLOAD_SELF_POSITION_TIME           2.5
#define UPDATE_FRIENDS_POSITION_TIME        5

@interface YIIBMapViewController ()<YIIBMapViewDelegate,YMBeaconLocationDelegate,YIIBIndictionViewDelegate>
{
    YIIBMapView *_mapView;
    UIView *_noPlaceView;
    YIIBPlace *_locatePlace;
    YIIBPlace *_selectPlace;
    NSTimeInterval _lastUploadSelfPositionTime;
    YIIBCoordinate * currentCoordinate;
    YIIBCoordinate *currentLocation;
    
}
@end

@implementation YIIBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
    [self initViews];
    
    
    
}

#pragma mark -初始化params
-(void)initParams{
}

#pragma mark -初始化Views
-(void)initViews{
    [self initBeacon];
    [self initMap];
    [self initSelfView];
    [self initLocationFailView];
}

-(void)initSelfView{
    self.view.backgroundColor=[UIColor whiteColor];
}

#pragma mark -初始化ibeacon
-(void)initBeacon{
    [[YMBeaconManager sharedManager] startUpdateLocation];
    [YMBeaconManager sharedManager].locationDelegate = self;
}

#pragma mark -初始化Map
-(void)initMap{
    YIIBMapView *mapView = [[YIIBMapView alloc] initWithFrame:CGRectMake(0, 0, KMainScreenSize.width, KMainScreenSize.height)];
    mapView.delegate = self;
    mapView.showSignalView = NO;
    mapView.showCompass = YES;
    mapView.showInfoButton = NO;
    mapView.locationCurrentBlock=^(NSInteger error){
       
    };
    mapView.floorImageChangeBlock=^(NSInteger error,NSInteger scale){
        NSLog(@"scale=%f",_mapView.mapStepper.value);
        
        [self mapViewChangeWithScale:_mapView.mapStepper.value];
    };
    [self.view addSubview:mapView];
    _mapView = mapView;
}

-(void)mapViewChangeWithScale:(NSInteger)scale{
    [_mapView.selfIndicator meIndicatorSacleChange:scale];
}

#pragma mark -遮挡View
-(void)initLocationFailView{
    // 正在定位
   _noPlaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImageView *noMapImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"no_map"]]];
    noMapImageView.frame = _noPlaceView.bounds;
    [_noPlaceView addSubview:noMapImageView];
    
    
    YIIBIndictionView *view=[[YIIBIndictionView alloc]initWithFrame:CGRectMake((_noPlaceView.frame.size.width-200)*.5, (_noPlaceView.frame.size.height-60)*.5, 200, 60)];
    view.delegate=self;
    [_noPlaceView addSubview:view];
    
    [self.view addSubview:_noPlaceView];
}

#pragma mark -刷新定位
-(void)indictionView:(YIIBIndictionView *)view refueshView:(UIButton *)aBtn{
    [self stopBeacon];
    [self initBeacon];
    YIIBPlaceManager * placeManager = [YIIBPlaceManager manager];
    placeManager.queryPlaceInfoBlock = ^(YIIBPlace *place, NSString *error) {
        if (place) {
            self.locatePlace = place;
        }
    };
//    if (_curPlaceID>0) {
//        [placeManager queryPlaceInfoWithPlaceid:_curPlaceID];
//    }
}

#pragma mark -停止ibeacon
-(void)stopBeacon{
    [[YMBeaconManager sharedManager] stopUpdateLocation];
    [YMBeaconManager sharedManager].locationDelegate = nil;
}


- (void)setLocatePlace:(YIIBPlace *)locatePlace
{
    _locatePlace = locatePlace;
    // 定位到商场
    self.selectPlace = _locatePlace;
}

- (void)setSelectPlace:(YIIBPlace *)selectPlace
{
    _selectPlace = selectPlace;
    _mapView.place = _selectPlace;
    
    if (_noPlaceView) {
        [_noPlaceView removeFromSuperview];
        _noPlaceView = nil;
    }
}

#pragma mark - locate lib delegate
/* 进入商场 */
- (void)didEnterPlaceid:(int)placeid
{
    NSLog(@"进入商场：%i",placeid);
    YIIBPlaceManager * placeManager = [YIIBPlaceManager manager];
    placeManager.queryPlaceInfoBlock = ^(YIIBPlace *place, NSString *error) {
        if (place) {
            self.locatePlace = place;
        }
    };
    [placeManager queryPlaceInfoWithPlaceid:placeid];
    //[[YIIBStatisticsManager sharedManager] resetEdgeList];
}

/* 离开商场 */
- (void)didExitPlaceid:(int)placeid
{
    NSLog(@"离开商场：%i",placeid);
    _locatePlace = nil;
}

/* 位置更新回调 */
- (void)didMovetoX:(float)x y:(float)y floor:(int)floor
{
    //self.testLabel.text=[NSString stringWithFormat:@"X=%f,y=%f",x,y];
    
    NSLog(@"位置更新回调：%.2f,%.2f,%i",x,y,floor);
    YIIBCoordinate * c=[[YIIBCoordinate alloc] initWithX:x y:y floor:floor];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
   // NSLog(@"now：%f,%f",now,_lastUploadSelfPositionTime);
    if (now - _lastUploadSelfPositionTime > UPLOAD_SELF_POSITION_TIME) {
            // 上传自身位置到后台
            if (_locatePlace&&![c isEqual:currentCoordinate]) {
                
//                YIIBUserLocationManager *uploadPositionManager = [YIIBUserLocationManager manager];
//                uploadPositionManager.uploadUserLocationBlock = ^(NSString *result, NSString *error) {
//                    _lastUploadSelfPositionTime = [[NSDate date] timeIntervalSince1970];
//                };
//                [uploadPositionManager uploadUserLocation:[[YIIBCoordinate alloc] initWithX:x y:y floor:floor]
//                                                  placeid:_locatePlace.placeid
//                                               memberCode:[YIIBUserManager sharedManager].memberCode
//                                             terminalCode:[YIIBUserManager sharedManager].terminalCode];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_mapView moveSelfToX:x y:y floor:floor animated:YES];
        });
}


@end
