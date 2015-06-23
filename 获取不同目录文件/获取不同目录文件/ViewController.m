//
//  ViewController.m
//  获取不同目录文件
//
//  Created by admin on 15/6/23.
//  Copyright (c) 2015年 admin. All rights reserved.
//


/*
 *
 
 iphone沙箱模型的有四个文件夹，分别是什么，永久数据存储一般放在什么位置，得到模拟器的路径的简单方式是什么.
 
 documents，tmp，app，Library。
 
 （NSHomeDirectory()），
 
 手动保存的文件在documents文件里
 
 Nsuserdefaults保存的文件在tmp文件夹里
 
 
 1、Documents 目录：您应该将所有de应用程序数据文件写入到这个目录下。这个目录用于存储用户数据或其它应该定期备份的信息。
 
 2、AppName.app 目录：这是应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，所以您在运行时不能对这个目录中的内容进行修改，否则可能会使应用程序无法启动。
 
 3、Library 目录：这个目录下有两个子目录：Caches 和 Preferences
 Preferences 目录：包含应用程序的偏好设置文件。您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.
 Caches 目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。
 
 4、tmp 目录：这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息。
 
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -资源包图片
-(void)capture{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"emotion6" ofType:@"gif"];
    NSData *animatedData = [NSData dataWithContentsOfFile:imagePath];
}

-(void)fileManager{
    NSFileManager *fileMansger=[NSFileManager defaultManager];
    
    //创建
    //fileMansger createDirectoryAtPath:<#(NSString *)#> withIntermediateDirectories:<#(BOOL)#> attributes:<#(NSDictionary *)#> error:<#(NSError *__autoreleasing *)#>
    //是否存在
    //fileMansger fileExistsAtPath:<#(NSString *)#> isDirectory:<#(BOOL *)#>
    //删除文件
    //fileMansger removeItemAtPath:<#(NSString *)#> error:<#(NSError *__autoreleasing *)#>
    //文件属性
    //fileMansger attributesOfItemAtPath:<#(NSString *)#> error:<#(NSError *__autoreleasing *)#>
}

-(void)queryHome{
    // 获取沙盒主目录路径
    NSString *homeDir = NSHomeDirectory();
    // 获取Documents目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    // 获取tmp目录路径
    NSString *tmpDir =  NSTemporaryDirectory();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
