//
//  NSString+size.h
//  YIVasMobile
//
//  Created by SUNX on 15/3/24.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (size)


//计算文本的size
-(CGSize)boundingRectWithSize:(CGSize)size
                 withTextFont:(UIFont *)font
              withLineSpacing:(CGFloat)lineSpacing;
@end
