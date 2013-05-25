//
//  BQPostOrderViewController.m
//  baroque
//
//  Created by Sn Dev on 13-4-18.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQPostOrderViewController.h"

@interface BQPostOrderViewController ()

@end

@implementation BQPostOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)backButtonTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)confirmPostButtonTapped:(id)sender {
    [[BQCommitOrder sharedInstance]beginCommitOrderWithPeopleCount:[self.peopleCount.text intValue] withTableID:[self.tableID.text intValue]];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setUserNumber:nil];
    [self setUserPassword:nil];
    [self setPeopleCount:nil];
    [self setTableID:nil];
    [super viewDidUnload];
}
@end
