//
//  ReadViewController.m
//  XXSYRefreshDemo
//
//  Created by liming on 2018/8/8.
//  Copyright © 2018年 stayslee. All rights reserved.
//

#import "ReadViewController.h"
#import "ReadContentViewController.h"


@interface ReadViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *pageContentArray;
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ReadContentViewController *initialViewController = [self viewControllerAtIndex:0];
    [self.pageViewController setViewControllers:@[initialViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.view.frame = self.view.bounds;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        /***********翻页方式
         NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
         **********/
        
        //滚动翻页
        NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(20)};
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:options];
        
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

- (NSArray *)pageContentArray
{
    if (!_pageContentArray) {
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i =0; i<10; i++) {
            NSString *contentString = [NSString stringWithFormat:@"This is the page %d of content displayed using UIPageViewController",i];
            [arrayM addObject:contentString];
        }
        _pageContentArray = [[NSArray alloc]initWithArray:arrayM];
    }
    return _pageContentArray;
}

- (ReadContentViewController *)viewControllerAtIndex:(NSInteger)index
{
    if (self.pageContentArray.count==0 || index >= self.pageContentArray.count) {
        return nil;
    }
    ReadContentViewController *contentVC = [[ReadContentViewController alloc]init];
    contentVC.content = [self.pageContentArray objectAtIndex:index];
    return contentVC;
    
}

- (NSUInteger)indexOfViewController:(ReadContentViewController *)contentVC
{
    return [self.pageContentArray indexOfObject:contentVC.content];
}

#pragma mark --
- ( UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger  index = [self indexOfViewController:(ReadContentViewController *)viewController];
    if (index == NSNotFound || index==0 ) {
        return nil;
    }
    index --;
    return [self viewControllerAtIndex:index];
}
- ( UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ReadContentViewController *)viewController];
    if (index==NSNotFound || index==self.pageContentArray.count-1) {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
}
@end
