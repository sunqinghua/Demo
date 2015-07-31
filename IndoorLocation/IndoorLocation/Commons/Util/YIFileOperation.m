//
//  YIFileOperation.m
//  YIVasMobile
//
//  Created by SUNX on 15/3/24.
//  Copyright (c) 2015年 YixunInfo Inc. All rights reserved.
//

#import "YIFileOperation.h"

@implementation YIFileOperation

#pragma mark 获取本地文件夹存储路径
-(NSString *)getFileDirWithFileDirName:(NSString *)FileDirName{
    //文档路径
    //Caches
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //文件夹起名(多级文件名)
    NSString *fileDir = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"yingtong"] stringByAppendingPathComponent:FileDirName];
    //判断文件夹是否存在,不存在就创建
    NSFileManager *fileManager = [NSFileManager defaultManager];
    bool isexit=[fileManager fileExistsAtPath:fileDir];
    if (!isexit) {// 如果不存在
        //创建文件夹路径
        [fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return fileDir;
}


#pragma mark 将plist文件保存到本地
-(void)savePlistToLocalWithNSMutableDictionary:(NSMutableArray *)data FileDirName:(NSString *)fileDirName fileName:(NSString *)fileName{
    //文件夹路径
    NSString *fileDir = [self getFileDirWithFileDirName:fileDirName];
    //文件名
    NSString *file=[fileDir stringByAppendingPathComponent:fileName];
    //写到本地
    [data writeToFile:file atomically:YES];
}

#pragma mark 读取本地plist文件
-(NSMutableArray *)getLocalPlistWithFileDirName:(NSString *)fileDirName fileName:(NSString *)fileName{
    //文件夹路径
    NSString *fileDir = [self getFileDirWithFileDirName:fileDirName];
    //文件名
    NSString *file=[fileDir stringByAppendingPathComponent:fileName];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:file];
    return data;
}

@end
