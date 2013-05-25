//
//  BQDetailPageViewController.m
//  baroque
//
//  Created by Sn Dev on 13-4-12.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQDetailPageViewController.h"

@interface BQDetailPageViewController ()

@end

@implementation BQDetailPageViewController
@synthesize currentDishID = _currentDishID,menuInfoCount = _menuInfoCount,categoryName = _categoryName;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BQDetailViewController *pageCurrent = [BQDetailViewController detailViewControllerForPageIndex:self.currentDishID
                                                                                     withPageCount:self.menuInfoCount
                                                                                  withCategoryName:self.categoryName];
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
    return [BQDetailViewController detailViewControllerForPageIndex:(index - 1) withPageCount:self.menuInfoCount withCategoryName:self.categoryName];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(BQDetailViewController *)viewController
{
    NSUInteger index = viewController.pageIndex;
    return [BQDetailViewController detailViewControllerForPageIndex:(index + 1) withPageCount:self.menuInfoCount withCategoryName:self.categoryName];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
