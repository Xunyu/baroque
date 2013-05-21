//
//  BQDetailPageViewController.m
//  baroque
//
//  Created by Sn Dev on 13-4-12.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQDetailPageViewController.h"

@interface BQDetailPageViewController ()
{
    NSArray *detailViewControllers;
}
@end

@implementation BQDetailPageViewController
@synthesize currentDishID = _currentDishID,menuInfoCount = _menuInfoCount;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BQDetailViewController *pageCurrent = [BQDetailViewController detailViewControllerForPageIndex:self.currentDishID withPageCount:self.menuInfoCount];
    if (pageCurrent != nil){
        self.dataSource = self;
        [self setViewControllers:@[pageCurrent] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIPageViewController Datasource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(BQDetailViewController *)viewController
{
    NSUInteger index = viewController.pageIndex;
    return [BQDetailViewController detailViewControllerForPageIndex:(index - 1) withPageCount:self.menuInfoCount];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(BQDetailViewController *)viewController
{
    NSUInteger index = viewController.pageIndex;
    return [BQDetailViewController detailViewControllerForPageIndex:(index + 1) withPageCount:self.menuInfoCount];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
