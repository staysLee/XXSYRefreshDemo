//
//  ReadContentViewController.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/8.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "ReadContentViewController.h"
#define kRandomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f])

@interface ReadContentViewController ()

@end

@implementation ReadContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 100)];
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = kRandomColor;
    contentLabel.text = self.content;
    [self.view addSubview:contentLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
