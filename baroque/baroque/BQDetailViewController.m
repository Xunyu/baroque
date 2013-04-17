//
//  BQDetailViewController.m
//  baroque
//
//  Created by Sn Dev on 13-4-12.
//  Copyright (c) 2013年 Baroque. All rights reserved.
//

#import "BQDetailViewController.h"

@interface BQDetailViewController ()
{
    NSUInteger _pageIndex;
    UIPopoverController *popover;
}
@end

@implementation BQDetailViewController
@synthesize dishName = _dishName;
+ (BQDetailViewController *)detailViewControllerForPageIndex:(NSUInteger)pageIndex
{
    if (pageIndex<25){
        return [[self alloc] initWithPageIndex:pageIndex];
    }
    return nil;
}
- (NSInteger)pageIndex
{
    return _pageIndex;
}
- (id)initWithPageIndex:(NSInteger)pageIndex
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _pageIndex = pageIndex;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dishName.text = [NSString stringWithFormat:@"我是菜 %d",self.pageIndex];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDishImageView:nil];
    [self setDishName:nil];
    [self setDishUnitPrice:nil];
    [self setDishDescription:nil];
    [self setDishMount:nil];
    [self setDishCookWay:nil];
    [self setDishTaste:nil];
    [super viewDidUnload];
}
- (IBAction)dishTasteEditButtonTouched:(id)sender {
    BQOrderTasteViewController *vc = [[BQOrderTasteViewController alloc]initWithStyle:UITableViewStylePlain];
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    [popover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (IBAction)dishCookWayEditButtonTouched:(id)sender {
    BQOrderCookWayViewController *vc = [[BQOrderCookWayViewController alloc]initWithStyle:UITableViewStylePlain];
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    [popover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (IBAction)backButtonTouched:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
