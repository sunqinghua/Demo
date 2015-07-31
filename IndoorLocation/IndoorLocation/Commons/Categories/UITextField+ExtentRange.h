//
//  UITextField(ExtentRange).h
//  YIVasMobile
//
//  Created by song on 14/12/11.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)


-(NSRange) selectedRange;
-(void) setSelectedRange:(NSRange) range;

@end
