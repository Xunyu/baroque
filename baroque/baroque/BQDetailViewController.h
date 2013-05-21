//
//  BQDetailViewController.h
//  baroque
//
//  Created by Sn Dev on 13-4-12.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQOrderCookWayViewController.h"
#import "BQOrderTasteViewController.h"
#import "BQCoreDataUtil.h"
#import "Bar_Menu.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface BQDetailViewController : UIViewController
@property (nonatomic, strong) NSArray *menuInfo;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishName;
@property (weak, nonatomic) IBOutlet UILabel *dishUnitPrice;
@property (weak, nonatomic) IBOutlet UITextView *dishDescription;
@property (weak, nonatomic) IBOutlet UILabel *dishMount;
@property (weak, nonatomic) IBOutlet UILabel *dishCookWay;
@property (weak, nonatomic) IBOutlet UILabel *dishTaste;

- (IBAction)dishTasteEditButtonTouched:(id)sender;
- (IBAction)dishCookWayEditButtonTouched:(id)sender;
- (IBAction)backButtonTouched:(id)sender;
- (IBAction)dishMountPlus:(id)sender;
- (IBAction)dishMountMinus:(id)sender;


+ (BQDetailViewController *)detailViewControllerForPageIndex:(NSUInteger)pageIndex withPageCount:(NSUInteger)pageCount;
- (NSInteger)pageIndex;
@end
