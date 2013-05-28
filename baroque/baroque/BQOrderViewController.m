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
@synthesize totalPrice = _totalPrice,totalPriceNum = _totalPriceNum;

- (unsigned int)totalPriceNum
{
    _totalPriceNum = 0;
    if (self.orderDetailArray != nil){
        for (Bar_OrderDetail *detail in self.orderDetailArray) {
            _totalPriceNum = _totalPriceNum + [detail.count intValue] * [detail.menuIDrelationship.price intValue];
        }
    }
    return _totalPriceNum;
}
- (NSArray*)orderDetailArray
{
    if (_orderDetailArray == nil){
        _orderDetailArray = [[BQCoreDataUtil fetchDataWithEntity:@"Bar_OrderDetail"]mutableCopy];
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
    Bar_Menu *item = [[self.orderDetailArray objectAtIndex:[indexPath row]] menuIDrelationship];
    cell.dishName.text = [item foodName];
    cell.dishName.text = [item foodName];
    cell.dishUnitPrice.text = [[item price]stringValue];
    [cell.dishImageView setImageWithURL:[NSURL URLWithString:[item picUrl]]];
    [cell.dishImageView.layer setCornerRadius:6.0f];
    [cell.dishImageView.layer setMasksToBounds:YES];
    cell.dishMount.text = [[[item foodIDrelationship]count]stringValue];
    cell.tag = [[item foodID]intValue];
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

- (IBAction)checkOrderButtonTapped:(id)sender {
    
}
#pragma mark - ViewController
- (void)refreshTotalPrice
{
    self.totalPrice.text = [NSString stringWithFormat:@"总价 %d ￥",self.totalPriceNum];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self refreshTotalPrice];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTotalPrice) name:@"refreshTotalPrice" object:nil];
}
- (void)viewDidUnload {
    [self setTotalPrice:nil];
    [super viewDidUnload];
}
@end
