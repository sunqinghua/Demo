//
//  NSString+Path.m
//  weibo
//
//  Created by mj on 13-3-1.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)
- (NSString *)appendDocumentsDirectory {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:self];
}

- (NSString *)appendDocumentsPushListDirectory {
    //文档路径
    //Caches
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //文件夹起名(多级文件名)
    NSString *fileDir = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"weconex"] stringByAppendingPathComponent:@"db"];
    //判断文件夹是否存在,不存在就创建
    NSFileManager *fileManager = [NSFileManager defaultManager];
    bool isexit=[fileManager fileExistsAtPath:fileDir];
    if (!isexit) {// 如果不存在
        //创建文件夹路径
        [fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [fileDir stringByAppendingPathComponent:self];
}

+(NSString *)getUserLogo{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *logo=[defaults objectForKey:@"logo"];
    if (logo) {
       return logo;
    }else{
        int num = arc4random()%5;
        if (num == 0 ) {
            num =1;
        }
        NSString *name=[NSString stringWithFormat:@"头像%i.png",num];
        [defaults setObject:name forKey:@"logo"];
        [defaults synchronize];
        return name;
    }
}



@end
