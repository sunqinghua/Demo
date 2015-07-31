//
//  YIIBNavigationSearhView.h
//  YIVasMobile
//
//  Created by admin on 15/4/2.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YICustomTextField.h"
@interface YIIBNavigationSearhView : UIView
@property (weak, nonatomic) IBOutlet UIButton *search;
@property (weak, nonatomic) IBOutlet UIButton *change;
@property (weak, nonatomic) IBOutlet YICustomTextField  *curLocation;
@property (weak, nonatomic) IBOutlet YICustomTextField  *destionLocation;

@end
