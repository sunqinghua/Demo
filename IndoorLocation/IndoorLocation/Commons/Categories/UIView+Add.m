//
//  UIView+Add.m
//  YIVasMobile
//
//  Created by SUNX on 15/3/27.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

@end
