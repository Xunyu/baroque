//
//  BQOrderTableViewCell.m
//  baroque
//
//  Created by Sn Dev on 13-4-11.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQOrderTableViewCell.h"

@implementation BQOrderTableViewCell
{
    UIPopoverController *popover;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)dishCookWayEditButtonTouched:(id)sender {

    BQOrderCookWayViewController *vc = [[BQOrderCookWayViewController alloc]initWithStyle:UITableViewStylePlain];
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    [popover presentPopoverFromRect:[sender frame] inView:self.contentView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (IBAction)dishTasteEditButtonTouched:(id)sender {
    BQOrderTasteViewController *vc = [[BQOrderTasteViewController alloc]initWithStyle:UITableViewStylePlain];
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    [popover presentPopoverFromRect:[sender frame] inView:self.contentView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}
@end
