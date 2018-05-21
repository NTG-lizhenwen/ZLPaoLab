//
//  ViewController.m
//  ZLPaoLab
//
//  Created by ZhenwenLi on 2018/5/18.
//  Copyright © 2018年 lizhenwen. All rights reserved.
//

#import "ViewController.h"

#import "ZLPaoLabView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZLPaoLabView *pao=[[ZLPaoLabView alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    pao.backgroundColor=[UIColor clearColor];
    pao.center=self.view.center;
    pao.text=@"在人生的旅途中，不必在乎目的地，在乎的是沿途的风景和看风景的心情！";
    pao.textColor=[UIColor blackColor];
    
    
    
    
    [self.view addSubview:pao];
    [pao prepare];
    
    [pao zl_addAttributeTapActionWithStrings:@[@"不必在乎目的地，"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSLog(@"点击 。。。。。。。：：：%@",string);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
