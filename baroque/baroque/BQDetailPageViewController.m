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
@synthesize pageViewController = _pageViewController;
@synthesize currentDishID = _currentDishID;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BQDetailViewController *pageCurrent = [BQDetailViewController detailViewControllerForPageIndex:self.currentDishID];
    if (pageCurrent != nil){
        self.pageViewController = [[UIPageViewController alloc]init];
        [self.pageViewController setViewControllers:@[pageCurrent] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
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
    return [BQDetailViewController detailViewControllerForPageIndex:(index - 1)];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(BQDetailViewController *)viewController
{
    NSUInteger index = viewController.pageIndex;
    return [BQDetailViewController detailViewControllerForPageIndex:(index + 1)];
}
- (void)viewDidUnload {
    [self setPageViewController:nil];
    [super viewDidUnload];
}
@end
