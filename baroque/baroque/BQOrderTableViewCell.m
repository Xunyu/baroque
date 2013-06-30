//
//  BQOrderTableViewCell.m
//  baroque
//
//  Created by Sn Dev on 13-4-11.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQOrderTableViewCell.h"
#import "BQItemCountAction.h"
#import "BQOrderViewController.h"
@implementation BQOrderTableViewCell
{
    UIPopoverController *popover;
}
@synthesize array=_array;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)popOverButtonTouched:(id)sender {
    NSLog(@"sender: %@, tag = %d", sender, [sender tag]);
    if (!self.array)
    {
        self.array = [[NSArray alloc] initWithObjects:
                      [[BQOrderCookWayViewController alloc]initWithStyle:UITableViewStylePlain],
                      [[BQOrderTasteViewController alloc]initWithStyle:UITableViewStylePlain],nil];
    }
    UIViewController *vc = [self.array objectAtIndex:[sender tag]];
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    [popover presentPopoverFromRect:[sender frame] inView:self.contentView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (IBAction)dishCountPlusButtonPressed:(id)sender {
    self.dishMount.text = [BQItemCountAction itemCountPlusWithFoodID:[NSNumber numberWithInt:self.tag]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTotalPrice" object:nil];
}

- (IBAction)dishCountMinusButtonPressed:(id)sender {
    self.dishMount.text = [BQItemCountAction itemCountMinusWithFoodID:[NSNumber numberWithInt:self.tag]];
    if ([self.dishMount.text isEqualToString:@"0"]){
        if ([self.superview isKindOfClass:[UITableView class]]){
            UITableView *table = (UITableView*)self.superview;
            NSIndexPath *index = [table indexPathForCell:self];
            [[table dataSource]tableView:table commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:index];
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshTotalPrice" object:nil];
}
@end
