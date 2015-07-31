//
//  NSUserDefaults+Extensions.h
//  YIVasMobile
//
//  Created by apple on 15/6/18.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extensions)


+ (void)syncSetObject:(id)value forKey:(NSString *)keyName;

+ (NSString *)stringWithKey:(NSString *)keyName;


@end
