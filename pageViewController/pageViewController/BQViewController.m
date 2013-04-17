//
//  BQViewController.m
//  pageViewController
//
//  Created by Sn Dev on 13-4-17.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQViewController.h"

@interface BQViewController ()

@end

@implementation BQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BQDetailViewController *pageZero = [BQDetailViewController detailViewControllerForPageIndex:0];
    if (pageZero != nil){
        self.dataSource = self;
        [self setViewControllers:@[pageZero] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    }
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(BQDetailViewController *)viewController
{
    NSUInteger index = viewController.pageIndex;
    return [BQDetailViewController detailViewControllerForPageIndex:(index - 1)];
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(BQDetailViewController *)viewController
{
    NSUInteger index = viewController.pageIndex;
    return [BQDetailViewController detailViewControllerForPageIndex:(index + 1)];
}
@end
