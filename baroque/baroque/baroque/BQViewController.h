//
//  BQViewController.h
//  baroque
//
//  Created by Sn Dev on 13-4-8.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"
#import "GMGridViewLayoutStrategies.h"

@interface BQViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource,GMGridViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet GMGridView *dishGridView;

@end
