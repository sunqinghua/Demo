//
//  ViewController.m
//  Gif图片加载
//
//  Created by admin on 15/6/23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

@interface ViewController (){
    FLAnimatedImageView *_emotionImageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGitView];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)initGitView{
    FLAnimatedImageView *emotionImageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:emotionImageView];
    _emotionImageView = emotionImageView;
    
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"emotion6" ofType:@"gif"];
    
    NSData *animatedData = [NSData dataWithContentsOfFile:imagePath];
    FLAnimatedImage *animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedData];
    _emotionImageView.animatedImage = animatedImage;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
