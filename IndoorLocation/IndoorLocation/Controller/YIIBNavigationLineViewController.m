//
//  YIIBNavigationLineViewController.m
//  YIVasMobile
//
//  Created by admin on 15/4/3.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "YIIBNavigationLineViewController.h"
#import "YIIBMapViewController.h"


#import "YIIBPlaceManager.h"
#import "YIIBUserLocationManager.h"
#import "Common.h"
#import "UIView+Add.h"
#import "YIIBMapLineManager.h"
#import "MBProgressHUD+Addition.h"


#define UPLOAD_SELF_POSITION_TIME           2.5
#define UPDATE_FRIENDS_POSITION_TIME        5

@interface YIIBNavigationLineViewController ()
{
    YIIBRecord *_record;
    YIIBPlaceManager *_placeManager;
    YIIBUserLocationManager *_updateFriendsManager;
    YIIBUserLocationManager *_uploadPositionManager;
    dispatch_once_t _onceToken;
    UIView *_noPlaceView;
    
    NSTimer *_updateFriendsTimer;
    NSTimeInterval _lastUploadSelfPositionTime;
    
    NSArray *_edges;
    YIIBCoordinate * currentCoordinate;
}

@end

@implementation YIIBNavigationLineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initParams];
    [self initViews];
}

-(void)initParams{
    [self initIbeacon];
}

-(void)initViews{
    [self initMap];
    [self initSelfView];
    if ([YMBeaconManager sharedManager].placeid > 0) {
        [self didEnterPlaceid:[YMBeaconManager sharedManager].placeid];
    }
}

-(void)initSelfView{
    self.title=@"导航";
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initIbeacon{
    [YMBeaconManager sharedManager].locationDelegate = self;
    [[YMBeaconManager sharedManager] startUpdateLocation];
}


-(void)initMap{
    YIIBMapView *mapView = [[YIIBMapView alloc] initWithFrame:CGRectMake(0, 64, KMainScreenSize.width, KMainScreenSize.height-64)];
   // mapView.backgroundColor=[UIColor redColor];
    [_contentView addSubview:mapView];
    _mapView = mapView;
    _mapView.delegate = self;
    _mapView.showSignalView = YES;
    _mapView.showCompass = YES;
    _mapView.showInfoButton = NO;
    _mapView.floorImageChangeBlock=^(NSInteger error,NSInteger scale){
        if ([_mapView.floorMap.maps objectAtIndex:0]) {
            YIIBMap *map=[_mapView.floorMap.maps objectAtIndex:0];
            [self queryMapLineWithScale:_mapView.currentScale/map.scale];
        }

        
        NSLog(@"_mapView.mapStepper.value=%f",_mapView.mapStepper.value);
    };
}

#pragma mark -查询MapLine
-(void)queryMapLineWithScale:(CGFloat)scale{
    
    __weak YIIBNavigationLineViewController *__self=self;
    YIIBMapLineManager *manager=[[YIIBMapLineManager alloc]init];
    manager.mapLineBlock=^(NSArray *data,NSString *error){
        [MBProgressHUD dismissMyHUD:__self];
        if (error) {
            [YIToast showText:error];
        }else{
            [__self.mapView drawLineWithPointList:data scale:scale];
            NSLog(@"queryMapLine-----Done");
        }
    };
    
    if (self.navigationModel.currentName&&self.navigationModel.destinationName) {
        [MBProgressHUD shareMyHUDAt:__self];
       [manager queryMapLineWithPlaceid:self.navigationModel.placeid floor:self.navigationModel.currenfloor startLocation:self.navigationModel.currentName endLocation:self.navigationModel.destinationName];
    }
    
    //[manager queryAddressMatchingWithStartName:self.navigationModel.currentLocation endName:self.navigationModel.destinationName floor:self.navigationModel.currenfloor place:self.navigationModel.placeid];
    
}

-(void)initHUB{
    if ([YMBeaconManager sharedManager].placeid > 0) {
        [self didEnterPlaceid:[YMBeaconManager sharedManager].placeid];
    }else {
        _noPlaceView = [[UIView alloc] initWithFrame:self.view.bounds];
        UIImageView *noMapImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[KResourcesPrefix stringByAppendingPathComponent:@"no_map"]]];
        noMapImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [_noPlaceView addSubview:noMapImageView];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.center = CGPointMake(_mapView.frame.size.width/2, _mapView.frame.size.height/2 - 30);
        [indicator startAnimating];
        [_noPlaceView addSubview:indicator];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        lbl.text = @"正在定位...";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:18];
        [lbl setTextColor:[UIColor colorWithRed:24/255.f green:180/255.f blue:237/255.f alpha:1]];
        lbl.center = CGPointMake(_mapView.frame.size.width/2, _mapView.frame.size.height/2);
        [_noPlaceView addSubview:lbl];
        
        [_mapView addSubview:_noPlaceView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!_noPlaceView) {
                return;
            }
            [indicator removeFromSuperview];
            [lbl removeFromSuperview];
            UIImageView *noMapTextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_place_text"]];
            noMapTextImageView.frame = CGRectMake((320 - 214)/2, (_mapView.frame.size.height - 60)/2, 214, 48.5);
            noMapImageView.tag=888;
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((320 - 214)/2, (_mapView.frame.size.height - 60)/2, 214, 48.5)];
            [btn addTarget:self action:@selector(refreshMapView:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor=[UIColor blackColor];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitle:@"定位失败,重新刷新" forState:UIControlStateNormal];
            [_noPlaceView addSubview:btn];
            //[_noPlaceView addSubview:noMapTextImageView];
        });
    }

}

- (void)viewDidLayoutSubviews
{
    dispatch_once(&_onceToken, ^{
            });
}

-(void)refreshMapView:(UIButton *)aBtn{
    UIImageView *noMapTextImageView =(UIImageView *)[_noPlaceView viewWithTag:888];
    [YMBeaconManager sharedManager].locationDelegate = self;
    [[YMBeaconManager sharedManager] stopUpdateLocation];
    [[YMBeaconManager sharedManager] startUpdateLocation];
    
    YIIBPlaceManager * placeManager = [YIIBPlaceManager manager];
    placeManager.queryPlaceInfoBlock = ^(YIIBPlace *place, NSString *error) {
        if (place) {
            self.locatePlace = place;
            
            [aBtn removeFromSuperview];
            [noMapTextImageView removeFromSuperview];
        }
    };
    [placeManager queryPlaceInfoWithPlaceid:_locatePlace.placeid];
    
    
}



- (IBAction)selectPlace:(id)sender {
    //[self performSegueWithIdentifier:@"SelectPlace" sender:nil];
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
    [_titleButton setTitle:_selectPlace.name forState:UIControlStateNormal];
    _mapView.place = _selectPlace;
    YIIBCarPosition *carPosition = self.carPosition;
    if (carPosition.placeid == _selectPlace.placeid) {
        _mapView.carPositions = @[carPosition];
    }
    if (_noPlaceView) {
        [_noPlaceView removeFromSuperview];
        _noPlaceView = nil;
    }
}

- (void)refreshRecords
{
//    YIIBRecordManager *recordManager = [YIIBRecordManager manager];
//    recordManager.queryUserRecords = ^(NSArray *records, NSString *error) {
//        _mapView.recordPositions = records;
//    };
//    [recordManager queryUserRecordsWithMemberCode:[YIIBUserManager sharedManager].memberCode
//                                     terminalCode:[YIIBUserManager sharedManager].terminalCode];
}


#pragma mark - mapview delegate
- (void)refreshDidSelect
{
//    [MBProgressHUD shareMyHUDAt:self];
//    
//    [self updateFriendsList];
//    [self refreshRecords];
//    [self refreshActivities];
//    
//    [MBProgressHUD  dismissMyHUD:self];
}
- (void)didSelectActivity:(YIIBActivity *)activity
{
    
}
- (void)didSelectPlaceInfo
{
    [self performSegueWithIdentifier:@"PlaceInfo" sender:nil];
}

#pragma mark - mapview operation
- (void)focusCar
{
    YIIBCarPosition *pos = self.carPosition;
    [_mapView focusCoordinate:CGPointMake(pos.coordinate.x, pos.coordinate.y) floor:pos.coordinate.floor];
}

- (void)focusRecord:(YIIBRecord *)record
{
    [_mapView focusCoordinate:CGPointMake(record.coordinateX, record.coordinateY) floor:record.floor];
}

- (void)shopLocate:(NSNotification *)notification
{
    YIIBActivity *activity = [notification.userInfo objectForKey:@"activity"];
    if (activity.shopid) {
        [_mapView focusCoordinate:CGPointMake(activity.coordinateX, activity.coordinateY) floor:activity.floor];
    }
    [self.navigationController popToViewController:self animated:YES];
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
    //[self queryMapLineWithScale:107];
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
   // NSLog(@"位置更新回调：%.2f,%.2f,%i",x,y,floor);
    YIIBCoordinate * c=[[YIIBCoordinate alloc] initWithX:x y:y floor:floor];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
   // NSLog(@"now：%f,%f",now,_lastUploadSelfPositionTime);
    if (now - _lastUploadSelfPositionTime > UPLOAD_SELF_POSITION_TIME) {
        // 上传自身位置到后台
        if (_locatePlace&&![c isEqual:currentCoordinate]) {
            
        
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView moveSelfToX:x y:y floor:floor animated:YES];
    });
}

#pragma mark - tools
- (void)setCarPosition:(YIIBCarPosition *)carPosition
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (carPosition) {
        [ud setObject:[NSNumber numberWithInt:carPosition.placeid] forKey:@"CAR_PLACE_ID"];
        [ud setObject:[NSNumber numberWithInt:carPosition.coordinate.floor] forKey:@"CAR_FLOOR"];
        [ud setObject:[NSNumber numberWithFloat:carPosition.coordinate.x] forKey:@"CAR_COORDINATE_X"];
        [ud setObject:[NSNumber numberWithFloat:carPosition.coordinate.y] forKey:@"CAR_COORDINATE_Y"];
        [ud synchronize];
        _mapView.carPositions = @[carPosition];
    }
    else {
        [ud removeObjectForKey:@"CAR_PLACE_ID"];
        [ud synchronize];
        _mapView.carPositions = nil;
    }
}

- (YIIBCarPosition *)carPosition
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber *placeid = [ud objectForKey:@"CAR_PLACE_ID"];
    if (placeid) {
        float coordinateX = [[ud objectForKey:@"CAR_COORDINATE_X"] floatValue];
        float coordinateY = [[ud objectForKey:@"CAR_COORDINATE_Y"] floatValue];
        int floor = [[ud objectForKey:@"CAR_FLOOR"] intValue];
        YIIBCarPosition *position = [[YIIBCarPosition alloc] init];
        position.placeid = placeid.intValue;
        position.coordinate = [[YIIBCoordinate alloc] initWithX:coordinateX y:coordinateY floor:floor];
        return position;
    }
    return nil;
}

- (void)deleteCarPosition
{
    self.carPosition = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
}


@end
