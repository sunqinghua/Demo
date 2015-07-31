//
//  YIIBPushModel.h
//  YIVasMobile
//
//  Created by admin on 15/3/30.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIIBPushModel : NSObject

@property (nonatomic,copy) NSString *placeid;//商场id
@property (nonatomic,copy) NSString *storeID;//商店id
@property (nonatomic,copy) NSString *edgeid;//区域id
@property (nonatomic,copy) NSString *ibeaconID;//设备id
@property (nonatomic,copy) NSString *pushContentID;//推送内容id
@property (nonatomic,copy) NSString *pushTime;//推送时间
@property (nonatomic,copy) NSString *activityid;//


@end
