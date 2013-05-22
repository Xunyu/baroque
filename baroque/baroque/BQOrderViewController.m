//
//  BQOrderViewController.m
//  baroque
//
//  Created by Sn Dev on 13-4-11.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQOrderViewController.h"

@interface BQOrderViewController ()
{
    BQPostOrderViewController *postOrderViewController;
}
@end

@implementation BQOrderViewController




#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"orderDiskInfomationCell";
    BQOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[BQOrderTableViewCell alloc]init];
    }
    cell.dishName.text = @"asdfasdfsadfasdf";
    cell.dishUnitPrice.text = @"800";
    cell.dishMount.text = @"12";
    return cell;

}
- (IBAction)backButtonTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)confirmOrderTapped:(id)sender {
    postOrderViewController = [[BQPostOrderViewController alloc]init];
    postOrderViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    postOrderViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:postOrderViewController animated:YES];
    postOrderViewController.view.superview.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    postOrderViewController.view.superview.frame = CGRectMake(
                                          [UIScreen mainScreen].applicationFrame.size.height/2-150,
                                          [UIScreen mainScreen].applicationFrame.size.width/2-150,
                                          300.0f,
                                          300.0f
                                          );
}
@end
