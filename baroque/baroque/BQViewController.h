//
//  BQViewController.h
//  baroque
//
//  Created by Sn Dev on 13-4-8.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
//IASK
#import "IASKAppSettingsViewController.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"
//GMGridView
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"
//Other
#import "BQOrderViewController.h"
#import "BQDetailPageViewController.h"
#import "BQSyncMenuInfo.h"
#import "BQCoreDataUtil.h"
#import "Bar_Menu.h"
#import "BQMenuItem.h"
#import "BQItemCountAction.h"
@interface BQViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource,GMGridViewDataSource, GMGridViewActionDelegate,IASKSettingsDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet GMGridView *dishGridView;
@property (strong, nonatomic) IASKAppSettingsViewController *appSettingsViewController;
@property (strong, nonatomic) NSArray *menuInfo;
@property (strong, nonatomic) NSArray *menuFoodType;
- (IBAction)settingButtonTapped:(id)sender;

@end
