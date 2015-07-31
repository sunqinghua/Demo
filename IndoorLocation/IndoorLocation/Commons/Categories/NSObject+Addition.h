//
//  NSObject+Addition.h
//  weibo
//
//  Created by mj on 13-3-1.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Addition)

- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;

@end
