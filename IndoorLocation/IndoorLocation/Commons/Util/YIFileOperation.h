//
//  YIFileOperation.h
//  YIVasMobile
//
//  Created by SUNX on 15/3/24.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIFileOperation : NSObject

#pragma mark 获取保存plist文件目录路径
-(NSString *)getFileDirWithFileDirName:(NSString *)FileDirName;
#pragma mark 将plist文件保存到本地
-(void)savePlistToLocalWithNSMutableDictionary:(NSMutableArray *)data FileDirName:(NSString *)fileDirName fileName:(NSString *)fileName;
#pragma mark 读取本地plist文件
-(NSMutableArray *)getLocalPlistWithFileDirName:(NSString *)fileDirName fileName:(NSString *)fileName;

@end
