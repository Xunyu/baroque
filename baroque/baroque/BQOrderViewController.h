//
//  BQOrderViewController.h
//  baroque
//
//  Created by Sn Dev on 13-4-11.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "BQOrderTableViewCell.h"
#import "BQPostOrderViewController.h"
#import "Bar_OrderDetail.h"
#import "BQCoreDataUtil.h"
#import "Bar_Menu.h"
@interface BQOrderViewController : UIViewController
    <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *dishTableView;
@property (nonatomic, strong) NSMutableArray *orderDetailArray;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (assign, nonatomic) unsigned int totalPriceNum;



- (IBAction)backButtonTapped:(id)sender;
- (IBAction)confirmOrderTapped:(id)sender;
- (IBAction)checkOrderButtonTapped:(id)sender;


@end
