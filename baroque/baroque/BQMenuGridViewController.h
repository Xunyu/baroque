//
//  BQMenuGridViewController.h
//  baroque
//
//  Created by Sn Dev on 13-6-19.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "BQAppDelegate.h"
#import "BQMenuItem.h"
#import "Bar_Menu.h"
#import "JWFolders.h"
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
#import "BQDetailPageViewController.h"
@interface BQMenuGridViewController : UIViewController
    <GMGridViewDataSource, GMGridViewActionDelegate>
@property (strong, nonatomic) IBOutlet GMGridView *dishGridView;
@property (strong, nonatomic) NSArray *categoryMenuInfo;
@property (strong, nonatomic) NSString *selectedCategoryName;

@end
