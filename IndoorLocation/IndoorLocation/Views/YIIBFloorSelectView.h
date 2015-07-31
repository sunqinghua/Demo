//
//  YMFloorSelectView.h
//  mall
//
//  Created by HAO FENG on 14-7-17.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IZValueSelectorView.h"

@protocol YMFloorSelectViewDelegate <NSObject>
- (void)didSelectFloor:(int)floor manul:(BOOL)manul;
@end

@interface YIIBFloorSelectView : UIView<IZValueSelectorViewDataSource,IZValueSelectorViewDelegate>
{
    IZValueSelectorView *_picker;
    int _top;
    int _low;
    
    int _topNum;
    int _lowNum;
}
@property (nonatomic, weak) id<YMFloorSelectViewDelegate> delegate;
@property (nonatomic, assign) int currentFloor;
@property (nonatomic, weak) UIImageView *selectionImageView;
- (void)setTop:(int)top low:(int)low;

- (void)changeFloorAnimation;

- (NSString *)floorTitleWithFloor:(int)floor;
@end
