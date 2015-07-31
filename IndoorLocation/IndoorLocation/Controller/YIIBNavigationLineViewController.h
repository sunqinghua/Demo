//
//  YIIBNavigationLineViewController.h
//  YIVasMobile
//
//  Created by admin on 15/4/3.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "YIIBMapView.h"
#import "YIIBPlaceManager.h"
#import "YIIBCarPosition.h"
#import "YIIBRecord.h"
#import "YIIBNavigationModel.h"

@interface YIIBNavigationLineViewController : UIViewController<YIIBMapViewDelegate,YMBeaconLocationDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, weak) YIIBMapView *mapView;
@property (nonatomic, strong) YIIBPlace *locatePlace;
@property (nonatomic, strong) YIIBPlace *selectPlace;
@property (nonatomic, strong) YIIBCarPosition *carPosition;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic,strong) YIIBNavigationModel *navigationModel;

- (void)deleteCarPosition;
- (void)focusCar;
- (void)focusRecord:(YIIBRecord *)record;


@end
