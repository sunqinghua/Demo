//
//  YIIBNavigationModel.h
//  YIVasMobile
//
//  Created by admin on 15/4/8.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YIIBNavigationModel : NSObject

@property (nonatomic,assign)        int placeid; //商场id
@property (nonatomic,assign)        int currenfloor;//当前楼层
@property (nonatomic,assign)        CGFloat currenX;//当前位置X
@property (nonatomic,assign)        CGFloat currenY;//当前位置Y
@property (nonatomic,copy)          NSString *currentName;//当前名称
@property (nonatomic,assign)        CGFloat destinationX;//目的X
@property (nonatomic,assign)        CGFloat destinationY;//目的Y
@property (nonatomic,copy)          NSString *destinationName;//目的名称
@property (nonatomic,assign)        NSInteger *destinationfloor;//目的楼层

@property (nonatomic,copy) NSString *currentLocation;
@property (nonatomic,copy) NSString *destinationLocation;

@end
