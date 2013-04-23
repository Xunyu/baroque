//
//  BQOrderViewController.h
//  baroque
//
//  Created by Sn Dev on 13-4-11.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQOrderTableViewCell.h"
#import "BQPostOrderViewController.h"
@interface BQOrderViewController : UIViewController
    <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *dishTableView;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)confirmOrderTapped:(id)sender;

@end
