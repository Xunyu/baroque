//
//  BQMenuItem.h
//  baroque
//
//  Created by Sn Dev on 13-5-23.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQItemCountAction.h"

@interface BQMenuItem : UIView

@property (nonatomic, strong) NSNumber *foodID;

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
@property (weak, nonatomic) IBOutlet UILabel *itemCount;
- (IBAction)itemPlusButtonPressed:(id)sender;
- (IBAction)itemMinusButtonPressed:(id)sender;

@end
