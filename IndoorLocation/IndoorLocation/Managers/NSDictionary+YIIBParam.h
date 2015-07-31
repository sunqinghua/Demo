//
//  NSDictionary+YIIBParam.h
//  YIVasMobile
//
//  Created by darren on 14-12-20.
//  Copyright (c) 2014年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YIIBParam)
- (NSTimeInterval)timeIntervalForKey:(id)aKey;
- (id)safeObjectForKey:(id)aKey;
@end
