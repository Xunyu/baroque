//
//  BQOrderTableViewCell.h
//  baroque
//
//  Created by Sn Dev on 13-4-11.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQOrderCookWaySelectViewController.h"
@interface BQOrderTableViewCell : UITableViewCell
    <UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *dishName;
@property (weak, nonatomic) IBOutlet UILabel *dishUnitPrice;
@property (weak, nonatomic) IBOutlet UILabel *dishMount;
@property (weak, nonatomic) IBOutlet UILabel *dishCookWay;
@property (weak, nonatomic) IBOutlet UILabel *dishTaste;

@end
