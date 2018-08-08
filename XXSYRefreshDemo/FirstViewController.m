//
//  FirstViewController.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/7/2.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "FirstViewController.h"
#import "XXSYMediator+Test.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(readViewController_Test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, 200, 200)];
    btn2.backgroundColor = [UIColor yellowColor];
    [btn2 addTarget:self action:@selector(btn2ClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnClickAction:(UIButton*)btn
{
    UIViewController *viewController = [[XXSYMediator sharedMediator] XXSYMediator_TestViewController];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)btn2ClickAction:(UIButton*)btn
{
    [[XXSYMediator sharedMediator] XXSYMediator_ShowAlertWithMessage:@"傻逼" cancelAction:^(NSDictionary *info) {
        NSLog(@"%@",info);
    } confirmAction:^(NSDictionary *info) {
        NSLog(@"%@",info);
    }];
}

- (void)coreTextTest
{
    UIViewController *viewController = [[XXSYMediator sharedMediator] XXSYMediator_CoreTextViewController];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)readViewController_Test
{
    UIViewController *viewController = [[XXSYMediator sharedMediator] XXSYMediator_ReadViewController];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];

}
@end
