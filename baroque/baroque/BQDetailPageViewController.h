//
//  BQDetailPageViewController.h
//  baroque
//
//  Created by Sn Dev on 13-4-12.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQDetailViewController.h"
@interface BQDetailPageViewController : UIPageViewController
    <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (strong, nonatomic) IBOutlet UIPageViewController *pageViewController;
@property (assign, nonatomic) int currentDishID;
@end
