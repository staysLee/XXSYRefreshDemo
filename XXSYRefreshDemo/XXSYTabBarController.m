//
//  XXSYTabBarController.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/3.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "XXSYTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "XXSYTabBar.h"

@interface XXSYTabBarController ()

@end

@implementation XXSYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTabBar];
    [self addChildViewControllers];
    [self addTabBarItems];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTabBar
{
    XXSYTabBar *tabBar = [[XXSYTabBar alloc] init];
    tabBar.centerBlock = ^{
        NSLog(@"我点击了中心");
    };
    [self setValue:tabBar forKey:@"tabBar"];
}


- (void)addChildViewControllers
{
    UINavigationController *nav_first = [[UINavigationController alloc] initWithRootViewController:[[FirstViewController alloc] init]];
    UINavigationController *nav_second = [[UINavigationController alloc] initWithRootViewController:[[SecondViewController alloc] init]];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:[[ThirdViewController alloc] init]];
    UINavigationController *nav_fourth = [[UINavigationController alloc] initWithRootViewController:[[FirstViewController alloc] init]];
    self.viewControllers = @[nav_first,nav_second,nav_third,nav_fourth];
}
- (void)addTabBarItems
{
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"首页",
                                                 @"TabBarItemImage" : @"tabBar_essence_icon",
                                                 @"TabBarItemSelectedImage" : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"书架",
                                                  @"TabBarItemImage" : @"tabBar_friendTrends_icon",
                                                  @"TabBarItemSelectedImage" : @"tabBar_friendTrends_click_icon",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 @"TabBarItemTitle" : @"发现",
                                                 @"TabBarItemImage" : @"tabBar_new_icon",
                                                 @"TabBarItemSelectedImage" : @"tabBar_new_click_icon",
                                                 };
    
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  @"TabBarItemTitle" : @"个人中心",
                                                  @"TabBarItemImage" : @"tabBar_me_icon",
                                                  @"TabBarItemSelectedImage" : @"tabBar_me_click_icon"
                                                  };
    
    NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                                        firstTabBarItemsAttributes,
                                                        thirdTabBarItemsAttributes,
                                                        secondTabBarItemsAttributes,
                                                        fourthTabBarItemsAttributes
                                                        ];
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
        obj.tabBarItem.image = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]];
        obj.tabBarItem.selectedImage = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]];
        obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }];
    self.tabBar.tintColor = [UIColor redColor];
}

@end
