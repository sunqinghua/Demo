//
//  NSString+Path.h
//  weibo
//
//  Created by mj on 13-3-1.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)
- (NSString *)appendDocumentsDirectory;

- (NSString *)appendDocumentsPushListDirectory;

+(NSString *)getUserLogo;
@end
