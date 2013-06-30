//
//  BQOrderTableViewCell.h
//  baroque
//
//  Created by Sn Dev on 13-4-11.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQOrderCookWayViewController.h"
#import "BQOrderTasteViewController.h"
@interface BQOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dishName;
@property (weak, nonatomic) IBOutlet UILabel *dishUnitPrice;
@property (weak, nonatomic) IBOutlet UILabel *dishMount;
@property (weak, nonatomic) IBOutlet UILabel *dishCookWay;
@property (weak, nonatomic) IBOutlet UILabel *dishTaste;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;

@property (strong,nonatomic) NSArray *array;

- (IBAction)dishCookWayEditButtonTouched:(id)sender;
- (IBAction)dishTasteEditButtonTouched:(id)sender;
- (IBAction)dishCountPlusButtonPressed:(id)sender;
- (IBAction)dishCountMinusButtonPressed:(id)sender;

@end
