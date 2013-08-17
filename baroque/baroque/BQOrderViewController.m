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
    int currentOrderNo;
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
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"orderID = %d",currentOrderNo];
        _orderDetailArray = [[BQCoreDataUtil fetchDataWithEntity:@"Bar_OrderDetail" andWithPredicate:predicate]mutableCopy];
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
    cell.dishMount.text = [[(Bar_OrderDetail*)[self.orderDetailArray objectAtIndex:[indexPath row]]count]stringValue];
    cell.tag = [[item foodID]intValue];
    return cell;

}
- (IBAction)backButtonTapped:(id)sender {
    if ([self.backButton.titleLabel.text isEqualToString:@"返回"]){
        [self.backButton setTitle:@"继续点菜" forState:UIControlStateNormal];
        [self.confirmOrderButton setHidden:NO];
        [self.checkOrderButton setHidden:NO];
        [self.orderNo setHidden:YES];
        [self.orderTime setHidden:YES];
        currentOrderNo = 0;
        _orderDetailArray = nil;
        [self.dishTableView reloadData];
        [self refreshTotalPrice];
    }
    else{
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)confirmOrderTapped:(id)sender {
    if ([self.orderDetailArray count]>0){
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
}

- (IBAction)checkOrderButtonTapped:(id)sender {
    currentOrderNo = [[UserDefault restoreFromUserDefaults:@"lastOrderId"]intValue];
    if (currentOrderNo != 0){
        [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
        [self.confirmOrderButton setHidden:YES];
        [self.checkOrderButton setHidden:YES];
        [self.orderNo setHidden:NO];
        [self.orderTime setHidden:NO];
        _orderDetailArray = nil;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"orderID = %d",currentOrderNo];
        Bar_Order *checkOrder = [[BQCoreDataUtil fetchDataWithEntity:@"Bar_Order" andWithPredicate:predicate]lastObject];
        [self.orderNo setText:[NSString stringWithFormat:@"订单号: %d",currentOrderNo]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *date = [dateFormatter stringFromDate:checkOrder.addDate];
        [self.orderTime setText:[NSString stringWithFormat:@"订单时间: %@",date]];
        [self.dishTableView reloadData];
        [self refreshTotalPrice];
    }
}
#pragma mark - ViewController
- (void)refreshTotalPrice
{
    self.totalPrice.text = [NSString stringWithFormat:@"总价 %d ￥",self.totalPriceNum];
}
- (void)refreshOrderDetail
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self refreshTotalPrice];
    currentOrderNo = 0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTotalPrice) name:@"refreshTotalPrice" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshOrderDetail) name:@"refreshOrderDetail" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]];
}
- (void)viewDidUnload {
    [self setTotalPrice:nil];
    [self setOrderNo:nil];
    [self setOrderTime:nil];
    [self setBackButton:nil];
    [self setCheckOrderButton:nil];
    [self setConfirmOrderButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}
- (BOOL)shouldAutorotate{
    return YES;
}
@end
