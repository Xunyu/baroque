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
@synthesize orderDetailArray = _orderDetailArray,dishTableView = _dishTableView;

- (NSArray*)orderDetailArray
{
    if (_orderDetailArray == nil){
        NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bar_OrderDetail" inManagedObjectContext:[BQCoreDataUtil sharedInstance].managedObjectContext];
        [fetch setEntity:entity];
        NSError *error = nil;
        _orderDetailArray = [[[BQCoreDataUtil sharedInstance].managedObjectContext executeFetchRequest:fetch error:&error]mutableCopy];
    }
    return _orderDetailArray;
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orderDetailArray count];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.orderDetailArray removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"orderDiskInfomationCell";
    BQOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[BQOrderTableViewCell alloc]init];
    }
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    [fetch setEntity:[NSEntityDescription entityForName:@"Bar_Menu" inManagedObjectContext:[BQCoreDataUtil sharedInstance].managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"foodID = %@",[((Bar_OrderDetail*)[self.orderDetailArray objectAtIndex:[indexPath row]])menuID]];
    [fetch setPredicate:predicate];
    NSError *error = nil;
    NSArray *result = [[BQCoreDataUtil sharedInstance].managedObjectContext executeFetchRequest:fetch error:&error];
    if (result!=nil && result.count > 0 ){
        Bar_Menu *item = [result lastObject];
        cell.dishName.text = [item foodName];
        cell.dishUnitPrice.text = [[item price]stringValue];
        [cell.dishImageView setImageWithURL:[NSURL URLWithString:[item picUrl]]];
        [cell.dishImageView.layer setCornerRadius:6.0f];
        [cell.dishImageView.layer setMasksToBounds:YES];
        cell.tag = [[item foodID]intValue];
    }
    cell.dishMount.text = [[((Bar_OrderDetail*)[self.orderDetailArray objectAtIndex:[indexPath row]])count]stringValue];
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
