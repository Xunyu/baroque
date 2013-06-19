//
//  BQViewController.h
//  baroque
//
//  Created by Sn Dev on 13-4-8.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQAppDelegate.h"
//IASK
#import "IASKAppSettingsViewController.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"
//Other
#import "BQOrderViewController.h"
#import "BQDetailPageViewController.h"
#import "BQSyncMenuInfo.h"
#import "BQCoreDataUtil.h"
#import "Bar_Menu.h"
#import "BQMenuItem.h"
#import "BQItemCountAction.h"
#import "BQMenuGridViewController.h"
#import "PSStackedView.h"
@interface BQViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource,IASKSettingsDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (strong, nonatomic) IASKAppSettingsViewController *appSettingsViewController;
@property (strong, nonatomic) NSArray *menuInfo;
@property (strong, nonatomic) NSArray *menuFoodType;
@property (strong, nonatomic) NSArray *categoryMenuInfo;
- (IBAction)settingButtonTapped:(id)sender;

@end
