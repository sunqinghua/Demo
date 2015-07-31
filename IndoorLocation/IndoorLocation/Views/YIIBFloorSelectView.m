//
//  YMFloorSelectView.m
//  mall
//
//  Created by HAO FENG on 14-7-17.
//  Copyright (c) 2014年 beacool. All rights reserved.
//

#import "YIIBFloorSelectView.h"

@implementation YIIBFloorSelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:24/255.f green:180/255.f blue:237/255.f alpha:1].CGColor;
        
        _picker = [[IZValueSelectorView alloc] initWithFrame:self.bounds];
        [_picker setSelectedImageName:[KResourcesPrefix stringByAppendingPathComponent:@"map_floor_selector"]];
       // [_picker setSelectedImageName:@"map_floor_selector"];
        [self addSubview:_picker];
        _picker.dataSource = self;
        _picker.delegate = self;
    }
    return self;
}

- (void)setTop:(int)top low:(int)low
{
    _top = top;
    _low = low;
    if (_top > 0) {
        if (_low > 0) {
            _topNum = _top - _low + 1;
            _lowNum = 0;
        }
        else {
            _topNum = _top;
            _lowNum = - _low;
        }
    }
    else {
        _topNum = 0;
        _lowNum = _top - _low + 1;
    }
    
//    [_picker selectRowAtIndex:0];
//    if (_topNum + _lowNum) {
//        [_picker selectRowAtIndex:0];
//    }
    self.currentFloor = 0;
}

- (void)setCurrentFloor:(int)currentFloor
{
    _currentFloor = currentFloor;
    int index = _top - _currentFloor;
    if (_currentFloor < 0) {
        index = _topNum - _currentFloor - 1;
    }
    if (index >= 0 && index < _topNum + _lowNum) {
        int floor = 0;
        if (index < _topNum) {
            floor = (int)(_top - index);
        }
        else {
            floor = (int)(_low + (_topNum + _lowNum - index - 1));
        }
        _currentFloor = floor;
        [_picker reloadData];
        [_picker selectRowAtIndex:index animated:YES];
        if ([_delegate respondsToSelector:@selector(didSelectFloor:manul:)]) {
            [_delegate didSelectFloor:floor manul:NO];
        }
    }
}

- (void)changeFloorAnimation
{
    [UIImageView animateWithDuration:0.5 animations:^{
        _picker.selectionImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [UIImageView animateWithDuration:0.5 animations:^{
            _picker.selectionImageView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIImageView animateWithDuration:0.5 animations:^{
                _picker.selectionImageView.alpha = 0;
            } completion:^(BOOL finished) {
                [UIImageView animateWithDuration:0.5 animations:^{
                    _picker.selectionImageView.alpha = 1;
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}

- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector
{
    return _topNum + _lowNum;
}

- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index selected:(BOOL)selected
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32, 50)];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    if (selected) {
        titleLabel.textColor = [UIColor whiteColor];
    }
    else {
        titleLabel.textColor = [UIColor colorWithRed:24/255.f green:180/255.f blue:237/255.f alpha:1];
    }
    if (index < _topNum) {
        titleLabel.text = [NSString stringWithFormat:@"L%d", (int)(_top - index)];
    }
    else {
        titleLabel.text = [NSString stringWithFormat:@"B%d", -(int)(_low + (_topNum + _lowNum - index - 1))];
    }
    
    return titleLabel;
}

- (NSString *)floorTitleWithFloor:(int)floor
{
    if (floor > 0) {
        return [NSString stringWithFormat:@"L%d", floor];
    }
    else {
        return [NSString stringWithFormat:@"B%d", abs(floor)];
    }
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector
{
    return CGRectMake(0, valueSelector.frame.size.height/2 - 25, 32, 50);
}

- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector
{
    return 50;
}

- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector
{
    return 32;
}

- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index
{
    int floor = 0;
    if (index < _topNum) {
        floor = (int)(_top - index);
    }
    else {
        floor = (int)(_low + (_topNum + _lowNum - index - 1));
    }
    _currentFloor = floor;
    if ([_delegate respondsToSelector:@selector(didSelectFloor:manul:)]) {
        [_delegate didSelectFloor:floor manul:YES];
    }
}
@end
