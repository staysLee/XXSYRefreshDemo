//
//  XXSYCoreTextViewController.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/6.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYCoreTextViewController.h"
#import "XXSYCoreTextView.h"
#import "UIView+MJExtension.h"
#import "CTDisplayView.h"
#import "CTFrameParser.h"
#import "ImageCoreTextView.h"


@interface XXSYCoreTextViewController ()

@end

@implementation XXSYCoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self imageCoreText_Test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customStart_Test
{
    XXSYCoreTextView *coreTextView = [[XXSYCoreTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, 200)];
    coreTextView.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:coreTextView];
    coreTextView.center = CGPointMake(self.view.mj_w/2.0, self.view.mj_h/2.0);
}

//唐巧---CTFrameParser
- (void)CTFrameParser_Test
{
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor blackColor];
    config.width = self.view.mj_w;
    
    CoreTextData *data = [CTFrameParser parseContent:@"按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。按照以上原则，我们将`view`asdadew`中的部分内容拆开。按照以上原则，我们将`view`中的部分内容拆开。" config:config];
    
    CTDisplayView *displayView = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, data.height)];
    displayView.backgroundColor = [UIColor redColor];
    displayView.data = data;
    [self.view addSubview:displayView];
    displayView.center = CGPointMake(self.view.mj_w/2.0, self.view.mj_h/2.0);
}

//富文本，图文混排
- (void)imageCoreText_Test
{
    ImageCoreTextView *view = [[ImageCoreTextView alloc] initWithFrame:CGRectMake(0, 64, self.view.mj_w, 200)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    view.center = CGPointMake(self.view.mj_w/2.0, self.view.mj_h/2.0);
}

@end
